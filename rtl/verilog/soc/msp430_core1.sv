////////////////////////////////////////////////////////////////////////////////
//                                            __ _      _     _               //
//                                           / _(_)    | |   | |              //
//                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              //
//               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              //
//              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              //
//               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              //
//                  | |                                                       //
//                  |_|                                                       //
//                                                                            //
//                                                                            //
//              MSP430 CPU                                                    //
//              Processing Unit                                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/* Copyright (c) 2015-2016 by the author(s)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * =============================================================================
 * Author(s):
 *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
 */

`include "msp430_defines.sv"

module msp430_core1 (
  // CPU registers
  output        [15:0] r0,
  output        [15:0] r1,
  output        [15:0] r2,
  output        [15:0] r3,
  output        [15:0] r4,
  output        [15:0] r5,
  output        [15:0] r6,
  output        [15:0] r7,
  output        [15:0] r8,
  output        [15:0] r9,
  output        [15:0] r10,
  output        [15:0] r11,
  output        [15:0] r12,
  output        [15:0] r13,
  output        [15:0] r14,
  output        [15:0] r15,

  // Debug interface
  output               dbg_en,
  output               dbg_clk,
  output               dbg_rst,

  // Interrupt detection
  output               irq_detect,
  output               nmi_pnd,

  output         [2:0] i_state,
  output         [3:0] e_state,
  output               decode,
  output        [15:0] ir,
  output        [ 5:0] irq_num,
  output        [15:0] pc,

  // CPU internals
  output               mclk,
  output               puc_rst,

  // Clock & Reset
  input                dco_clk,              // Fast oscillator (fast clock)
  input                reset_n,              // Reset Pin (low active, asynchronous and non-glitchy)

  // Serial Debug Interface (I2C)
  input          [6:0] dbg_i2c_addr,         // Debug interface: I2C Address
  input          [6:0] dbg_i2c_broadcast,    // Debug interface: I2C Broadcast Address (for multicore systems)
  input                dbg_i2c_scl,          // Debug interface: I2C SCL
  input                dbg_i2c_sda_in,       // Debug interface: I2C SDA IN
  output               dbg_i2c_sda_out,      // Debug interface: I2C SDA OUT

  // Data Memory
  input         [15:0] dmem_dout,            // Data Memory data output
  output [`DMEM_MSB:0] dmem_addr,            // Data Memory address
  output               dmem_cen,             // Data Memory chip enable (low active)
  output        [15:0] dmem_din,             // Data Memory data input
  output        [ 1:0] dmem_wen,             // Data Memory write enable (low active)

  // Program Memory
  input         [15:0] pmem_dout,            // Program Memory data output
  output [`PMEM_MSB:0] pmem_addr,            // Program Memory address
  output               pmem_cen,             // Program Memory chip enable (low active)
  output        [15:0] pmem_din,             // Program Memory data input (optional)
  output        [ 1:0] pmem_wen,             // Program Memory write enable (low active) (optional)

  // LEDs
  input          [3:0] switch,               // Input switches
  output         [1:0] led                   // LEDs
);

  //=============================================================================
  // 1)  INTERNAL WIRES/REGISTERS/PARAMETERS DECLARATION
  //=============================================================================

  // Clock & Reset
  wire               aclk_en;
  wire               smclk_en;

  // Debug interface
  wire               dbg_freeze;

  // Peripheral bus
  wire        [13:0] per_addr;
  wire        [15:0] per_din;
  wire        [ 1:0] per_we;
  wire               per_en;
  wire        [15:0] per_dout;

  // Interrupts
  wire        [13:0] irq_acc;
  wire        [13:0] irq_bus;
  wire               nmi;

  // GPIO
  wire               irq_port1;
  wire               irq_port2;
  wire        [ 7:0] p1_din;
  wire        [ 7:0] p1_dout;
  wire        [ 7:0] p1_dout_en;
  wire        [ 7:0] p1_sel;
  wire        [ 7:0] p2_din;
  wire        [ 7:0] p2_dout;
  wire        [ 7:0] p2_dout_en;
  wire        [ 7:0] p2_sel;
  wire        [15:0] per_dout_gpio;

  // Timer A
  wire        [15:0] per_dout_tA;

  //=============================================================================
  // 2)  OPENMSP430 CORE
  //=============================================================================

  msp430_pu #(
    .INST_NR  (1),
    .TOTAL_NR (1)
  )
  msp430_pu_0 (

    // OUTPUTs
    .r0                (r0),
    .r1                (r1),
    .r2                (r2),
    .r3                (r3),
    .r4                (r4),
    .r5                (r5),
    .r6                (r6),
    .r7                (r7),
    .r8                (r8),
    .r9                (r9),
    .r10               (r10),
    .r11               (r11),
    .r12               (r12),
    .r13               (r13),
    .r14               (r14),
    .r15               (r15),

    .dbg_clk           (dbg_clk),
    .dbg_rst           (dbg_rst),
    .irq_detect        (irq_detect),
    .nmi_detect        (nmi_pnd),

    .i_state           (i_state),
    .e_state           (e_state),
    .decode            (decode),
    .ir                (ir),
    .irq_num           (irq_num),
    .pc                (pc),

    .nodiv_smclk       (),

    .aclk              (),                   // ASIC ONLY: ACLK
    .aclk_en           (aclk_en),            // FPGA ONLY: ACLK enable
    .dbg_freeze        (dbg_freeze),         // Freeze peripherals
    .dbg_i2c_sda_out   (dbg_i2c_sda_out),    // Debug interface: I2C SDA OUT
    .dbg_uart_txd      (),                   // Debug interface: UART TXD
    .dco_enable        (),                   // ASIC ONLY: Fast oscillator enable
    .dco_wkup          (),                   // ASIC ONLY: Fast oscillator wake-up (asynchronous)
    .dmem_addr         (dmem_addr),          // Data Memory address
    .dmem_cen          (dmem_cen),           // Data Memory chip enable (low active)
    .dmem_din          (dmem_din),           // Data Memory data input
    .dmem_wen          (dmem_wen),           // Data Memory write enable (low active)
    .irq_acc           (irq_acc),            // Interrupt request accepted (one-hot signal)
    .lfxt_enable       (),                   // ASIC ONLY: Low frequency oscillator enable
    .lfxt_wkup         (),                   // ASIC ONLY: Low frequency oscillator wake-up (asynchronous)
    .mclk              (mclk),               // Main system clock
    .per_addr          (per_addr),           // Peripheral address
    .per_din           (per_din),            // Peripheral data input
    .per_we            (per_we),             // Peripheral write enable (high active)
    .per_en            (per_en),             // Peripheral enable (high active)
    .pmem_addr         (pmem_addr),          // Program Memory address
    .pmem_cen          (pmem_cen),           // Program Memory chip enable (low active)
    .pmem_din          (pmem_din),           // Program Memory data input (optional)
    .pmem_wen          (pmem_wen),           // Program Memory write enable (low active) (optional)
    .puc_rst           (puc_rst),            // Main system reset
    .smclk             (),                   // ASIC ONLY: SMCLK
    .smclk_en          (smclk_en),           // FPGA ONLY: SMCLK enable

    // INPUTs
    .cpu_en            (1'b1),               // Enable CPU code execution (asynchronous and non-glitchy)
    .dbg_en            (dbg_en),             // Debug interface enable (asynchronous and non-glitchy)
    .dbg_i2c_addr      (dbg_i2c_addr),       // Debug interface: I2C Address
    .dbg_i2c_broadcast (dbg_i2c_broadcast),  // Debug interface: I2C Broadcast Address (for multicore systems)
    .dbg_i2c_scl       (dbg_i2c_scl),        // Debug interface: I2C SCL
    .dbg_i2c_sda_in    (dbg_i2c_sda_in),     // Debug interface: I2C SDA IN
    .dbg_uart_rxd      (1'b1),               // Debug interface: UART RXD (asynchronous)
    .dco_clk           (dco_clk),            // Fast oscillator (fast clock)
    .dmem_dout         (dmem_dout),          // Data Memory data output
    .irq               (irq_bus),            // Maskable interrupts
    .lfxt_clk          (1'b0),               // Low frequency oscillator (typ 32kHz)
    .nmi               (nmi),                // Non-maskable interrupt (asynchronous)
    .per_dout          (per_dout),           // Peripheral data output
    .pmem_dout         (pmem_dout),          // Program Memory data output
    .reset_n           (reset_n),            // Reset Pin (low active, asynchronous and non-glitchy)
    .scan_enable       (1'b0),               // ASIC ONLY: Scan enable (active during scan shifting)
    .scan_mode         (1'b0),               // ASIC ONLY: Scan mode
    .wkup              (1'b0)                // ASIC ONLY: System Wake-up (asynchronous and non-glitchy)
  );

  assign  dbg_en      = 1'b1;

  //=============================================================================
  // 3)  OPENMSP430 PERIPHERALS
  //=============================================================================

  //
  // Digital I/O
  //-------------------------------

  msp430_gpio gpio_0 (

    // OUTPUTs
    .irq_port1    (irq_port1),             // Port 1 interrupt
    .irq_port2    (irq_port2),             // Port 2 interrupt
    .p1_dout      (p1_dout),               // Port 1 data output
    .p1_dout_en   (p1_dout_en),            // Port 1 data output enable
    .p1_sel       (p1_sel),                // Port 1 function select
    .p2_dout      (p2_dout),               // Port 2 data output
    .p2_dout_en   (p2_dout_en),            // Port 2 data output enable
    .p2_sel       (p2_sel),                // Port 2 function select
    .p3_dout      (),                      // Port 3 data output
    .p3_dout_en   (),                      // Port 3 data output enable
    .p3_sel       (),                      // Port 3 function select
    .p4_dout      (),                      // Port 4 data output
    .p4_dout_en   (),                      // Port 4 data output enable
    .p4_sel       (),                      // Port 4 function select
    .p5_dout      (),                      // Port 5 data output
    .p5_dout_en   (),                      // Port 5 data output enable
    .p5_sel       (),                      // Port 5 function select
    .p6_dout      (),                      // Port 6 data output
    .p6_dout_en   (),                      // Port 6 data output enable
    .p6_sel       (),                      // Port 6 function select
    .per_dout     (per_dout_gpio),         // Peripheral data output
    .p1dir        (),
    .p1ifg        (),

    // INPUTs
    .mclk         (mclk),                  // Main system clock
    .p1_din       (p1_din),                // Port 1 data input
    .p2_din       (p2_din),                // Port 2 data input
    .p3_din       (8'h00),                 // Port 3 data input
    .p4_din       (8'h00),                 // Port 4 data input
    .p5_din       (8'h00),                 // Port 5 data input
    .p6_din       (8'h00),                 // Port 6 data input
    .per_addr     (per_addr),              // Peripheral address
    .per_din      (per_din),               // Peripheral data input
    .per_en       (per_en),                // Peripheral enable (high active)
    .per_we       (per_we),                // Peripheral write enable (high active)
    .puc_rst      (puc_rst)                // Main system reset
  );

  // Assign LEDs
  assign  led         = p2_dout[1:0] & p2_dout_en[1:0];

  // Assign Switches
  assign  p1_din[7:4] = 4'h0;
  assign  p1_din[3:0] = switch;

  //
  // Timer A
  //----------------------------------------------

  msp430_ta ta_0 (

    // OUTPUTs
    .irq_ta0      (irq_ta0),               // Timer A interrupt: TACCR0
    .irq_ta1      (irq_ta1),               // Timer A interrupt: TAIV, TACCR1, TACCR2
    .per_dout     (per_dout_tA),           // Peripheral data output
    .ta_out0      (),                      // Timer A output 0
    .ta_out0_en   (),                      // Timer A output 0 enable
    .ta_out1      (),                      // Timer A output 1
    .ta_out1_en   (),                      // Timer A output 1 enable
    .ta_out2      (),                      // Timer A output 2
    .ta_out2_en   (),                      // Timer A output 2 enable
    .tar          (),
    .taccr0       (),

    // INPUTs
    .aclk_en      (aclk_en),               // ACLK enable (from CPU)
    .dbg_freeze   (dbg_freeze),            // Freeze Timer A counter
    .inclk        (1'b0),                  // INCLK external timer clock (SLOW)
    .irq_ta0_acc  (irq_acc[9]),            // Interrupt request TACCR0 accepted
    .mclk         (mclk),                  // Main system clock
    .per_addr     (per_addr),              // Peripheral address
    .per_din      (per_din),               // Peripheral data input
    .per_en       (per_en),                // Peripheral enable (high active)
    .per_we       (per_we),                // Peripheral write enable (high active)
    .puc_rst      (puc_rst),               // Main system reset
    .smclk_en     (smclk_en),              // SMCLK enable (from CPU)
    .ta_cci0a     (1'b0),                  // Timer A capture 0 input A
    .ta_cci0b     (1'b0),                  // Timer A capture 0 input B
    .ta_cci1a     (1'b0),                  // Timer A capture 1 input A
    .ta_cci1b     (1'b0),                  // Timer A capture 1 input B
    .ta_cci2a     (1'b0),                  // Timer A capture 2 input A
    .ta_cci2b     (1'b0),                  // Timer A capture 2 input B
    .taclk        (1'b0)                   // TACLK external timer clock (SLOW)
  );

  //
  // Combine peripheral data buses
  //-------------------------------

  assign per_dout = per_dout_gpio | per_dout_tA;

  //
  // Assign interrupts
  //-------------------------------

  assign nmi      =   1'b0;
  assign irq_bus  =  {1'b0,         // Vector 13  (0xFFFA)
                      1'b0,         // Vector 12  (0xFFF8)
                      1'b0,         // Vector 11  (0xFFF6)
                      1'b0,         // Vector 10  (0xFFF4) - Watchdog -
                      1'b0,         // Vector  9  (0xFFF2) - Reserved (Timer-A 0 from system 0)
                      1'b0,         // Vector  8  (0xFFF0) - Reserved (Timer-A 1 from system 0)
                      1'b0,         // Vector  7  (0xFFEE) - Reserved (UART RX from system 0)
                      1'b0,         // Vector  6  (0xFFEC) - Reserved (UART TX from system 0)
                      irq_ta0,      // Vector  5  (0xFFEA)
                      irq_ta1,      // Vector  4  (0xFFE8)
                      1'b0,         // Vector  3  (0xFFE6) - Reserved (Port 2 from system 0)
                      1'b0,         // Vector  2  (0xFFE4) - Reserved (Port 1 from system 0)
                      irq_port2,    // Vector  1  (0xFFE2)
                      irq_port1};   // Vector  0  (0xFFE0)
endmodule // msp430_core1

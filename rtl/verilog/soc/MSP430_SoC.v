//----------------------------------------------------------------------------
// Copyright (C) 2011 Authors
//
// This source file may be used and distributed without restriction provided
// that this copyright statement is not removed from the file and that any
// derivative work contains the original copyright notice and the associated
// disclaimer.
//
// This source file is free software; you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published
// by the Free Software Foundation; either version 2.1 of the License, or
// (at your option) any later version.
//
// This source is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
// License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this source; if not, write to the Free Software Foundation,
// Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
//
//----------------------------------------------------------------------------
// 
// *File Name: openMSP430_fpga.v
// 
// *Module Description:
//                      openMSP430 FPGA Top-level for the Avnet LX9 Microboard
//
// *Author(s):
//              - Ricardo Ribalda,    ricardo.ribalda@gmail.com
//              - Olivier Girard,    olgirard@gmail.com
//
//----------------------------------------------------------------------------
`include "openMSP430_defines.v"

module DUALCORE_430 (

  //CORE 0
  // CPU registers
  omsp0_r0,
  omsp0_r1,
  omsp0_r2,
  omsp0_r3,
  omsp0_r4,
  omsp0_r5,
  omsp0_r6,
  omsp0_r7,
  omsp0_r8,
  omsp0_r9,
  omsp0_r10,
  omsp0_r11,
  omsp0_r12,
  omsp0_r13,
  omsp0_r14,
  omsp0_r15,

  // Debug interface
  omsp0_dbg_en,
  omsp0_dbg_clk,
  omsp0_dbg_rst,

  // Interrupt detection
  omsp0_irq_detect,
  omsp0_nmi_pnd,

  omsp0_i_state,
  omsp0_e_state,
  omsp0_decode,
  omsp0_ir,
  omsp0_irq_num,
  omsp0_pc,

  // CPU internals
  omsp0_mclk,
  omsp0_puc_rst,

  //CORE 1
  // CPU registers
  omsp1_r0,
  omsp1_r1,
  omsp1_r2,
  omsp1_r3,
  omsp1_r4,
  omsp1_r5,
  omsp1_r6,
  omsp1_r7,
  omsp1_r8,
  omsp1_r9,
  omsp1_r10,
  omsp1_r11,
  omsp1_r12,
  omsp1_r13,
  omsp1_r14,
  omsp1_r15,

  // Interrupt detection
  omsp1_irq_detect,
  omsp1_nmi_pnd,

  omsp1_i_state,
  omsp1_e_state,
  omsp1_decode,
  omsp1_ir,
  omsp1_irq_num,
  omsp1_pc,

  // Debug interface
  omsp1_dbg_en,
  omsp1_dbg_clk,
  omsp1_dbg_rst,


  // CPU internals
  omsp1_mclk,
  omsp1_puc_rst,

  // Data memory
  omsp0_dmem_addr,
  omsp0_dmem_cen_sp,
  omsp0_dmem_cen_dp,
  omsp0_dmem_din,
  omsp0_dmem_wen,
  omsp0_dmem_dout_sp,
  omsp0_dmem_dout_dp,

  omsp1_dmem_addr,
  omsp1_dmem_cen_sp,
  omsp1_dmem_cen_dp,
  omsp1_dmem_din,
  omsp1_dmem_wen,
  omsp1_dmem_dout_sp,
  omsp1_dmem_dout_dp,

  // Program memory
  omsp0_pmem_addr,
  omsp0_pmem_cen,
  omsp0_pmem_din,
  omsp0_pmem_wen,
  omsp0_pmem_dout,

  omsp1_pmem_addr,
  omsp1_pmem_cen,
  omsp1_pmem_din,
  omsp1_pmem_wen,
  omsp1_pmem_dout,

  dco_clk,

  //----------------------------------------------
  // User Reset Push Button
  //----------------------------------------------
  USER_RESET,

  //----------------------------------------------
  // TI CDCE913 Triple-Output PLL Clock Chip
  //   Y1: 40 MHz, USER_CLOCK can be used as
  //              external configuration clock
  //   Y2: 66.667 MHz
  //   Y3: 100 MHz 
  //----------------------------------------------
  USER_CLOCK,

  //----------------------------------------------
  // User DIP Switch x4
  //----------------------------------------------
  GPIO_DIP1,
  GPIO_DIP2,
  GPIO_DIP3,
  GPIO_DIP4,

  //----------------------------------------------
  // User LEDs    
  //----------------------------------------------
  GPIO_LED1,
  GPIO_LED2,
  GPIO_LED3,
  GPIO_LED4,

  //----------------------------------------------
  // Silicon Labs CP2102 USB-to-UART Bridge Chip
  //----------------------------------------------
  USB_RS232_RXD,
  USB_RS232_TXD,

  //----------------------------------------------
  // Peripheral Modules (PMODs) and GPIO
  //     https://www.digilentinc.com/PMODs
  //----------------------------------------------

  // Connector J5
  PMOD1_P3,
  PMOD1_P4
);

  //CORE 0
  // CPU registers
  output        [15:0] omsp0_r0;
  output        [15:0] omsp0_r1;
  output        [15:0] omsp0_r2;
  output        [15:0] omsp0_r3;
  output        [15:0] omsp0_r4;
  output        [15:0] omsp0_r5;
  output        [15:0] omsp0_r6;
  output        [15:0] omsp0_r7;
  output        [15:0] omsp0_r8;
  output        [15:0] omsp0_r9;
  output        [15:0] omsp0_r10;
  output        [15:0] omsp0_r11;
  output        [15:0] omsp0_r12;
  output        [15:0] omsp0_r13;
  output        [15:0] omsp0_r14;
  output        [15:0] omsp0_r15;

  // Debug interface
  output               omsp0_dbg_en;
  output               omsp0_dbg_clk;
  output               omsp0_dbg_rst;

  // Interrupt detection
  output               omsp0_irq_detect;
  output               omsp0_nmi_pnd;

  output        [ 2:0] omsp0_i_state;
  output        [ 3:0] omsp0_e_state;
  output               omsp0_decode;
  output        [15:0] omsp0_ir;
  output        [ 5:0] omsp0_irq_num;
  output        [15:0] omsp0_pc;

  // CPU internals
  output               omsp0_mclk;
  output               omsp0_puc_rst;

  //CORE 1
  // CPU registers
  output        [15:0] omsp1_r0;
  output        [15:0] omsp1_r1;
  output        [15:0] omsp1_r2;
  output        [15:0] omsp1_r3;
  output        [15:0] omsp1_r4;
  output        [15:0] omsp1_r5;
  output        [15:0] omsp1_r6;
  output        [15:0] omsp1_r7;
  output        [15:0] omsp1_r8;
  output        [15:0] omsp1_r9;
  output        [15:0] omsp1_r10;
  output        [15:0] omsp1_r11;
  output        [15:0] omsp1_r12;
  output        [15:0] omsp1_r13;
  output        [15:0] omsp1_r14;
  output        [15:0] omsp1_r15;

  // Debug interface
  output               omsp1_dbg_en;
  output               omsp1_dbg_clk;
  output               omsp1_dbg_rst;

  // Interrupt detection
  output               omsp1_irq_detect;
  output               omsp1_nmi_pnd;

  output        [ 2:0] omsp1_i_state;
  output        [ 3:0] omsp1_e_state;
  output               omsp1_decode;
  output        [15:0] omsp1_ir;
  output        [ 5:0] omsp1_irq_num;
  output        [15:0] omsp1_pc;

  // CPU internals
  output               omsp1_mclk;
  output               omsp1_puc_rst;

  // Data memory
  output [`DMEM_MSB:0] omsp0_dmem_addr;
  output               omsp0_dmem_cen_sp;
  output               omsp0_dmem_cen_dp;
  output        [15:0] omsp0_dmem_din;
  output        [ 1:0] omsp0_dmem_wen;
  input         [15:0] omsp0_dmem_dout_sp;
  input         [15:0] omsp0_dmem_dout_dp;

  output [`DMEM_MSB:0] omsp1_dmem_addr;
  output               omsp1_dmem_cen_sp;
  output               omsp1_dmem_cen_dp;
  output        [15:0] omsp1_dmem_din;
  output        [ 1:0] omsp1_dmem_wen;
  input         [15:0] omsp1_dmem_dout_sp;
  input         [15:0] omsp1_dmem_dout_dp;

  // Program memory
  output [`PMEM_MSB:0] omsp0_pmem_addr;
  output               omsp0_pmem_cen;
  output        [15:0] omsp0_pmem_din;
  output        [ 1:0] omsp0_pmem_wen;
  input         [15:0] omsp0_pmem_dout;

  output [`PMEM_MSB:0] omsp1_pmem_addr;
  output               omsp1_pmem_cen;
  output        [15:0] omsp1_pmem_din;
  output        [ 1:0] omsp1_pmem_wen;
  input         [15:0] omsp1_pmem_dout;

  output               dco_clk;

  //----------------------------------------------
  // User Reset Push Button
  //----------------------------------------------
  input    USER_RESET;

  //----------------------------------------------
  // TI CDCE913 Triple-Output PLL Clock Chip
  //   Y1: 40 MHz; USER_CLOCK can be used as
  //              external configuration clock
  //   Y2: 66.667 MHz
  //   Y3: 100 MHz 
  //----------------------------------------------
  input    USER_CLOCK;

  //----------------------------------------------
  // User DIP Switch x4
  //----------------------------------------------
  input    GPIO_DIP1;
  input    GPIO_DIP2;
  input    GPIO_DIP3;
  input    GPIO_DIP4;

  //----------------------------------------------
  // User LEDs    
  //----------------------------------------------
  output   GPIO_LED1;
  output   GPIO_LED2;
  output   GPIO_LED3;
  output   GPIO_LED4;

  //----------------------------------------------
  // Silicon Labs CP2102 USB-to-UART Bridge Chip
  //----------------------------------------------
  input    USB_RS232_RXD;
  output   USB_RS232_TXD;

  //----------------------------------------------
  // Peripheral Modules (PMODs) and GPIO
  //     https://www.digilentinc.com/PMODs
  //----------------------------------------------

  // Connector J5
  inout    PMOD1_P3;
  input    PMOD1_P4;

  //=============================================================================
  // 1)  INTERNAL WIRES/REGISTERS/PARAMETERS DECLARATION
  //=============================================================================

  // Clock generation
  wire               dco_clk;

  // Reset generation
  wire               reset_pin;
  wire               reset_pin_n;
  wire               reset_n;

  // Debug interface
  wire               omsp_dbg_i2c_scl;
  wire               omsp_dbg_i2c_sda_in;
  wire               omsp_dbg_i2c_sda_out;
  wire               omsp0_dbg_i2c_sda_out;
  wire               omsp1_dbg_i2c_sda_out;

  // Data memory
  wire [`DMEM_MSB:0] omsp0_dmem_addr;
  wire               omsp0_dmem_cen;
  wire               omsp0_dmem_cen_sp;
  wire               omsp0_dmem_cen_dp;
  wire        [15:0] omsp0_dmem_din;
  wire        [ 1:0] omsp0_dmem_wen;
  wire        [15:0] omsp0_dmem_dout;
  wire        [15:0] omsp0_dmem_dout_sp;
  wire        [15:0] omsp0_dmem_dout_dp;
  reg                omsp0_dmem_dout_sel;

  wire [`DMEM_MSB:0] omsp1_dmem_addr;
  wire               omsp1_dmem_cen;
  wire               omsp1_dmem_cen_sp;
  wire               omsp1_dmem_cen_dp;
  wire        [15:0] omsp1_dmem_din;
  wire        [ 1:0] omsp1_dmem_wen;
  wire        [15:0] omsp1_dmem_dout;
  wire        [15:0] omsp1_dmem_dout_sp;
  wire        [15:0] omsp1_dmem_dout_dp;
  reg                omsp1_dmem_dout_sel;

  // Program memory
  wire [`PMEM_MSB:0] omsp0_pmem_addr;
  wire               omsp0_pmem_cen;
  wire        [15:0] omsp0_pmem_din;
  wire        [ 1:0] omsp0_pmem_wen;
  wire        [15:0] omsp0_pmem_dout;

  wire [`PMEM_MSB:0] omsp1_pmem_addr;
  wire               omsp1_pmem_cen;
  wire        [15:0] omsp1_pmem_din;
  wire        [ 1:0] omsp1_pmem_wen;
  wire        [15:0] omsp1_pmem_dout;

  // UART
  wire               omsp0_uart_rxd;
  wire               omsp0_uart_txd;

  // LEDs & Switches
  wire        [ 3:0] omsp_switch;
  wire        [ 1:0] omsp0_led;
  wire        [ 1:0] omsp1_led;

  //=============================================================================
  // 2)  RESET GENERATION & FPGA STARTUP
  //=============================================================================

  // Reset input buffer
  assign reset_pin = USER_RESET;
  assign reset_pin_n = ~reset_pin;

  // Release the reset only, if the DCM is locked
  assign reset_n = reset_pin_n;

  // Top level reset generation
  wire dco_rst;
  omsp_sync_reset sync_reset_dco (
    .rst_s (dco_rst),
    .clk   (dco_clk),
    .rst_a (!reset_n)
  );

  //=============================================================================
  // 3)  CLOCK GENERATION
  //=============================================================================

  // Input buffers
  //------------------------
  assign dco_clk = USER_CLOCK;

  //=============================================================================
  // 4)  OPENMSP430 SYSTEM 0
  //=============================================================================

  MSP430_CORE0 MSP430_CORE0_0 (

    // CPU registers
    .r0                (omsp0_r0),
    .r1                (omsp0_r1),
    .r2                (omsp0_r2),
    .r3                (omsp0_r3),
    .r4                (omsp0_r4),
    .r5                (omsp0_r5),
    .r6                (omsp0_r6),
    .r7                (omsp0_r7),
    .r8                (omsp0_r8),
    .r9                (omsp0_r9),
    .r10               (omsp0_r10),
    .r11               (omsp0_r11),
    .r12               (omsp0_r12),
    .r13               (omsp0_r13),
    .r14               (omsp0_r14),
    .r15               (omsp0_r15),

    // Debug interface
    .dbg_en            (omsp0_dbg_en),
    .dbg_clk           (omsp0_dbg_clk),
    .dbg_rst           (omsp0_dbg_rst),

    // Interrupt detection
    .irq_detect        (omsp0_irq_detect),
    .nmi_pnd           (omsp0_nmi_pnd),

    .i_state           (omsp0_i_state),
    .e_state           (omsp0_e_state),
    .decode            (omsp0_decode),
    .ir                (omsp0_ir),
    .irq_num           (omsp0_irq_num),
    .pc                (omsp0_pc),

    // CPU internals
    .mclk              (omsp0_mclk),
    .puc_rst           (omsp0_puc_rst),

    // Clock & Reset
    .dco_clk           (dco_clk),                     // Fast oscillator (fast clock)
    .reset_n           (reset_n),                     // Reset Pin (low active, asynchronous and non-glitchy)

    // Serial Debug Interface (I2C)
    .dbg_i2c_addr      (7'd50),                       // Debug interface: I2C Address
    .dbg_i2c_broadcast (7'd49),                       // Debug interface: I2C Broadcast Address (for multicore systems)
    .dbg_i2c_scl       (omsp_dbg_i2c_scl),            // Debug interface: I2C SCL
    .dbg_i2c_sda_in    (omsp_dbg_i2c_sda_in),         // Debug interface: I2C SDA IN
    .dbg_i2c_sda_out   (omsp0_dbg_i2c_sda_out),       // Debug interface: I2C SDA OUT

    // Data Memory
    .dmem_addr         (omsp0_dmem_addr),             // Data Memory address
    .dmem_cen          (omsp0_dmem_cen),              // Data Memory chip enable (low active)
    .dmem_din          (omsp0_dmem_din),              // Data Memory data input
    .dmem_wen          (omsp0_dmem_wen),              // Data Memory write enable (low active)
    .dmem_dout         (omsp0_dmem_dout),             // Data Memory data output

    // Program Memory
    .pmem_addr         (omsp0_pmem_addr),             // Program Memory address
    .pmem_cen          (omsp0_pmem_cen),              // Program Memory chip enable (low active)
    .pmem_din          (omsp0_pmem_din),              // Program Memory data input (optional)
    .pmem_wen          (omsp0_pmem_wen),              // Program Memory write enable (low active) (optional)
    .pmem_dout         (omsp0_pmem_dout),             // Program Memory data output

    // UART
    .uart_rxd          (omsp0_uart_rxd),              // UART Data Receive (RXD)
    .uart_txd          (omsp0_uart_txd),              // UART Data Transmit (TXD)

    // Switches & LEDs
    .switch            (omsp_switch),                 // Input switches
    .led               (omsp0_led)                    // LEDs
  );

  //=============================================================================
  // 5)  OPENMSP430 SYSTEM 1
  //=============================================================================

  MSP430_CORE1 MSP430_CORE1_0 (

    // CPU registers
    .r0                (omsp1_r0),
    .r1                (omsp1_r1),
    .r2                (omsp1_r2),
    .r3                (omsp1_r3),
    .r4                (omsp1_r4),
    .r5                (omsp1_r5),
    .r6                (omsp1_r6),
    .r7                (omsp1_r7),
    .r8                (omsp1_r8),
    .r9                (omsp1_r9),
    .r10               (omsp1_r10),
    .r11               (omsp1_r11),
    .r12               (omsp1_r12),
    .r13               (omsp1_r13),
    .r14               (omsp1_r14),
    .r15               (omsp1_r15),

    // Debug interface
    .dbg_en            (omsp1_dbg_en),
    .dbg_clk           (omsp1_dbg_clk),
    .dbg_rst           (omsp1_dbg_rst),

    // Interrupt detection
    .irq_detect        (omsp1_irq_detect),
    .nmi_pnd           (omsp1_nmi_pnd),

    .i_state           (omsp1_i_state),
    .e_state           (omsp1_e_state),
    .decode            (omsp1_decode),
    .ir                (omsp1_ir),
    .irq_num           (omsp1_irq_num),
    .pc                (omsp1_pc),

    // CPU internals
    .mclk              (omsp1_mclk),
    .puc_rst           (omsp1_puc_rst),

    // Clock & Reset
    .dco_clk           (dco_clk),                     // Fast oscillator (fast clock)
    .reset_n           (reset_n),                     // Reset Pin (low active, asynchronous and non-glitchy)

    // Serial Debug Interface (I2C)
    .dbg_i2c_addr      (7'd51),                       // Debug interface: I2C Address
    .dbg_i2c_broadcast (7'd49),                       // Debug interface: I2C Broadcast Address (for multicore systems)
    .dbg_i2c_scl       (omsp_dbg_i2c_scl),            // Debug interface: I2C SCL
    .dbg_i2c_sda_in    (omsp_dbg_i2c_sda_in),         // Debug interface: I2C SDA IN
    .dbg_i2c_sda_out   (omsp1_dbg_i2c_sda_out),       // Debug interface: I2C SDA OUT

    // Data Memory
    .dmem_addr         (omsp1_dmem_addr),             // Data Memory address
    .dmem_cen          (omsp1_dmem_cen),              // Data Memory chip enable (low active)
    .dmem_din          (omsp1_dmem_din),              // Data Memory data input
    .dmem_wen          (omsp1_dmem_wen),              // Data Memory write enable (low active)
    .dmem_dout         (omsp1_dmem_dout),             // Data Memory data output

    // Program Memory
    .pmem_addr         (omsp1_pmem_addr),             // Program Memory address
    .pmem_cen          (omsp1_pmem_cen),              // Program Memory chip enable (low active)
    .pmem_din          (omsp1_pmem_din),              // Program Memory data input (optional)
    .pmem_wen          (omsp1_pmem_wen),              // Program Memory write enable (low active) (optional)
    .pmem_dout         (omsp1_pmem_dout),             // Program Memory data output

    // Switches & LEDs
    .switch            (omsp_switch),                 // Input switches
    .led               (omsp1_led)                    // LEDs
  );

  //=============================================================================
  // 6)  PROGRAM AND DATA MEMORIES
  //=============================================================================

  // Memory muxing (CPU 0)
  assign omsp0_dmem_cen_sp =  omsp0_dmem_addr[`DMEM_MSB] | omsp0_dmem_cen;
  assign omsp0_dmem_cen_dp = ~omsp0_dmem_addr[`DMEM_MSB] | omsp0_dmem_cen;
  assign omsp0_dmem_dout   =  omsp0_dmem_dout_sel ? omsp0_dmem_dout_sp : omsp0_dmem_dout_dp;

  always @ (posedge dco_clk or posedge dco_rst) begin
    if (dco_rst)                  omsp0_dmem_dout_sel <=  1'b1;
    else if (~omsp0_dmem_cen_sp)  omsp0_dmem_dout_sel <=  1'b1;
    else if (~omsp0_dmem_cen_dp)  omsp0_dmem_dout_sel <=  1'b0;
  end

  // Memory muxing (CPU 1)
  assign omsp1_dmem_cen_sp =  omsp1_dmem_addr[`DMEM_MSB] | omsp1_dmem_cen;
  assign omsp1_dmem_cen_dp = ~omsp1_dmem_addr[`DMEM_MSB] | omsp1_dmem_cen;
  assign omsp1_dmem_dout   =  omsp1_dmem_dout_sel ? omsp1_dmem_dout_sp : omsp1_dmem_dout_dp;

  always @ (posedge dco_clk or posedge dco_rst) begin
    if (dco_rst)                  omsp1_dmem_dout_sel <=  1'b1;
    else if (~omsp1_dmem_cen_sp)  omsp1_dmem_dout_sel <=  1'b1;
    else if (~omsp1_dmem_cen_dp)  omsp1_dmem_dout_sel <=  1'b0;
  end

  //=============================================================================
  // 7)  I/O CELLS
  //=============================================================================

  //----------------------------------------------
  // User DIP Switch x4
  //----------------------------------------------
  assign omsp_switch[3] = GPIO_DIP4;
  assign omsp_switch[2] = GPIO_DIP3;
  assign omsp_switch[1] = GPIO_DIP2;
  assign omsp_switch[0] = GPIO_DIP1;

  //----------------------------------------------
  // User LEDs    
  //----------------------------------------------
  assign GPIO_LED4 = omsp1_led[1];
  assign GPIO_LED3 = omsp1_led[0];
  assign GPIO_LED2 = omsp0_led[1];
  assign GPIO_LED1 = omsp0_led[0];

  //----------------------------------------------
  // Silicon Labs CP2102 USB-to-UART Bridge Chip
  //----------------------------------------------
  assign omsp0_uart_rxd = USB_RS232_RXD;
  assign USB_RS232_TXD = omsp0_uart_txd;

  //----------------------------------------------
  // Peripheral Modules (PMODs) and GPIO
  //     https://www.digilentinc.com/PMODs
  //----------------------------------------------

  assign omsp_dbg_i2c_sda_out = omsp0_dbg_i2c_sda_out & omsp1_dbg_i2c_sda_out;

  // Connector J5
  io_cell PMOD_P3_PIN (
    .data_out_en (omsp_dbg_i2c_sda_out),
    .data_in     (omsp_dbg_i2c_sda_in),
    .data_out    (1'b0),
    .pad         (PMOD1_P3)
  );

  assign omsp_dbg_i2c_scl = PMOD1_P4;
endmodule // DUALCORE_430

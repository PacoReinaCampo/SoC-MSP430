//----------------------------------------------------------------------------
// Copyright (C) 2001 Authors
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
// *File Name: tb_openMSP430.v
// 
// *Module Description:
//                      openMSP430 FPGA testbench
//
// *Author(s):
//              - Olivier Girard,    olgirard@gmail.com
//
//----------------------------------------------------------------------------
// $Rev: 111 $
// $LastChangedBy: olivier.girard $
// $LastChangedDate: 2011-05-20 22:39:02 +0200 (Fri, 20 May 2011) $
//----------------------------------------------------------------------------
`include "timescale.v"
`ifdef OMSP_NO_INCLUDE
`else
`include "openMSP430_defines.v"
`endif

module tb_openMSP430;

  //
  // Wire & Register definition
  //------------------------------

  // Clock & Reset
  reg               CLK_40MHz;
  reg               USER_RESET;

  // Slide Switches
  reg               SW4;
  reg               SW3;
  reg               SW2;
  reg               SW1;

  // LEDs
  wire              LED4;
  wire              LED3;
  wire              LED2;
  wire              LED1;

  // UART
  reg               UART_RXD;
  wire              UART_TXD;

  // I2C
  wire 	          PMOD1_P3;
  reg               PMOD1_P4;

  // Core debug signals
  wire   [8*32-1:0] omsp0_i_state;
  wire   [8*32-1:0] omsp0_e_state;
  wire       [31:0] omsp0_inst_cycle;
  wire   [8*32-1:0] omsp0_inst_full;
  wire       [31:0] omsp0_inst_number;
  wire       [15:0] omsp0_inst_pc;
  wire   [8*32-1:0] omsp0_inst_short;

  wire   [8*32-1:0] omsp1_i_state;
  wire   [8*32-1:0] omsp1_e_state;
  wire       [31:0] omsp1_inst_cycle;
  wire   [8*32-1:0] omsp1_inst_full;
  wire       [31:0] omsp1_inst_number;
  wire       [15:0] omsp1_inst_pc;
  wire   [8*32-1:0] omsp1_inst_short;

  // Testbench variables
  integer           i;
  integer           error;
  reg               stimulus_done;


  // CORE 0
  // CPU registers
  wire       [15:0] omsp0_r0;
  wire       [15:0] omsp0_r1;
  wire       [15:0] omsp0_r2;
  wire       [15:0] omsp0_r3;
  wire       [15:0] omsp0_r4;
  wire       [15:0] omsp0_r5;
  wire       [15:0] omsp0_r6;
  wire       [15:0] omsp0_r7;
  wire       [15:0] omsp0_r8;
  wire       [15:0] omsp0_r9;
  wire       [15:0] omsp0_r10;
  wire       [15:0] omsp0_r11;
  wire       [15:0] omsp0_r12;
  wire       [15:0] omsp0_r13;
  wire       [15:0] omsp0_r14;
  wire       [15:0] omsp0_r15;

  // Debug interface
  wire              omsp0_dbg_en;
  wire              omsp0_dbg_clk;
  wire              omsp0_dbg_rst;

  // Interrupt detection
  wire              omsp0_irq_detect;
  wire              omsp0_nmi_detect;

  wire        [2:0] omsp0_i_state_bin;
  wire        [3:0] omsp0_e_state_bin;
  wire              omsp0_decode;
  wire       [15:0] omsp0_ir;
  wire        [5:0] omsp0_irq_num;
  wire       [15:0] omsp0_pc;

  // CPU internals
  wire              omsp0_mclk;
  wire              omsp0_puc_rst;


  // CORE 1
  // CPU registers
  wire       [15:0] omsp1_r0;
  wire       [15:0] omsp1_r1;
  wire       [15:0] omsp1_r2;
  wire       [15:0] omsp1_r3;
  wire       [15:0] omsp1_r4;
  wire       [15:0] omsp1_r5;
  wire       [15:0] omsp1_r6;
  wire       [15:0] omsp1_r7;
  wire       [15:0] omsp1_r8;
  wire       [15:0] omsp1_r9;
  wire       [15:0] omsp1_r10;
  wire       [15:0] omsp1_r11;
  wire       [15:0] omsp1_r12;
  wire       [15:0] omsp1_r13;
  wire       [15:0] omsp1_r14;
  wire       [15:0] omsp1_r15;

  // Debug interface
  wire              omsp1_dbg_en;
  wire              omsp1_dbg_clk;
  wire              omsp1_dbg_rst;


  // Interrupt detection
  wire              omsp1_irq_detect;
  wire              omsp1_nmi_detect;

  wire        [2:0] omsp1_i_state_bin;
  wire        [3:0] omsp1_e_state_bin;
  wire              omsp1_decode;
  wire       [15:0] omsp1_ir;
  wire        [5:0] omsp1_irq_num;
  wire       [15:0] omsp1_pc;

  // CPU internals
  wire              omsp1_mclk;
  wire              omsp1_puc_rst;


  // Data memory
  wire [`DMEM_MSB:0] omsp0_dmem_addr;
  wire               omsp0_dmem_cen_sp;
  wire               omsp0_dmem_cen_dp;
  wire        [15:0] omsp0_dmem_din;
  wire         [1:0] omsp0_dmem_wen;
  wire        [15:0] omsp0_dmem_dout_sp;
  wire        [15:0] omsp0_dmem_dout_dp;

  wire [`DMEM_MSB:0] omsp1_dmem_addr;
  wire               omsp1_dmem_cen_sp;
  wire               omsp1_dmem_cen_dp;
  wire        [15:0] omsp1_dmem_din;
  wire         [1:0] omsp1_dmem_wen;
  wire        [15:0] omsp1_dmem_dout_sp;
  wire        [15:0] omsp1_dmem_dout_dp;

  // Program memory
  wire [`PMEM_MSB:0] omsp0_pmem_addr;
  wire               omsp0_pmem_cen;
  wire        [15:0] omsp0_pmem_din;
  wire         [1:0] omsp0_pmem_wen;
  wire        [15:0] omsp0_pmem_dout;

  wire [`PMEM_MSB:0] omsp1_pmem_addr;
  wire               omsp1_pmem_cen;
  wire        [15:0] omsp1_pmem_din;
  wire         [1:0] omsp1_pmem_wen;
  wire        [15:0] omsp1_pmem_dout;

  wire               dco_clk;

  //
  // Include files
  //------------------------------

  // CPU & Memory registers
  `include "registers_omsp0.v"
  `include "registers_omsp1.v"

  // Verilog stimulus
  `include "stimulus.v"

  //
  // Initialize Program Memory
  //------------------------------

  initial begin
    // Read memory file
    #10 $readmemh("./pmem.mem", pmem);

    // Update Xilinx memory banks
    for (i=0; i<8192; i=i+1)
      begin
        RAM_P2_shared.RAM_DP_inst.mem[i] = pmem[i];
      end
  end

  //
  // Generate Clock & Reset
  //------------------------------
  initial begin
    CLK_40MHz = 1'b0;
    forever #12.5 CLK_40MHz <= ~CLK_40MHz; // 40 MHz
  end

  initial begin
    USER_RESET         = 1'b0;
    #100 USER_RESET    = 1'b1;
    #600 USER_RESET    = 1'b0;
  end

  //
  // Global initialization
  //------------------------------
  initial begin
    error         = 0;
    stimulus_done = 1;
    SW4           = 1'b0;  // Slide Switches
    SW3           = 1'b0;
    SW2           = 1'b0;
    SW1           = 1'b0;
    UART_RXD      = 1'b1;  // UART
    PMOD1_P4      = 1'b1;
  end

  //
  // openMSP430 FPGA Instance
  //----------------------------------

  DUALCORE_430 dut (

    // CORE 0
    // CPU registers
    .omsp0_r0         (omsp0_r0),
    .omsp0_r1         (omsp0_r1),
    .omsp0_r2         (omsp0_r2),
    .omsp0_r3         (omsp0_r3),
    .omsp0_r4         (omsp0_r4),
    .omsp0_r5         (omsp0_r5),
    .omsp0_r6         (omsp0_r6),
    .omsp0_r7         (omsp0_r7),
    .omsp0_r8         (omsp0_r8),
    .omsp0_r9         (omsp0_r9),
    .omsp0_r10        (omsp0_r10),
    .omsp0_r11        (omsp0_r11),
    .omsp0_r12        (omsp0_r12),
    .omsp0_r13        (omsp0_r13),
    .omsp0_r14        (omsp0_r14),
    .omsp0_r15        (omsp0_r15),

    // Debug interface
    .omsp0_dbg_en     (omsp0_dbg_en),
    .omsp0_dbg_clk    (omsp0_dbg_clk),
    .omsp0_dbg_rst    (omsp0_dbg_rst),

    // Interrupt detection
    .omsp0_irq_detect (omsp0_irq_detect),
    .omsp0_nmi_pnd    (omsp0_nmi_detect),

    .omsp0_i_state    (omsp0_i_state_bin),
    .omsp0_e_state    (omsp0_e_state_bin),
    .omsp0_decode     (omsp0_decode),
    .omsp0_ir         (omsp0_ir),
    .omsp0_irq_num    (omsp0_irq_num),
    .omsp0_pc         (omsp0_pc),

    // CPU internals
    .omsp0_mclk       (omsp0_mclk),
    .omsp0_puc_rst    (omsp0_puc_rst),

    // CORE 1
    // CPU registers
    .omsp1_r0         (omsp1_r0),
    .omsp1_r1         (omsp1_r1),
    .omsp1_r2         (omsp1_r2),
    .omsp1_r3         (omsp1_r3),
    .omsp1_r4         (omsp1_r4),
    .omsp1_r5         (omsp1_r5),
    .omsp1_r6         (omsp1_r6),
    .omsp1_r7         (omsp1_r7),
    .omsp1_r8         (omsp1_r8),
    .omsp1_r9         (omsp1_r9),
    .omsp1_r10        (omsp1_r10),
    .omsp1_r11        (omsp1_r11),
    .omsp1_r12        (omsp1_r12),
    .omsp1_r13        (omsp1_r13),
    .omsp1_r14        (omsp1_r14),
    .omsp1_r15        (omsp1_r15),

    // Debug interface
    .omsp1_dbg_en     (omsp1_dbg_en),
    .omsp1_dbg_clk    (omsp1_dbg_clk),
    .omsp1_dbg_rst    (omsp1_dbg_rst),

    // Interrupt detection
    .omsp1_irq_detect (omsp1_irq_detect),
    .omsp1_nmi_pnd    (omsp1_nmi_detect),

    .omsp1_i_state    (omsp1_i_state_bin),
    .omsp1_e_state    (omsp1_e_state_bin),
    .omsp1_decode     (omsp1_decode),
    .omsp1_ir         (omsp1_ir),
    .omsp1_irq_num    (omsp1_irq_num),
    .omsp1_pc         (omsp1_pc),

    // CPU internals
    .omsp1_mclk       (omsp1_mclk),
    .omsp1_puc_rst    (omsp1_puc_rst),

    // Data memory
    .omsp0_dmem_addr    (omsp0_dmem_addr),
    .omsp0_dmem_cen_sp  (omsp0_dmem_cen_sp),
    .omsp0_dmem_cen_dp  (omsp0_dmem_cen_dp),
    .omsp0_dmem_din     (omsp0_dmem_din),
    .omsp0_dmem_wen     (omsp0_dmem_wen),
    .omsp0_dmem_dout_sp (omsp0_dmem_dout_sp),
    .omsp0_dmem_dout_dp (omsp0_dmem_dout_dp),

    .omsp1_dmem_addr    (omsp1_dmem_addr),
    .omsp1_dmem_cen_sp  (omsp1_dmem_cen_sp),
    .omsp1_dmem_cen_dp  (omsp1_dmem_cen_dp),
    .omsp1_dmem_din     (omsp1_dmem_din),
    .omsp1_dmem_wen     (omsp1_dmem_wen),
    .omsp1_dmem_dout_sp (omsp1_dmem_dout_sp),
    .omsp1_dmem_dout_dp (omsp1_dmem_dout_dp),

    // Program memory
    .omsp0_pmem_addr  (omsp0_pmem_addr),
    .omsp0_pmem_cen   (omsp0_pmem_cen),
    .omsp0_pmem_din   (omsp0_pmem_din),
    .omsp0_pmem_wen   (omsp0_pmem_wen),
    .omsp0_pmem_dout  (omsp0_pmem_dout),

    .omsp1_pmem_addr  (omsp1_pmem_addr),
    .omsp1_pmem_cen   (omsp1_pmem_cen),
    .omsp1_pmem_din   (omsp1_pmem_din),
    .omsp1_pmem_wen   (omsp1_pmem_wen),
    .omsp1_pmem_dout  (omsp1_pmem_dout),

    .dco_clk          (dco_clk),

    //----------------------------------------------
    // User Reset Push Button
    //----------------------------------------------
    .USER_RESET      (USER_RESET),

    //----------------------------------------------
    // TI CDCE913 Triple-Output PLL Clock Chip
    //   Y1: 40 MHz, USER_CLOCK can be used as
    //              external configuration clock
    //   Y2: 66.667 MHz
    //   Y3: 100 MHz 
    //----------------------------------------------
    .USER_CLOCK      (CLK_40MHz),

    //----------------------------------------------
    // User DIP Switch x4
    //----------------------------------------------
    .GPIO_DIP1       (SW1),
    .GPIO_DIP2       (SW2),
    .GPIO_DIP3       (SW3),
    .GPIO_DIP4       (SW4),

    //----------------------------------------------
    // User LEDs			
    //----------------------------------------------
    .GPIO_LED1       (LED1),
    .GPIO_LED2       (LED2),
    .GPIO_LED3       (LED3),
    .GPIO_LED4       (LED4),

    //----------------------------------------------
    // Silicon Labs CP2102 USB-to-UART Bridge Chip
    //----------------------------------------------
    .USB_RS232_RXD   (UART_RXD),
    .USB_RS232_TXD   (UART_TXD),

    //----------------------------------------------
    // Peripheral Modules (PMODs) and GPIO
    //     https://www.digilentinc.com/PMODs
    //----------------------------------------------

    // Connector J5
    .PMOD1_P3        (PMOD1_P3),    // Serial Debug Interface TX
    .PMOD1_P4        (PMOD1_P4)     // Serial Debug Interface RX
  );


  // DATA MEMORIES
  // Data Memory (CPU 0)
  RAM_D1 RAM_D1_omsp0 (
    .clka           ( dco_clk),
    .ena            (~omsp0_dmem_cen_sp),
    .wea            (~omsp0_dmem_wen),
    .addra          ( omsp0_dmem_addr[`DMEM_MSB-1:0]),
    .dina           ( omsp0_dmem_din),
    .douta          ( omsp0_dmem_dout_sp)
  );

  // Data Memory (CPU 1)
  RAM_D1 RAM_D1_omsp1 (
    .clka           ( dco_clk),
    .ena            (~omsp1_dmem_cen_sp),
    .wea            (~omsp1_dmem_wen),
    .addra          ( omsp1_dmem_addr[`DMEM_MSB-1:0]),
    .dina           ( omsp1_dmem_din),
    .douta          ( omsp1_dmem_dout_sp)
  );

  // Shared Data Memory (CPU 0 - CPU 1)
  RAM_D2 RAM_D2_shared (
    .clka           ( dco_clk),
    .ena            (~omsp0_dmem_cen_dp),
    .wea            (~omsp0_dmem_wen),
    .addra          ( omsp0_dmem_addr[`DMEM_MSB-1:0]),
    .dina           ( omsp0_dmem_din),
    .douta          ( omsp0_dmem_dout_dp),
    .clkb           ( dco_clk),
    .enb            (~omsp1_dmem_cen_dp),
    .web            (~omsp1_dmem_wen),
    .addrb          ( omsp1_dmem_addr[`DMEM_MSB-1:0]),
    .dinb           ( omsp1_dmem_din),
    .doutb          ( omsp1_dmem_dout_dp)
  );

  // PROGRAM MEMORIES
  // Shared Program Memory (CPU 0 - CPU 1)
  RAM_P2 RAM_P2_shared (
    .clka           ( dco_clk),
    .ena            (~omsp0_pmem_cen),
    .wea            (~omsp0_pmem_wen),
    .addra          ( omsp0_pmem_addr),
    .dina           ( omsp0_pmem_din),
    .douta          ( omsp0_pmem_dout),
    .clkb           ( dco_clk),
    .enb            (~omsp1_pmem_cen),
    .web            (~omsp1_pmem_wen),
    .addrb          ( omsp1_pmem_addr),
    .dinb           ( omsp1_pmem_din),
    .doutb          ( omsp1_pmem_dout)
  );


  // Debug utility signals
  //----------------------------------------
  msp_debug msp_debug_omsp0 (

    // OUTPUTs
    .e_state      (omsp0_e_state),       // Execution state
    .i_state      (omsp0_i_state),       // Instruction fetch state
    .inst_cycle   (omsp0_inst_cycle),    // Cycle number within current instruction
    .inst_full    (omsp0_inst_full),     // Currently executed instruction (full version)
    .inst_number  (omsp0_inst_number),   // Instruction number since last system reset
    .inst_pc      (omsp0_inst_pc),       // Instruction Program counter
    .inst_short   (omsp0_inst_short),    // Currently executed instruction (short version)

    // INPUTs
    .core_select  (1'b0)                 // Core selection
  );

  msp_debug msp_debug_omsp1 (

    // OUTPUTs
    .e_state      (omsp1_e_state),       // Execution state
    .i_state      (omsp1_i_state),       // Instruction fetch state
    .inst_cycle   (omsp1_inst_cycle),    // Cycle number within current instruction
    .inst_full    (omsp1_inst_full),     // Currently executed instruction (full version)
    .inst_number  (omsp1_inst_number),   // Instruction number since last system reset
    .inst_pc      (omsp1_inst_pc),       // Instruction Program counter
    .inst_short   (omsp1_inst_short),    // Currently executed instruction (short version)

    // INPUTs
    .core_select  (1'b1)                 // Core selection
  );

  //
  // Generate Waveform
  //----------------------------------------
  initial begin
    `ifdef VPD_FILE
    $vcdplusfile("tb_openMSP430.vpd");
    $vcdpluson();
    `else
    `ifdef TRN_FILE
    $recordfile ("tb_openMSP430.trn");
    $recordvars;
    `else
    $dumpfile("tb_openMSP430.vcd");
    $dumpvars(0, tb_openMSP430);
    `endif
    `endif
  end

  //
  // End of simulation
  //----------------------------------------

  initial begin // Timeout
    #500000;
    $display(" ===============================================");
    $display("|               SIMULATION FAILED               |");
    $display("|              (simulation Timeout)             |");
    $display(" ===============================================");
    $finish;
  end

  initial begin // Normal end of test
    @(omsp0_inst_pc===16'hffff)
    $display(" ===============================================");
    if (error!=0) begin
      $display("|               SIMULATION FAILED               |");
      $display("|     (some verilog stimulus checks failed)     |");
    end
    else if (~stimulus_done) begin
      $display("|               SIMULATION FAILED               |");
      $display("|     (the verilog stimulus didn't complete)    |");
    end
    else begin
      $display("|               SIMULATION PASSED               |");
    end
    $display(" ===============================================");
    $finish;
  end


  //
  // Tasks Definition
  //------------------------------

  task tb_error;
    input [65*8:0] error_string;
    begin
      $display("ERROR: %s %t", error_string, $time);
      error = error+1;
    end
  endtask


endmodule

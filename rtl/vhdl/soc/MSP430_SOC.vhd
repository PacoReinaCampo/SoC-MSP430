--============================================================================--
--==                                          __ _      _     _             ==--
--==                                         / _(_)    | |   | |            ==--
--==              __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |            ==--
--==             / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |            ==--
--==            | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |            ==--
--==             \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|            ==--
--==                | |                                                     ==--
--==                |_|                                                     ==--
--==                                                                        ==--
--==                                                                        ==--
--==            MSP430 CPU                                                  ==--
--==            Processing Unit                                             ==--
--==                                                                        ==--
--============================================================================--

-- Copyright (c) 2015-2016 by the author(s)
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
-- =============================================================================
-- Author(s):
--   Francisco Javier Reina Campo <frareicam@gmail.com>
--

library IEEE;
use IEEE.STD_LOGIC_1164 .all;
use IEEE.NUMERIC_STD .all;
use WORK.MSP430_PACK .all;

entity MSP430_SOC is
  port (
    --User Reset Push Button
    USER_RESET : in std_ulogic;

    --Triple-Output PLL Clock Chip
    USER_CLOCK : in std_ulogic;

    --User DIP Switch x4
    GPIO_DIP1 : in std_ulogic;
    GPIO_DIP2 : in std_ulogic;
    GPIO_DIP3 : in std_ulogic;
    GPIO_DIP4 : in std_ulogic;

    --User LEDs                 
    GPIO_LED1 : out std_ulogic;
    GPIO_LED2 : out std_ulogic;
    GPIO_LED3 : out std_ulogic;
    GPIO_LED4 : out std_ulogic;

    --Silicon Labs CP2102 USB-to-UART Bridge Chip
    USB_RS232_RXD : in  std_ulogic;
    USB_RS232_TXD : out std_ulogic;

    --Peripheral Modules (PMODs) and GPIO
    PMOD1_P3 : inout std_ulogic;
    PMOD1_P4 : in    std_ulogic);
end MSP430_SOC;

architecture MSP430_SOC_ARQ of MSP430_SOC is

  --Clock generation
  signal dco_clk : std_ulogic;

  --Reset generation
  signal reset_pin   : std_ulogic;
  signal reset_pin_n : std_ulogic;
  signal reset_n     : std_ulogic;
  signal not_reset_n : std_ulogic;
  signal dco_rst     : std_ulogic;

  --Debug interface
  signal omsp_dbg_i2c_scl      : std_ulogic;
  signal omsp_dbg_i2c_sda_in   : std_ulogic;
  signal omsp_dbg_i2c_sda_out  : std_ulogic;
  signal omsp0_dbg_i2c_sda_out : std_ulogic;
  signal omsp1_dbg_i2c_sda_out : std_ulogic;
  signal omsp2_dbg_i2c_sda_out : std_ulogic;
  signal omsp3_dbg_i2c_sda_out : std_ulogic;
  signal omsp4_dbg_i2c_sda_out : std_ulogic;
  signal omsp5_dbg_i2c_sda_out : std_ulogic;
  signal omsp6_dbg_i2c_sda_out : std_ulogic;
  signal omsp7_dbg_i2c_sda_out : std_ulogic;

  --Instruction memory (CPU 0 - CPU 1 - CPU 2 - CPU 3)
  signal omsp0_pmem_addr       : std_ulogic_vector (PMEM_MSB downto 0);
  signal omsp0_pmem_cen        : std_ulogic;
  signal omsp0_pmem_cen_sp     : std_ulogic;
  signal omsp0_not_pmem_cen_sp : std_ulogic;
  signal omsp0_pmem_cen_dp     : std_ulogic;
  signal omsp0_not_pmem_cen_dp : std_ulogic;
  signal omsp0_pmem_din        : std_ulogic_vector (15 downto 0);
  signal omsp0_pmem_wen        : std_ulogic_vector (1 downto 0);
  signal omsp0_not_pmem_wen    : std_ulogic_vector (1 downto 0);
  signal omsp0_pmem_dout       : std_ulogic_vector (15 downto 0);
  signal omsp0_pmem_dout_sp    : std_ulogic_vector (15 downto 0);
  signal omsp0_pmem_dout_dp    : std_ulogic_vector (15 downto 0);
  signal omsp0_pmem_dout_sel   : std_ulogic;

  signal omsp1_pmem_addr       : std_ulogic_vector (PMEM_MSB downto 0);
  signal omsp1_pmem_cen        : std_ulogic;
  signal omsp1_pmem_cen_sp     : std_ulogic;
  signal omsp1_not_pmem_cen_sp : std_ulogic;
  signal omsp1_pmem_cen_dp     : std_ulogic;
  signal omsp1_not_pmem_cen_dp : std_ulogic;
  signal omsp1_pmem_din        : std_ulogic_vector (15 downto 0);
  signal omsp1_pmem_wen        : std_ulogic_vector (1 downto 0);
  signal omsp1_not_pmem_wen    : std_ulogic_vector (1 downto 0);
  signal omsp1_pmem_dout       : std_ulogic_vector (15 downto 0);
  signal omsp1_pmem_dout_sp    : std_ulogic_vector (15 downto 0);
  signal omsp1_pmem_dout_dp    : std_ulogic_vector (15 downto 0);
  signal omsp1_pmem_dout_sel   : std_ulogic;

  signal omsp2_pmem_addr       : std_ulogic_vector (PMEM_MSB downto 0);
  signal omsp2_pmem_cen        : std_ulogic;
  signal omsp2_pmem_cen_sp     : std_ulogic;
  signal omsp2_not_pmem_cen_sp : std_ulogic;
  signal omsp2_pmem_cen_dp     : std_ulogic;
  signal omsp2_not_pmem_cen_dp : std_ulogic;
  signal omsp2_pmem_din        : std_ulogic_vector (15 downto 0);
  signal omsp2_pmem_wen        : std_ulogic_vector (1 downto 0);
  signal omsp2_not_pmem_wen    : std_ulogic_vector (1 downto 0);
  signal omsp2_pmem_dout       : std_ulogic_vector (15 downto 0);
  signal omsp2_pmem_dout_sp    : std_ulogic_vector (15 downto 0);
  signal omsp2_pmem_dout_dp    : std_ulogic_vector (15 downto 0);
  signal omsp2_pmem_dout_sel   : std_ulogic;

  signal omsp3_pmem_addr       : std_ulogic_vector (PMEM_MSB downto 0);
  signal omsp3_pmem_cen        : std_ulogic;
  signal omsp3_pmem_cen_sp     : std_ulogic;
  signal omsp3_not_pmem_cen_sp : std_ulogic;
  signal omsp3_pmem_cen_dp     : std_ulogic;
  signal omsp3_not_pmem_cen_dp : std_ulogic;
  signal omsp3_pmem_din        : std_ulogic_vector (15 downto 0);
  signal omsp3_pmem_wen        : std_ulogic_vector (1 downto 0);
  signal omsp3_not_pmem_wen    : std_ulogic_vector (1 downto 0);
  signal omsp3_pmem_dout       : std_ulogic_vector (15 downto 0);
  signal omsp3_pmem_dout_sp    : std_ulogic_vector (15 downto 0);
  signal omsp3_pmem_dout_dp    : std_ulogic_vector (15 downto 0);
  signal omsp3_pmem_dout_sel   : std_ulogic;

  --Data memory (CPU 0 - CPU 1 - CPU 2 - CPU 3)
  signal omsp0_dmem_addr    : std_ulogic_vector (DMEM_MSB downto 0);
  signal omsp0_dmem_cen     : std_ulogic;
  signal omsp0_not_dmem_cen : std_ulogic;
  signal omsp0_dmem_din     : std_ulogic_vector (15 downto 0);
  signal omsp0_dmem_wen     : std_ulogic_vector (1 downto 0);
  signal omsp0_not_dmem_wen : std_ulogic_vector (1 downto 0);
  signal omsp0_dmem_dout    : std_ulogic_vector (15 downto 0);

  signal omsp1_dmem_addr    : std_ulogic_vector (DMEM_MSB downto 0);
  signal omsp1_dmem_cen     : std_ulogic;
  signal omsp1_not_dmem_cen : std_ulogic;
  signal omsp1_dmem_din     : std_ulogic_vector (15 downto 0);
  signal omsp1_dmem_wen     : std_ulogic_vector (1 downto 0);
  signal omsp1_not_dmem_wen : std_ulogic_vector (1 downto 0);
  signal omsp1_dmem_dout    : std_ulogic_vector (15 downto 0);

  signal omsp2_dmem_addr    : std_ulogic_vector (DMEM_MSB downto 0);
  signal omsp2_dmem_cen     : std_ulogic;
  signal omsp2_not_dmem_cen : std_ulogic;
  signal omsp2_dmem_din     : std_ulogic_vector (15 downto 0);
  signal omsp2_dmem_wen     : std_ulogic_vector (1 downto 0);
  signal omsp2_not_dmem_wen : std_ulogic_vector (1 downto 0);
  signal omsp2_dmem_dout    : std_ulogic_vector (15 downto 0);

  signal omsp3_dmem_addr    : std_ulogic_vector (DMEM_MSB downto 0);
  signal omsp3_dmem_cen     : std_ulogic;
  signal omsp3_not_dmem_cen : std_ulogic;
  signal omsp3_dmem_din     : std_ulogic_vector (15 downto 0);
  signal omsp3_dmem_wen     : std_ulogic_vector (1 downto 0);
  signal omsp3_not_dmem_wen : std_ulogic_vector (1 downto 0);
  signal omsp3_dmem_dout    : std_ulogic_vector (15 downto 0);

  --Data memory (CPU 4 - CPU 5 - CPU 6 - CPU 7)
  signal omsp4_dmem_addr       : std_ulogic_vector (DMEM_MSB downto 0);
  signal omsp4_dmem_cen        : std_ulogic;
  signal omsp4_dmem_cen_sp     : std_ulogic;
  signal omsp4_not_dmem_cen_sp : std_ulogic;
  signal omsp4_dmem_cen_dp     : std_ulogic;
  signal omsp4_not_dmem_cen_dp : std_ulogic;
  signal omsp4_dmem_din        : std_ulogic_vector (15 downto 0);
  signal omsp4_dmem_wen        : std_ulogic_vector (1 downto 0);
  signal omsp4_not_dmem_wen    : std_ulogic_vector (1 downto 0);
  signal omsp4_dmem_dout       : std_ulogic_vector (15 downto 0);
  signal omsp4_dmem_dout_sp    : std_ulogic_vector (15 downto 0);
  signal omsp4_dmem_dout_dp    : std_ulogic_vector (15 downto 0);
  signal omsp4_dmem_dout_sel   : std_ulogic;

  signal omsp5_dmem_addr       : std_ulogic_vector (DMEM_MSB downto 0);
  signal omsp5_dmem_cen        : std_ulogic;
  signal omsp5_dmem_cen_sp     : std_ulogic;
  signal omsp5_not_dmem_cen_sp : std_ulogic;
  signal omsp5_dmem_cen_dp     : std_ulogic;
  signal omsp5_not_dmem_cen_dp : std_ulogic;
  signal omsp5_dmem_din        : std_ulogic_vector (15 downto 0);
  signal omsp5_dmem_wen        : std_ulogic_vector (1 downto 0);
  signal omsp5_not_dmem_wen    : std_ulogic_vector (1 downto 0);
  signal omsp5_dmem_dout       : std_ulogic_vector (15 downto 0);
  signal omsp5_dmem_dout_sp    : std_ulogic_vector (15 downto 0);
  signal omsp5_dmem_dout_dp    : std_ulogic_vector (15 downto 0);
  signal omsp5_dmem_dout_sel   : std_ulogic;

  signal omsp6_dmem_addr       : std_ulogic_vector (DMEM_MSB downto 0);
  signal omsp6_dmem_cen        : std_ulogic;
  signal omsp6_dmem_cen_sp     : std_ulogic;
  signal omsp6_not_dmem_cen_sp : std_ulogic;
  signal omsp6_dmem_cen_dp     : std_ulogic;
  signal omsp6_not_dmem_cen_dp : std_ulogic;
  signal omsp6_dmem_din        : std_ulogic_vector (15 downto 0);
  signal omsp6_dmem_wen        : std_ulogic_vector (1 downto 0);
  signal omsp6_not_dmem_wen    : std_ulogic_vector (1 downto 0);
  signal omsp6_dmem_dout       : std_ulogic_vector (15 downto 0);
  signal omsp6_dmem_dout_sp    : std_ulogic_vector (15 downto 0);
  signal omsp6_dmem_dout_dp    : std_ulogic_vector (15 downto 0);
  signal omsp6_dmem_dout_sel   : std_ulogic;

  signal omsp7_dmem_addr       : std_ulogic_vector (DMEM_MSB downto 0);
  signal omsp7_dmem_cen        : std_ulogic;
  signal omsp7_dmem_cen_sp     : std_ulogic;
  signal omsp7_not_dmem_cen_sp : std_ulogic;
  signal omsp7_dmem_cen_dp     : std_ulogic;
  signal omsp7_not_dmem_cen_dp : std_ulogic;
  signal omsp7_dmem_din        : std_ulogic_vector (15 downto 0);
  signal omsp7_dmem_wen        : std_ulogic_vector (1 downto 0);
  signal omsp7_not_dmem_wen    : std_ulogic_vector (1 downto 0);
  signal omsp7_dmem_dout       : std_ulogic_vector (15 downto 0);
  signal omsp7_dmem_dout_sp    : std_ulogic_vector (15 downto 0);
  signal omsp7_dmem_dout_dp    : std_ulogic_vector (15 downto 0);
  signal omsp7_dmem_dout_sel   : std_ulogic;

  --Instruction memory (CPU 4 - CPU 5 - CPU 6 - CPU 7)
  signal omsp4_pmem_addr    : std_ulogic_vector (PMEM_MSB downto 0);
  signal omsp4_pmem_cen     : std_ulogic;
  signal omsp4_not_pmem_cen : std_ulogic;
  signal omsp4_pmem_din     : std_ulogic_vector (15 downto 0);
  signal omsp4_pmem_wen     : std_ulogic_vector (1 downto 0);
  signal omsp4_not_pmem_wen : std_ulogic_vector (1 downto 0);
  signal omsp4_pmem_dout    : std_ulogic_vector (15 downto 0);

  signal omsp5_pmem_addr    : std_ulogic_vector (PMEM_MSB downto 0);
  signal omsp5_pmem_cen     : std_ulogic;
  signal omsp5_not_pmem_cen : std_ulogic;
  signal omsp5_pmem_din     : std_ulogic_vector (15 downto 0);
  signal omsp5_pmem_wen     : std_ulogic_vector (1 downto 0);
  signal omsp5_not_pmem_wen : std_ulogic_vector (1 downto 0);
  signal omsp5_pmem_dout    : std_ulogic_vector (15 downto 0);

  signal omsp6_pmem_addr    : std_ulogic_vector (PMEM_MSB downto 0);
  signal omsp6_pmem_cen     : std_ulogic;
  signal omsp6_not_pmem_cen : std_ulogic;
  signal omsp6_pmem_din     : std_ulogic_vector (15 downto 0);
  signal omsp6_pmem_wen     : std_ulogic_vector (1 downto 0);
  signal omsp6_not_pmem_wen : std_ulogic_vector (1 downto 0);
  signal omsp6_pmem_dout    : std_ulogic_vector (15 downto 0);

  signal omsp7_pmem_addr    : std_ulogic_vector (PMEM_MSB downto 0);
  signal omsp7_pmem_cen     : std_ulogic;
  signal omsp7_not_pmem_cen : std_ulogic;
  signal omsp7_pmem_din     : std_ulogic_vector (15 downto 0);
  signal omsp7_pmem_wen     : std_ulogic_vector (1 downto 0);
  signal omsp7_not_pmem_wen : std_ulogic_vector (1 downto 0);
  signal omsp7_pmem_dout    : std_ulogic_vector (15 downto 0);

  --UART
  signal omsp_uart_rxd  : std_ulogic;
  signal omsp0_uart_txd : std_ulogic;

  --GPIO
  signal gpio_in     : std_ulogic_vector (3 downto 0);
  signal omspx_out   : std_ulogic_vector (1 downto 0);
  signal omspy_out   : std_ulogic_vector (1 downto 0);

  component MSP430_PU
    port (
      --CPU registers   
      r0  : out std_ulogic_vector (15 downto 0);
      r1  : out std_ulogic_vector (15 downto 0);
      r2  : out std_ulogic_vector (15 downto 0);
      r3  : out std_ulogic_vector (15 downto 0);
      r4  : out std_ulogic_vector (15 downto 0);
      r5  : out std_ulogic_vector (15 downto 0);
      r6  : out std_ulogic_vector (15 downto 0);
      r7  : out std_ulogic_vector (15 downto 0);
      r8  : out std_ulogic_vector (15 downto 0);
      r9  : out std_ulogic_vector (15 downto 0);
      r10 : out std_ulogic_vector (15 downto 0);
      r11 : out std_ulogic_vector (15 downto 0);
      r12 : out std_ulogic_vector (15 downto 0);
      r13 : out std_ulogic_vector (15 downto 0);
      r14 : out std_ulogic_vector (15 downto 0);
      r15 : out std_ulogic_vector (15 downto 0);

      --Debug interface
      dbg_en  : out std_ulogic;
      dbg_clk : out std_ulogic;
      dbg_rst : out std_ulogic;

      --Interrupt detection
      irq_detect : out std_ulogic;
      nmi_pnd    : out std_ulogic;

      i_state : out std_ulogic_vector (2 downto 0);
      e_state : out std_ulogic_vector (3 downto 0);
      decode  : out std_ulogic;
      ir      : out std_ulogic_vector (15 downto 0);
      irq_num : out std_ulogic_vector (5 downto 0);
      pc      : out std_ulogic_vector (15 downto 0);

      --CPU internals
      mclk    : out std_ulogic;
      puc_rst : out std_ulogic;

      --Clock & Reset
      dco_clk : in std_ulogic;
      reset_n : in std_ulogic;

      --Serial Debug Interface (I2C)
      dbg_i2c_addr      : in  std_ulogic_vector (6 downto 0);
      dbg_i2c_broadcast : in  std_ulogic_vector (6 downto 0);
      dbg_i2c_scl       : in  std_ulogic;
      dbg_i2c_sda_in    : in  std_ulogic;
      dbg_i2c_sda_out   : out std_ulogic;

      --Data Memory
      dmem_dout : in  std_ulogic_vector (15 downto 0);
      dmem_addr : out std_ulogic_vector (DMEM_MSB downto 0);
      dmem_cen  : out std_ulogic;
      dmem_din  : out std_ulogic_vector (15 downto 0);
      dmem_wen  : out std_ulogic_vector (1 downto 0);

      --Instruction Memory
      pmem_dout : in  std_ulogic_vector (15 downto 0);
      pmem_addr : out std_ulogic_vector (PMEM_MSB downto 0);
      pmem_cen  : out std_ulogic;
      pmem_din  : out std_ulogic_vector (15 downto 0);
      pmem_wen  : out std_ulogic_vector (1 downto 0);

      --UART
      uart_rxd : in  std_ulogic;
      uart_txd : out std_ulogic;

      --GPIO
      gpio_in  : in  std_ulogic_vector (3 downto 0);
      gpio_out : out std_ulogic_vector (1 downto 0));
  end component MSP430_PU;

  component omsp_sync_reset
    port (
      rst_s : out std_ulogic;
      clk   : in  std_ulogic;
      rst_a : in  std_ulogic);
  end component omsp_sync_reset;

  component io_cell
    port (
      pad         : inout std_ulogic;
      data_in     : out   std_ulogic;
      data_out    : in    std_ulogic;
      data_out_en : in    std_ulogic);
  end component io_cell;

  component DATA_MEMORY_DISTRIBUTED_SINGLEPORT
    port (
      clka  : in  std_ulogic;
      ena   : in  std_ulogic;
      wea   : in  std_ulogic_vector (1 downto 0);
      addra : in  std_ulogic_vector (DMEM_MSB - 1 downto 0);
      dina  : in  std_ulogic_vector (15 downto 0);
      douta : out std_ulogic_vector (15 downto 0));
  end component DATA_MEMORY_DISTRIBUTED_SINGLEPORT;

  component INSTRUCTION_MEMORY_DISTRIBUTED_SINGLEPORT
    port (
      clka  : in  std_ulogic;
      ena   : in  std_ulogic;
      wea   : in  std_ulogic_vector (1 downto 0);
      addra : in  std_ulogic_vector (PMEM_MSB - 1 downto 0);
      dina  : in  std_ulogic_vector (15 downto 0);
      douta : out std_ulogic_vector (15 downto 0));
  end component INSTRUCTION_MEMORY_DISTRIBUTED_SINGLEPORT;

  component DATA_MEMORY_DISTRIBUTED_QUADPORT
    port (
      douta : out std_ulogic_vector (15 downto 0);
      doutb : out std_ulogic_vector (15 downto 0);
      doutx : out std_ulogic_vector (15 downto 0);
      douty : out std_ulogic_vector (15 downto 0);

      addra : in std_ulogic_vector (DMEM_MSB - 1 downto 0);
      ena   : in std_ulogic;
      clka  : in std_ulogic;
      dina  : in std_ulogic_vector (15 downto 0);
      wea   : in std_ulogic_vector (1 downto 0);
      addrb : in std_ulogic_vector (DMEM_MSB - 1 downto 0);
      enb   : in std_ulogic;
      clkb  : in std_ulogic;
      dinb  : in std_ulogic_vector (15 downto 0);
      web   : in std_ulogic_vector (1 downto 0);
      addrx : in std_ulogic_vector (DMEM_MSB - 1 downto 0);
      enx   : in std_ulogic;
      clkx  : in std_ulogic;
      dinx  : in std_ulogic_vector (15 downto 0);
      wex   : in std_ulogic_vector (1 downto 0);
      addry : in std_ulogic_vector (DMEM_MSB - 1 downto 0);
      eny   : in std_ulogic;
      clky  : in std_ulogic;
      diny  : in std_ulogic_vector (15 downto 0);
      wey   : in std_ulogic_vector (1 downto 0));
  end component DATA_MEMORY_DISTRIBUTED_QUADPORT;

  component DATA_MEMORY_SHARED_QUADPORT
    port (
      douta : out std_ulogic_vector (15 downto 0);
      doutb : out std_ulogic_vector (15 downto 0);
      doutx : out std_ulogic_vector (15 downto 0);
      douty : out std_ulogic_vector (15 downto 0);

      addra : in std_ulogic_vector (DMEM_MSB downto 0);
      ena   : in std_ulogic;
      clka  : in std_ulogic;
      dina  : in std_ulogic_vector (15 downto 0);
      wea   : in std_ulogic_vector (1 downto 0);
      addrb : in std_ulogic_vector (DMEM_MSB downto 0);
      enb   : in std_ulogic;
      clkb  : in std_ulogic;
      dinb  : in std_ulogic_vector (15 downto 0);
      web   : in std_ulogic_vector (1 downto 0);
      addrx : in std_ulogic_vector (DMEM_MSB downto 0);
      enx   : in std_ulogic;
      clkx  : in std_ulogic;
      dinx  : in std_ulogic_vector (15 downto 0);
      wex   : in std_ulogic_vector (1 downto 0);
      addry : in std_ulogic_vector (DMEM_MSB downto 0);
      eny   : in std_ulogic;
      clky  : in std_ulogic;
      diny  : in std_ulogic_vector (15 downto 0);
      wey   : in std_ulogic_vector (1 downto 0));
  end component DATA_MEMORY_SHARED_QUADPORT;

  component INSTRUCTION_MEMORY_DISTRIBUTED_QUADPORT
    port (
      douta : out std_ulogic_vector (15 downto 0);
      doutb : out std_ulogic_vector (15 downto 0);
      doutx : out std_ulogic_vector (15 downto 0);
      douty : out std_ulogic_vector (15 downto 0);

      addra : in std_ulogic_vector (PMEM_MSB - 1 downto 0);
      ena   : in std_ulogic;
      clka  : in std_ulogic;
      dina  : in std_ulogic_vector (15 downto 0);
      wea   : in std_ulogic_vector (1 downto 0);
      addrb : in std_ulogic_vector (PMEM_MSB - 1 downto 0);
      enb   : in std_ulogic;
      clkb  : in std_ulogic;
      dinb  : in std_ulogic_vector (15 downto 0);
      web   : in std_ulogic_vector (1 downto 0);
      addrx : in std_ulogic_vector (PMEM_MSB - 1 downto 0);
      enx   : in std_ulogic;
      clkx  : in std_ulogic;
      dinx  : in std_ulogic_vector (15 downto 0);
      wex   : in std_ulogic_vector (1 downto 0);
      addry : in std_ulogic_vector (PMEM_MSB - 1 downto 0);
      eny   : in std_ulogic;
      clky  : in std_ulogic;
      diny  : in std_ulogic_vector (15 downto 0);
      wey   : in std_ulogic_vector (1 downto 0));
  end component INSTRUCTION_MEMORY_DISTRIBUTED_QUADPORT;

  component INSTRUCTION_MEMORY_SHARED_QUADPORT
    port (
      douta : out std_ulogic_vector (15 downto 0);
      doutb : out std_ulogic_vector (15 downto 0);
      doutx : out std_ulogic_vector (15 downto 0);
      douty : out std_ulogic_vector (15 downto 0);

      addra : in std_ulogic_vector (PMEM_MSB downto 0);
      ena   : in std_ulogic;
      clka  : in std_ulogic;
      dina  : in std_ulogic_vector (15 downto 0);
      wea   : in std_ulogic_vector (1 downto 0);
      addrb : in std_ulogic_vector (PMEM_MSB downto 0);
      enb   : in std_ulogic;
      clkb  : in std_ulogic;
      dinb  : in std_ulogic_vector (15 downto 0);
      web   : in std_ulogic_vector (1 downto 0);
      addrx : in std_ulogic_vector (PMEM_MSB downto 0);
      enx   : in std_ulogic;
      clkx  : in std_ulogic;
      dinx  : in std_ulogic_vector (15 downto 0);
      wex   : in std_ulogic_vector (1 downto 0);
      addry : in std_ulogic_vector (PMEM_MSB downto 0);
      eny   : in std_ulogic;
      clky  : in std_ulogic;
      diny  : in std_ulogic_vector (15 downto 0);
      wey   : in std_ulogic_vector (1 downto 0));
  end component INSTRUCTION_MEMORY_SHARED_QUADPORT;

begin
  SOURCE_GENERATOR : block
  begin
    --RESET
    --Reset input buffer
    reset_pin   <= USER_RESET;
    reset_pin_n <= not reset_pin;

    --Release the reset only, if the DCM is locked
    reset_n <= reset_pin_n;

    --Top level reset generation
    sync_reset_dco : omsp_sync_reset
      port map (
        rst_s => dco_rst,
        clk   => dco_clk,
        rst_a => not_reset_n);

    not_reset_n <= reset_n;

    --CLOCK GENERATION
    --Input buffers
    dco_clk <= USER_CLOCK;
  end block SOURCE_GENERATOR;

  PU : block
  begin
    MSP430_PU_0 : MSP430_PU
      port map (
        --CPU registers 
        r0  => open,
        r1  => open,
        r2  => open,
        r3  => open,
        r4  => open,
        r5  => open,
        r6  => open,
        r7  => open,
        r8  => open,
        r9  => open,
        r10 => open,
        r11 => open,
        r12 => open,
        r13 => open,
        r14 => open,
        r15 => open,

        --Debug interface
        dbg_en  => open,
        dbg_clk => open,
        dbg_rst => open,

        --Interrupt detection
        irq_detect => open,
        nmi_pnd    => open,

        i_state => open,
        e_state => open,
        decode  => open,
        ir      => open,
        irq_num => open,
        pc      => open,

        --CPU internals
        mclk    => open,
        puc_rst => open,

        --Clock & Reset
        dco_clk => dco_clk,
        reset_n => reset_n,

        --Serial Debug Interface (I2C)
        dbg_i2c_addr      => std_ulogic_vector(to_unsigned(50, 7)),
        dbg_i2c_broadcast => std_ulogic_vector(to_unsigned(49, 7)),
        dbg_i2c_scl       => omsp_dbg_i2c_scl,
        dbg_i2c_sda_in    => omsp_dbg_i2c_sda_in,
        dbg_i2c_sda_out   => omsp0_dbg_i2c_sda_out,

        --Data Memory
        dmem_dout => omsp0_dmem_dout,
        dmem_addr => omsp0_dmem_addr,
        dmem_cen  => omsp0_dmem_cen,
        dmem_din  => omsp0_dmem_din,
        dmem_wen  => omsp0_dmem_wen,

        --Instruction Memory
        pmem_dout => omsp0_pmem_dout,
        pmem_addr => omsp0_pmem_addr,
        pmem_cen  => omsp0_pmem_cen,
        pmem_din  => omsp0_pmem_din,
        pmem_wen  => omsp0_pmem_wen,

        --UART
        uart_rxd => omsp_uart_rxd,
        uart_txd => omsp0_uart_txd,

        --GPIO
        gpio_in  => gpio_in,
        gpio_out => omspx_out);

    MSP430_PU_1 : MSP430_PU
      port map (
        --CPU registers 
        r0  => open,
        r1  => open,
        r2  => open,
        r3  => open,
        r4  => open,
        r5  => open,
        r6  => open,
        r7  => open,
        r8  => open,
        r9  => open,
        r10 => open,
        r11 => open,
        r12 => open,
        r13 => open,
        r14 => open,
        r15 => open,

        --Debug interface
        dbg_en  => open,
        dbg_clk => open,
        dbg_rst => open,

        --Interrupt detection
        irq_detect => open,
        nmi_pnd    => open,

        i_state => open,
        e_state => open,
        decode  => open,
        ir      => open,
        irq_num => open,
        pc      => open,

        --CPU internals
        mclk    => open,
        puc_rst => open,

        --UART
        uart_rxd => omsp_uart_rxd,
        uart_txd => open,

        --Clock & Reset
        dco_clk => dco_clk,
        reset_n => reset_n,

        --Serial Debug Interface (I2C)
        dbg_i2c_addr      => std_ulogic_vector(to_unsigned(51, 7)),
        dbg_i2c_broadcast => std_ulogic_vector(to_unsigned(49, 7)),
        dbg_i2c_scl       => omsp_dbg_i2c_scl,
        dbg_i2c_sda_in    => omsp_dbg_i2c_sda_in,
        dbg_i2c_sda_out   => omsp1_dbg_i2c_sda_out,

        --Data Memory
        dmem_dout => omsp1_dmem_dout,
        dmem_addr => omsp1_dmem_addr,
        dmem_cen  => omsp1_dmem_cen,
        dmem_din  => omsp1_dmem_din,
        dmem_wen  => omsp1_dmem_wen,

        --Instruction Memory
        pmem_dout => omsp1_pmem_dout,
        pmem_addr => omsp1_pmem_addr,
        pmem_cen  => omsp1_pmem_cen,
        pmem_din  => omsp1_pmem_din,
        pmem_wen  => omsp1_pmem_wen,

        --GPIO
        gpio_in  => gpio_in,
        gpio_out => open);

    MSP430_PU_2 : MSP430_PU
      port map (
        --CPU registers 
        r0  => open,
        r1  => open,
        r2  => open,
        r3  => open,
        r4  => open,
        r5  => open,
        r6  => open,
        r7  => open,
        r8  => open,
        r9  => open,
        r10 => open,
        r11 => open,
        r12 => open,
        r13 => open,
        r14 => open,
        r15 => open,

        --Debug interface
        dbg_en  => open,
        dbg_clk => open,
        dbg_rst => open,

        --Interrupt detection
        irq_detect => open,
        nmi_pnd    => open,

        i_state => open,
        e_state => open,
        decode  => open,
        ir      => open,
        irq_num => open,
        pc      => open,

        --CPU internals
        mclk    => open,
        puc_rst => open,

        --UART
        uart_rxd => omsp_uart_rxd,
        uart_txd => open,

        --Clock & Reset
        dco_clk => dco_clk,
        reset_n => reset_n,

        --Serial Debug Interface (I2C)
        dbg_i2c_addr      => std_ulogic_vector(to_unsigned(52, 7)),
        dbg_i2c_broadcast => std_ulogic_vector(to_unsigned(49, 7)),
        dbg_i2c_scl       => omsp_dbg_i2c_scl,
        dbg_i2c_sda_in    => omsp_dbg_i2c_sda_in,
        dbg_i2c_sda_out   => omsp2_dbg_i2c_sda_out,

        --Data Memory
        dmem_dout => omsp2_dmem_dout,
        dmem_addr => omsp2_dmem_addr,
        dmem_cen  => omsp2_dmem_cen,
        dmem_din  => omsp2_dmem_din,
        dmem_wen  => omsp2_dmem_wen,

        --Instruction Memory
        pmem_dout => omsp2_pmem_dout,
        pmem_addr => omsp2_pmem_addr,
        pmem_cen  => omsp2_pmem_cen,
        pmem_din  => omsp2_pmem_din,
        pmem_wen  => omsp2_pmem_wen,

        --GPIO
        gpio_in  => gpio_in,
        gpio_out => open);

    MSP430_PU_3 : MSP430_PU
      port map (
        --CPU registers 
        r0  => open,
        r1  => open,
        r2  => open,
        r3  => open,
        r4  => open,
        r5  => open,
        r6  => open,
        r7  => open,
        r8  => open,
        r9  => open,
        r10 => open,
        r11 => open,
        r12 => open,
        r13 => open,
        r14 => open,
        r15 => open,

        --Debug interface
        dbg_en  => open,
        dbg_clk => open,
        dbg_rst => open,

        --Interrupt detection
        irq_detect => open,
        nmi_pnd    => open,

        i_state => open,
        e_state => open,
        decode  => open,
        ir      => open,
        irq_num => open,
        pc      => open,

        --CPU internals
        mclk    => open,
        puc_rst => open,

        --UART
        uart_rxd => omsp_uart_rxd,
        uart_txd => open,

        --Clock & Reset
        dco_clk => dco_clk,
        reset_n => reset_n,

        --Serial Debug Interface (I2C)
        dbg_i2c_addr      => std_ulogic_vector(to_unsigned(53, 7)),
        dbg_i2c_broadcast => std_ulogic_vector(to_unsigned(49, 7)),
        dbg_i2c_scl       => omsp_dbg_i2c_scl,
        dbg_i2c_sda_in    => omsp_dbg_i2c_sda_in,
        dbg_i2c_sda_out   => omsp3_dbg_i2c_sda_out,

        --Data Memory
        dmem_dout => omsp3_dmem_dout,
        dmem_addr => omsp3_dmem_addr,
        dmem_cen  => omsp3_dmem_cen,
        dmem_din  => omsp3_dmem_din,
        dmem_wen  => omsp3_dmem_wen,

        --Instruction Memory
        pmem_dout => omsp3_pmem_dout,
        pmem_addr => omsp3_pmem_addr,
        pmem_cen  => omsp3_pmem_cen,
        pmem_din  => omsp3_pmem_din,
        pmem_wen  => omsp3_pmem_wen,

        --GPIO
        gpio_in  => gpio_in,
        gpio_out => open);

    MSP430_PU_4 : MSP430_PU
      port map (
        --CPU registers 
        r0  => open,
        r1  => open,
        r2  => open,
        r3  => open,
        r4  => open,
        r5  => open,
        r6  => open,
        r7  => open,
        r8  => open,
        r9  => open,
        r10 => open,
        r11 => open,
        r12 => open,
        r13 => open,
        r14 => open,
        r15 => open,

        --Debug interface
        dbg_en  => open,
        dbg_clk => open,
        dbg_rst => open,

        --Interrupt detection
        irq_detect => open,
        nmi_pnd    => open,

        i_state => open,
        e_state => open,
        decode  => open,
        ir      => open,
        irq_num => open,
        pc      => open,

        --CPU internals
        mclk    => open,
        puc_rst => open,

        --UART
        uart_rxd => omsp_uart_rxd,
        uart_txd => open,

        --Clock & Reset
        dco_clk => dco_clk,
        reset_n => reset_n,

        --Serial Debug Interface (I2C)
        dbg_i2c_addr      => std_ulogic_vector(to_unsigned(54, 7)),
        dbg_i2c_broadcast => std_ulogic_vector(to_unsigned(49, 7)),
        dbg_i2c_scl       => omsp_dbg_i2c_scl,
        dbg_i2c_sda_in    => omsp_dbg_i2c_sda_in,
        dbg_i2c_sda_out   => omsp4_dbg_i2c_sda_out,

        --Data Memory
        dmem_dout => omsp4_dmem_dout,
        dmem_addr => omsp4_dmem_addr,
        dmem_cen  => omsp4_dmem_cen,
        dmem_din  => omsp4_dmem_din,
        dmem_wen  => omsp4_dmem_wen,

        --Instruction Memory
        pmem_dout => omsp4_pmem_dout,
        pmem_addr => omsp4_pmem_addr,
        pmem_cen  => omsp4_pmem_cen,
        pmem_din  => omsp4_pmem_din,
        pmem_wen  => omsp4_pmem_wen,

        --GPIO
        gpio_in  => gpio_in,
        gpio_out => omspy_out);

    MSP430_PU_5 : MSP430_PU
      port map (
        --CPU registers 
        r0  => open,
        r1  => open,
        r2  => open,
        r3  => open,
        r4  => open,
        r5  => open,
        r6  => open,
        r7  => open,
        r8  => open,
        r9  => open,
        r10 => open,
        r11 => open,
        r12 => open,
        r13 => open,
        r14 => open,
        r15 => open,

        --Debug interface
        dbg_en  => open,
        dbg_clk => open,
        dbg_rst => open,

        --Interrupt detection
        irq_detect => open,
        nmi_pnd    => open,

        i_state => open,
        e_state => open,
        decode  => open,
        ir      => open,
        irq_num => open,
        pc      => open,

        --CPU internals
        mclk    => open,
        puc_rst => open,

        --UART
        uart_rxd => omsp_uart_rxd,
        uart_txd => open,

        --Clock & Reset
        dco_clk => dco_clk,
        reset_n => reset_n,

        --Serial Debug Interface (I2C)
        dbg_i2c_addr      => std_ulogic_vector(to_unsigned(55, 7)),
        dbg_i2c_broadcast => std_ulogic_vector(to_unsigned(49, 7)),
        dbg_i2c_scl       => omsp_dbg_i2c_scl,
        dbg_i2c_sda_in    => omsp_dbg_i2c_sda_in,
        dbg_i2c_sda_out   => omsp5_dbg_i2c_sda_out,

        --Data Memory
        dmem_dout => omsp5_dmem_dout,
        dmem_addr => omsp5_dmem_addr,
        dmem_cen  => omsp5_dmem_cen,
        dmem_din  => omsp5_dmem_din,
        dmem_wen  => omsp5_dmem_wen,

        --Instruction Memory
        pmem_dout => omsp5_pmem_dout,
        pmem_addr => omsp5_pmem_addr,
        pmem_cen  => omsp5_pmem_cen,
        pmem_din  => omsp5_pmem_din,
        pmem_wen  => omsp5_pmem_wen,

        --GPIO
        gpio_in  => gpio_in,
        gpio_out => open);

    MSP430_PU_6 : MSP430_PU
      port map (
        --CPU registers 
        r0  => open,
        r1  => open,
        r2  => open,
        r3  => open,
        r4  => open,
        r5  => open,
        r6  => open,
        r7  => open,
        r8  => open,
        r9  => open,
        r10 => open,
        r11 => open,
        r12 => open,
        r13 => open,
        r14 => open,
        r15 => open,

        --Debug interface
        dbg_en  => open,
        dbg_clk => open,
        dbg_rst => open,

        --Interrupt detection
        irq_detect => open,
        nmi_pnd    => open,

        i_state => open,
        e_state => open,
        decode  => open,
        ir      => open,
        irq_num => open,
        pc      => open,

        --CPU internals
        mclk    => open,
        puc_rst => open,

        --UART
        uart_rxd => omsp_uart_rxd,
        uart_txd => open,

        --Clock & Reset
        dco_clk => dco_clk,
        reset_n => reset_n,

        --Serial Debug Interface (I2C)
        dbg_i2c_addr      => std_ulogic_vector(to_unsigned(56, 7)),
        dbg_i2c_broadcast => std_ulogic_vector(to_unsigned(49, 7)),
        dbg_i2c_scl       => omsp_dbg_i2c_scl,
        dbg_i2c_sda_in    => omsp_dbg_i2c_sda_in,
        dbg_i2c_sda_out   => omsp6_dbg_i2c_sda_out,

        --Data Memory
        dmem_dout => omsp6_dmem_dout,
        dmem_addr => omsp6_dmem_addr,
        dmem_cen  => omsp6_dmem_cen,
        dmem_din  => omsp6_dmem_din,
        dmem_wen  => omsp6_dmem_wen,

        --Instruction Memory
        pmem_dout => omsp6_pmem_dout,
        pmem_addr => omsp6_pmem_addr,
        pmem_cen  => omsp6_pmem_cen,
        pmem_din  => omsp6_pmem_din,
        pmem_wen  => omsp6_pmem_wen,

        --GPIO
        gpio_in  => gpio_in,
        gpio_out => open);

    MSP430_PU_7 : MSP430_PU
      port map (
        --CPU registers 
        r0  => open,
        r1  => open,
        r2  => open,
        r3  => open,
        r4  => open,
        r5  => open,
        r6  => open,
        r7  => open,
        r8  => open,
        r9  => open,
        r10 => open,
        r11 => open,
        r12 => open,
        r13 => open,
        r14 => open,
        r15 => open,

        --Debug interface
        dbg_en  => open,
        dbg_clk => open,
        dbg_rst => open,

        --Interrupt detection
        irq_detect => open,
        nmi_pnd    => open,

        i_state => open,
        e_state => open,
        decode  => open,
        ir      => open,
        irq_num => open,
        pc      => open,

        --CPU internals
        mclk    => open,
        puc_rst => open,

        --UART
        uart_rxd => omsp_uart_rxd,
        uart_txd => open,

        --Clock & Reset
        dco_clk => dco_clk,
        reset_n => reset_n,

        --Serial Debug Interface (I2C)
        dbg_i2c_addr      => std_ulogic_vector(to_unsigned(57, 7)),
        dbg_i2c_broadcast => std_ulogic_vector(to_unsigned(49, 7)),
        dbg_i2c_scl       => omsp_dbg_i2c_scl,
        dbg_i2c_sda_in    => omsp_dbg_i2c_sda_in,
        dbg_i2c_sda_out   => omsp7_dbg_i2c_sda_out,

        --Data Memory
        dmem_dout => omsp7_dmem_dout,
        dmem_addr => omsp7_dmem_addr,
        dmem_cen  => omsp7_dmem_cen,
        dmem_din  => omsp7_dmem_din,
        dmem_wen  => omsp7_dmem_wen,

        --Instruction Memory
        pmem_dout => omsp7_pmem_dout,
        pmem_addr => omsp7_pmem_addr,
        pmem_cen  => omsp7_pmem_cen,
        pmem_din  => omsp7_pmem_din,
        pmem_wen  => omsp7_pmem_wen,

        --GPIO
        gpio_in  => gpio_in,
        gpio_out => open);
  end block PU;

  MEMORIES : block
  begin
    --MISD (CPU 0 - CPU 1 - CPU 2 - CPU 3)
    --Memory muxing (CPU 0)
    omsp0_pmem_cen_sp <= omsp0_pmem_addr (PMEM_MSB) or omsp0_pmem_cen;
    omsp0_pmem_cen_dp <= not omsp0_pmem_addr (PMEM_MSB) or omsp0_pmem_cen;
    omsp0_pmem_dout   <= omsp0_pmem_dout_sp
                       when omsp0_pmem_dout_sel = '1' else omsp0_pmem_dout_dp;

    R0_1c_2c : process (dco_clk, dco_rst)
    begin
      if (dco_rst = '1') then
        omsp0_pmem_dout_sel <= '1';
      elsif (rising_edge(dco_clk)) then
        if (omsp0_pmem_cen_sp = '0') then
          omsp0_pmem_dout_sel <= '1';
        elsif (omsp0_pmem_cen_dp = '0') then
          omsp0_pmem_dout_sel <= '0';
        end if;
      end if;
    end process R0_1c_2c;

    --Memory muxing (CPU 1)
    omsp1_pmem_cen_sp <= omsp1_pmem_addr (PMEM_MSB) or omsp1_pmem_cen;
    omsp1_pmem_cen_dp <= not omsp1_pmem_addr (PMEM_MSB) or omsp1_pmem_cen;
    omsp1_pmem_dout   <= omsp1_pmem_dout_sp
                       when omsp1_pmem_dout_sel = '1' else omsp1_pmem_dout_dp;

    R1_1c_2c : process (dco_clk, dco_rst)
    begin
      if (dco_rst = '1') then
        omsp1_pmem_dout_sel <= '1';
      elsif (rising_edge(dco_clk)) then
        if (omsp1_pmem_cen_sp = '0') then
          omsp1_pmem_dout_sel <= '1';
        elsif (omsp1_pmem_cen_dp = '0') then
          omsp1_pmem_dout_sel <= '0';
        end if;
      end if;
    end process R1_1c_2c;

    --Memory muxing (CPU 2)
    omsp2_pmem_cen_sp <= omsp2_pmem_addr (PMEM_MSB) or omsp2_pmem_cen;
    omsp2_pmem_cen_dp <= not omsp2_pmem_addr (PMEM_MSB) or omsp2_pmem_cen;
    omsp2_pmem_dout   <= omsp2_pmem_dout_sp
                       when omsp2_pmem_dout_sel = '1' else omsp2_pmem_dout_dp;

    R2_1c_2c : process (dco_clk, dco_rst)
    begin
      if (dco_rst = '1') then
        omsp2_pmem_dout_sel <= '1';
      elsif (rising_edge(dco_clk)) then
        if (omsp2_pmem_cen_sp = '0') then
          omsp2_pmem_dout_sel <= '1';
        elsif (omsp2_pmem_cen_dp = '0') then
          omsp2_pmem_dout_sel <= '0';
        end if;
      end if;
    end process R2_1c_2c;

    --Memory muxing (CPU 3)
    omsp3_pmem_cen_sp <= omsp3_pmem_addr (PMEM_MSB) or omsp3_pmem_cen;
    omsp3_pmem_cen_dp <= not omsp3_pmem_addr (PMEM_MSB) or omsp3_pmem_cen;
    omsp3_pmem_dout   <= omsp3_pmem_dout_sp
                       when omsp3_pmem_dout_sel = '1' else omsp3_pmem_dout_dp;

    R3_1c_2c : process (dco_clk, dco_rst)
    begin
      if (dco_rst = '1') then
        omsp3_pmem_dout_sel <= '1';
      elsif (rising_edge(dco_clk)) then
        if (omsp3_pmem_cen_sp = '0') then
          omsp3_pmem_dout_sel <= '1';
        elsif (omsp3_pmem_cen_dp = '0') then
          omsp3_pmem_dout_sel <= '0';
        end if;
      end if;
    end process R3_1c_2c;

    --Instruction Memory (CPU 0)
    INSTRUCTION_MEMORY_DISTRIBUTED_SINGLEPORT_omsp0 : INSTRUCTION_MEMORY_DISTRIBUTED_SINGLEPORT
      port map(
        clka  => dco_clk,
        ena   => omsp0_not_pmem_cen_sp,
        wea   => omsp0_not_pmem_wen,
        addra => omsp0_pmem_addr (PMEM_MSB - 1 downto 0),
        dina  => omsp0_pmem_din,
        douta => omsp0_pmem_dout_sp);

    omsp0_not_pmem_cen_sp <= not omsp0_pmem_cen_sp;
    omsp0_not_pmem_wen    <= not omsp0_pmem_wen;

    --Instruction Memory (CPU 1)
    INSTRUCTION_MEMORY_DISTRIBUTED_SINGLEPORT_omsp1 : INSTRUCTION_MEMORY_DISTRIBUTED_SINGLEPORT
      port map(
        clka  => dco_clk,
        ena   => omsp1_not_pmem_cen_sp,
        wea   => omsp1_not_pmem_wen,
        addra => omsp1_pmem_addr (PMEM_MSB - 1 downto 0),
        dina  => omsp1_pmem_din,
        douta => omsp1_pmem_dout_sp);

    omsp1_not_pmem_cen_sp <= not omsp1_pmem_cen_sp;
    omsp1_not_pmem_wen    <= not omsp1_pmem_wen;

    --Instruction Memory (CPU 2)
    INSTRUCTION_MEMORY_DISTRIBUTED_SINGLEPORT_omsp2 : INSTRUCTION_MEMORY_DISTRIBUTED_SINGLEPORT
      port map(
        clka  => dco_clk,
        ena   => omsp2_not_pmem_cen_sp,
        wea   => omsp2_not_pmem_wen,
        addra => omsp2_pmem_addr (PMEM_MSB - 1 downto 0),
        dina  => omsp2_pmem_din,
        douta => omsp2_pmem_dout_sp);

    omsp2_not_pmem_cen_sp <= not omsp2_pmem_cen_sp;
    omsp2_not_pmem_wen    <= not omsp2_pmem_wen;

    --Instruction Memory (CPU 3)
    INSTRUCTION_MEMORY_DISTRIBUTED_SINGLEPORT_omsp3 : INSTRUCTION_MEMORY_DISTRIBUTED_SINGLEPORT
      port map(
        clka  => dco_clk,
        ena   => omsp3_not_pmem_cen_sp,
        wea   => omsp3_not_pmem_wen,
        addra => omsp3_pmem_addr (PMEM_MSB - 1 downto 0),
        dina  => omsp3_pmem_din,
        douta => omsp3_pmem_dout_sp);

    omsp3_not_pmem_cen_sp <= not omsp3_pmem_cen_sp;
    omsp3_not_pmem_wen    <= not omsp3_pmem_wen;

    --Distributed Instruction Memory (CPU 0 - CPU 1 - CPU 2 - CPU 3)
    INSTRUCTION_MEMORY_DISTRIBUTED_QUADPORT_distributedA : INSTRUCTION_MEMORY_DISTRIBUTED_QUADPORT
      port map (
        douta => omsp0_pmem_dout_dp,
        doutb => omsp1_pmem_dout_dp,
        doutX => omsp2_pmem_dout_dp,
        doutY => omsp3_pmem_dout_dp,

        addra => omsp0_pmem_addr (PMEM_MSB - 1 downto 0),
        ena   => omsp0_not_pmem_cen_dp,
        clka  => dco_clk,
        dina  => omsp0_pmem_din,
        wea   => omsp0_not_pmem_wen,
        addrb => omsp1_pmem_addr (PMEM_MSB - 1 downto 0),
        enb   => omsp1_not_pmem_cen_dp,
        clkb  => dco_clk,
        dinb  => omsp1_pmem_din,
        web   => omsp1_pmem_wen,
        addrx => omsp2_pmem_addr (PMEM_MSB - 1 downto 0),
        enx   => omsp2_not_pmem_cen_dp,
        clkx  => dco_clk,
        dinx  => omsp2_pmem_din,
        wex   => omsp2_pmem_wen,
        addry => omsp3_pmem_addr (PMEM_MSB - 1 downto 0),
        eny   => omsp3_not_pmem_cen_dp,
        clky  => dco_clk,
        diny  => omsp3_pmem_din,
        wey   => omsp3_pmem_wen);

    omsp0_not_pmem_cen_dp <= not omsp0_pmem_cen_dp;
    omsp1_not_pmem_cen_dp <= not omsp1_pmem_cen_dp;
    omsp2_not_pmem_cen_dp <= not omsp2_pmem_cen_dp;
    omsp3_not_pmem_cen_dp <= not omsp3_pmem_cen_dp;


    --Shared Data Memory (CPU 0 - CPU 1 - CPU 2 - CPU 3)
    DATA_MEMORY_SHARED_QUADPORT_sharedA : DATA_MEMORY_SHARED_QUADPORT
      port map (
        douta => omsp0_dmem_dout,
        doutb => omsp1_dmem_dout,
        doutx => omsp2_dmem_dout,
        douty => omsp3_dmem_dout,

        addra => omsp0_dmem_addr,
        ena   => omsp0_not_dmem_cen,
        clka  => dco_clk,
        dina  => omsp0_dmem_din,
        wea   => omsp0_not_dmem_wen,
        addrb => omsp1_dmem_addr,
        enb   => omsp1_not_dmem_cen,
        clkb  => dco_clk,
        dinb  => omsp1_dmem_din,
        web   => omsp1_not_dmem_wen,
        addrx => omsp2_dmem_addr,
        enx   => omsp2_not_dmem_cen,
        clkx  => dco_clk,
        dinx  => omsp2_dmem_din,
        wex   => omsp2_not_dmem_wen,
        addry => omsp3_dmem_addr,
        eny   => omsp3_not_dmem_cen,
        clky  => dco_clk,
        diny  => omsp3_dmem_din,
        wey   => omsp3_not_dmem_wen);

    omsp0_not_dmem_cen <= not omsp0_dmem_cen;
    omsp1_not_dmem_cen <= not omsp1_dmem_cen;
    omsp2_not_dmem_cen <= not omsp2_dmem_cen;
    omsp3_not_dmem_cen <= not omsp3_dmem_cen;

    omsp0_not_dmem_wen <= not omsp0_dmem_wen;
    omsp1_not_dmem_wen <= not omsp1_dmem_wen;
    omsp2_not_dmem_wen <= not omsp2_dmem_wen;
    omsp3_not_dmem_wen <= not omsp3_dmem_wen;


    --SIMD (CPU 4 - CPU 5 - CPU 6 - CPU 7)
    --Memory muxing (CPU 4)
    omsp4_dmem_cen_sp <= omsp4_dmem_addr (DMEM_MSB) or omsp4_dmem_cen;
    omsp4_dmem_cen_dp <= not omsp4_dmem_addr (DMEM_MSB) or omsp4_dmem_cen;
    omsp4_dmem_dout   <= omsp4_dmem_dout_sp
                       when omsp4_dmem_dout_sel = '1' else omsp4_dmem_dout_dp;

    R4_1c_2c : process (dco_clk, dco_rst)
    begin
      if (dco_rst = '1') then
        omsp4_dmem_dout_sel <= '1';
      elsif (rising_edge(dco_clk)) then
        if (omsp4_dmem_cen_sp = '0') then
          omsp4_dmem_dout_sel <= '1';
        elsif (omsp4_dmem_cen_dp = '0') then
          omsp4_dmem_dout_sel <= '0';
        end if;
      end if;
    end process R4_1c_2c;

    --Memory muxing (CPU 5)
    omsp5_dmem_cen_sp <= omsp5_dmem_addr (DMEM_MSB) or omsp5_dmem_cen;
    omsp5_dmem_cen_dp <= not omsp5_dmem_addr (DMEM_MSB) or omsp5_dmem_cen;
    omsp5_dmem_dout   <= omsp5_dmem_dout_sp
                       when omsp5_dmem_dout_sel = '1' else omsp5_dmem_dout_dp;

    R5_1c_2c : process (dco_clk, dco_rst)
    begin
      if (dco_rst = '1') then
        omsp5_dmem_dout_sel <= '1';
      elsif (rising_edge(dco_clk)) then
        if (omsp5_dmem_cen_sp = '0') then
          omsp5_dmem_dout_sel <= '1';
        elsif (omsp5_dmem_cen_dp = '0') then
          omsp5_dmem_dout_sel <= '0';
        end if;
      end if;
    end process R5_1c_2c;

    --Memory muxing (CPU 6)
    omsp6_dmem_cen_sp <= omsp6_dmem_addr (DMEM_MSB) or omsp6_dmem_cen;
    omsp6_dmem_cen_dp <= not omsp6_dmem_addr (DMEM_MSB) or omsp6_dmem_cen;
    omsp6_dmem_dout   <= omsp6_dmem_dout_sp
                       when omsp6_dmem_dout_sel = '1' else omsp6_dmem_dout_dp;

    R6_1c_2c : process (dco_clk, dco_rst)
    begin
      if (dco_rst = '1') then
        omsp6_dmem_dout_sel <= '1';
      elsif (rising_edge(dco_clk)) then
        if (omsp6_dmem_cen_sp = '0') then
          omsp6_dmem_dout_sel <= '1';
        elsif (omsp6_dmem_cen_dp = '0') then
          omsp6_dmem_dout_sel <= '0';
        end if;
      end if;
    end process R6_1c_2c;

    --Memory muxing (CPU 7)
    omsp7_dmem_cen_sp <= omsp7_dmem_addr (DMEM_MSB) or omsp7_dmem_cen;
    omsp7_dmem_cen_dp <= not omsp7_dmem_addr (DMEM_MSB) or omsp7_dmem_cen;
    omsp7_dmem_dout   <= omsp7_dmem_dout_sp
                       when omsp7_dmem_dout_sel = '1' else omsp7_dmem_dout_dp;

    R7_1c_2c : process (dco_clk, dco_rst)
    begin
      if (dco_rst = '1') then
        omsp7_dmem_dout_sel <= '1';
      elsif (rising_edge(dco_clk)) then
        if (omsp7_dmem_cen_sp = '0') then
          omsp7_dmem_dout_sel <= '1';
        elsif (omsp7_dmem_cen_dp = '0') then
          omsp7_dmem_dout_sel <= '0';
        end if;
      end if;
    end process R7_1c_2c;

    --Data Memory (CPU 4)
    DATA_MEMORY_DISTRIBUTED_SINGLEPORT_omsp4 : DATA_MEMORY_DISTRIBUTED_SINGLEPORT
      port map(
        clka  => dco_clk,
        ena   => omsp4_not_dmem_cen_sp,
        wea   => omsp4_not_dmem_wen,
        addra => omsp4_dmem_addr (DMEM_MSB - 1 downto 0),
        dina  => omsp4_dmem_din,
        douta => omsp4_dmem_dout_sp);

    omsp4_not_dmem_cen_sp <= not omsp4_dmem_cen_sp;
    omsp4_not_dmem_wen    <= not omsp4_dmem_wen;

    --Data Memory (CPU 5)
    DATA_MEMORY_DISTRIBUTED_SINGLEPORT_omsp5 : DATA_MEMORY_DISTRIBUTED_SINGLEPORT
      port map(
        clka  => dco_clk,
        ena   => omsp5_not_dmem_cen_sp,
        wea   => omsp5_not_dmem_wen,
        addra => omsp5_dmem_addr (DMEM_MSB - 1 downto 0),
        dina  => omsp5_dmem_din,
        douta => omsp5_dmem_dout_sp);

    omsp5_not_dmem_cen_sp <= not omsp5_dmem_cen_sp;
    omsp5_not_dmem_wen    <= not omsp5_dmem_wen;

    --Data Memory (CPU 6)
    DATA_MEMORY_DISTRIBUTED_SINGLEPORT_omsp6 : DATA_MEMORY_DISTRIBUTED_SINGLEPORT
      port map(
        clka  => dco_clk,
        ena   => omsp6_not_dmem_cen_sp,
        wea   => omsp6_not_dmem_wen,
        addra => omsp6_dmem_addr (DMEM_MSB - 1 downto 0),
        dina  => omsp6_dmem_din,
        douta => omsp6_dmem_dout_sp);

    omsp6_not_dmem_cen_sp <= not omsp6_dmem_cen_sp;
    omsp6_not_dmem_wen    <= not omsp6_dmem_wen;

    --Data Memory (CPU 7)
    DATA_MEMORY_DISTRIBUTED_SINGLEPORT_omsp7 : DATA_MEMORY_DISTRIBUTED_SINGLEPORT
      port map(
        clka  => dco_clk,
        ena   => omsp7_not_dmem_cen_sp,
        wea   => omsp7_not_dmem_wen,
        addra => omsp7_dmem_addr (DMEM_MSB - 1 downto 0),
        dina  => omsp7_dmem_din,
        douta => omsp7_dmem_dout_sp);

    omsp7_not_dmem_cen_sp <= not omsp7_dmem_cen_sp;
    omsp7_not_dmem_wen    <= not omsp7_dmem_wen;

    --Distributed Data Memory (CPU 4 - CPU 5 - CPU 6 - CPU 7)
    DATA_MEMORY_DISTRIBUTED_QUADPORT_distributedB : DATA_MEMORY_DISTRIBUTED_QUADPORT
      port map (
        douta => omsp4_dmem_dout_dp,
        doutb => omsp5_dmem_dout_dp,
        doutx => omsp6_dmem_dout_dp,
        douty => omsp7_dmem_dout_dp,

        addra => omsp4_dmem_addr (DMEM_MSB - 1 downto 0),
        ena   => omsp4_not_dmem_cen_dp,
        clka  => dco_clk,
        dina  => omsp4_dmem_din,
        wea   => omsp4_not_dmem_wen,
        addrb => omsp5_dmem_addr (DMEM_MSB - 1 downto 0),
        enb   => omsp5_not_dmem_cen_dp,
        clkb  => dco_clk,
        dinb  => omsp5_dmem_din,
        web   => omsp5_dmem_wen,
        addrx => omsp6_dmem_addr (DMEM_MSB - 1 downto 0),
        enx   => omsp6_not_dmem_cen_dp,
        clkx  => dco_clk,
        dinx  => omsp6_dmem_din,
        wex   => omsp6_dmem_wen,
        addry => omsp7_dmem_addr (DMEM_MSB - 1 downto 0),
        eny   => omsp7_not_dmem_cen_dp,
        clky  => dco_clk,
        diny  => omsp7_dmem_din,
        wey   => omsp7_dmem_wen);

    omsp4_not_dmem_cen_dp <= not omsp4_dmem_cen_dp;
    omsp5_not_dmem_cen_dp <= not omsp5_dmem_cen_dp;
    omsp6_not_dmem_cen_dp <= not omsp6_dmem_cen_dp;
    omsp7_not_dmem_cen_dp <= not omsp7_dmem_cen_dp;

    --Shared Instruction Memory (CPU 4 - CPU 5 - CPU 6 - CPU 7)
    INSTRUCTION_MEMORY_SHARED_QUADPORT_sharedB : INSTRUCTION_MEMORY_SHARED_QUADPORT
      port map (
        douta => omsp4_pmem_dout,
        doutb => omsp5_pmem_dout,
        doutx => omsp6_pmem_dout,
        douty => omsp7_pmem_dout,

        addra => omsp4_pmem_addr,
        ena   => omsp4_not_pmem_cen,
        clka  => dco_clk,
        dina  => omsp4_pmem_din,
        wea   => omsp4_not_pmem_wen,
        addrb => omsp5_pmem_addr,
        enb   => omsp5_not_pmem_cen,
        clkb  => dco_clk,
        dinb  => omsp5_pmem_din,
        web   => omsp5_not_pmem_wen,
        addrx => omsp6_pmem_addr,
        enx   => omsp6_not_pmem_cen,
        clkx  => dco_clk,
        dinx  => omsp6_pmem_din,
        wex   => omsp6_not_pmem_wen,
        addry => omsp7_pmem_addr,
        eny   => omsp7_not_pmem_cen,
        clky  => dco_clk,
        diny  => omsp7_pmem_din,
        wey   => omsp7_not_pmem_wen);

    omsp4_not_pmem_cen <= not omsp4_pmem_cen;
    omsp5_not_pmem_cen <= not omsp5_pmem_cen;
    omsp6_not_pmem_cen <= not omsp6_pmem_cen;
    omsp7_not_pmem_cen <= not omsp7_pmem_cen;

    omsp4_not_pmem_wen <= not omsp4_pmem_wen;
    omsp5_not_pmem_wen <= not omsp5_pmem_wen;
    omsp6_not_pmem_wen <= not omsp6_pmem_wen;
    omsp7_not_pmem_wen <= not omsp7_pmem_wen;
  end block MEMORIES;

  CELLS : block
  begin
    --User DIP Switch x4
    gpio_in <= GPIO_DIP4 & GPIO_DIP3 & GPIO_DIP2 & GPIO_DIP1;

    --User LEDs                 
    GPIO_LED4 <= omspy_out(1);
    GPIO_LED3 <= omspy_out(0);
    GPIO_LED2 <= omspx_out(1);
    GPIO_LED1 <= omspx_out(0);

    --Silicon Labs CP2102 USB-to-UART Bridge Chip
    omsp_uart_rxd <= USB_RS232_RXD;
    USB_RS232_TXD <= omsp0_uart_txd;

    omsp_dbg_i2c_sda_out <= omsp0_dbg_i2c_sda_out and
                            omsp1_dbg_i2c_sda_out and
                            omsp2_dbg_i2c_sda_out and
                            omsp3_dbg_i2c_sda_out and
                            omsp4_dbg_i2c_sda_out and
                            omsp5_dbg_i2c_sda_out and
                            omsp6_dbg_i2c_sda_out and
                            omsp7_dbg_i2c_sda_out;

    --Connector J5
    PMOD_P3_PIN : io_cell
      port map (
        pad         => PMOD1_P3,
        data_in     => omsp_dbg_i2c_sda_in,
        data_out    => '0',
        data_out_en => omsp_dbg_i2c_sda_out);

    omsp_dbg_i2c_scl <= PMOD1_P4;
  end block CELLS;
end MSP430_SOC_ARQ;

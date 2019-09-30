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

entity MSP430_TESTBENCH is
end MSP430_TESTBENCH;

architecture RTL of MSP430_TESTBENCH is
  component MSP430_MODEL
    port (
      --CORE O
      --CPU registers
      omsp0_r0  : out std_ulogic_vector (15 downto 0);
      omsp0_r1  : out std_ulogic_vector (15 downto 0);
      omsp0_r2  : out std_ulogic_vector (15 downto 0);
      omsp0_r3  : out std_ulogic_vector (15 downto 0);
      omsp0_r4  : out std_ulogic_vector (15 downto 0);
      omsp0_r5  : out std_ulogic_vector (15 downto 0);
      omsp0_r6  : out std_ulogic_vector (15 downto 0);
      omsp0_r7  : out std_ulogic_vector (15 downto 0);
      omsp0_r8  : out std_ulogic_vector (15 downto 0);
      omsp0_r9  : out std_ulogic_vector (15 downto 0);
      omsp0_r10 : out std_ulogic_vector (15 downto 0);
      omsp0_r11 : out std_ulogic_vector (15 downto 0);
      omsp0_r12 : out std_ulogic_vector (15 downto 0);
      omsp0_r13 : out std_ulogic_vector (15 downto 0);
      omsp0_r14 : out std_ulogic_vector (15 downto 0);
      omsp0_r15 : out std_ulogic_vector (15 downto 0);

      --Debug interface
      omsp0_dbg_en  : out std_ulogic;
      omsp0_dbg_clk : out std_ulogic;
      omsp0_dbg_rst : out std_ulogic;

      --Interrupt detection
      omsp0_irq_detect : out std_ulogic;
      omsp0_nmi_pnd    : out std_ulogic;

      omsp0_i_state : out std_ulogic_vector (2 downto 0);
      omsp0_e_state : out std_ulogic_vector (3 downto 0);
      omsp0_decode  : out std_ulogic;
      omsp0_ir      : out std_ulogic_vector (15 downto 0);
      omsp0_irq_num : out std_ulogic_vector (5 downto 0);
      omsp0_pc      : out std_ulogic_vector (15 downto 0);

      --CPU internals
      omsp0_mclk    : out std_ulogic;
      omsp0_puc_rst : out std_ulogic;

      --CORE 1
      --CPU registers
      omsp1_r0  : out std_ulogic_vector (15 downto 0);
      omsp1_r1  : out std_ulogic_vector (15 downto 0);
      omsp1_r2  : out std_ulogic_vector (15 downto 0);
      omsp1_r3  : out std_ulogic_vector (15 downto 0);
      omsp1_r4  : out std_ulogic_vector (15 downto 0);
      omsp1_r5  : out std_ulogic_vector (15 downto 0);
      omsp1_r6  : out std_ulogic_vector (15 downto 0);
      omsp1_r7  : out std_ulogic_vector (15 downto 0);
      omsp1_r8  : out std_ulogic_vector (15 downto 0);
      omsp1_r9  : out std_ulogic_vector (15 downto 0);
      omsp1_r10 : out std_ulogic_vector (15 downto 0);
      omsp1_r11 : out std_ulogic_vector (15 downto 0);
      omsp1_r12 : out std_ulogic_vector (15 downto 0);
      omsp1_r13 : out std_ulogic_vector (15 downto 0);
      omsp1_r14 : out std_ulogic_vector (15 downto 0);
      omsp1_r15 : out std_ulogic_vector (15 downto 0);

      --Debug interface
      omsp1_dbg_en  : out std_ulogic;
      omsp1_dbg_clk : out std_ulogic;
      omsp1_dbg_rst : out std_ulogic;

      --Interrupt detection
      omsp1_irq_detect : out std_ulogic;
      omsp1_nmi_pnd    : out std_ulogic;

      omsp1_i_state : out std_ulogic_vector (2 downto 0);
      omsp1_e_state : out std_ulogic_vector (3 downto 0);
      omsp1_decode  : out std_ulogic;
      omsp1_ir      : out std_ulogic_vector (15 downto 0);
      omsp1_irq_num : out std_ulogic_vector (5 downto 0);
      omsp1_pc      : out std_ulogic_vector (15 downto 0);

      --CPU internals
      omsp1_mclk    : out std_ulogic;
      omsp1_puc_rst : out std_ulogic;

      --CORE 2
      --CPU registers
      omsp2_r0  : out std_ulogic_vector (15 downto 0);
      omsp2_r1  : out std_ulogic_vector (15 downto 0);
      omsp2_r2  : out std_ulogic_vector (15 downto 0);
      omsp2_r3  : out std_ulogic_vector (15 downto 0);
      omsp2_r4  : out std_ulogic_vector (15 downto 0);
      omsp2_r5  : out std_ulogic_vector (15 downto 0);
      omsp2_r6  : out std_ulogic_vector (15 downto 0);
      omsp2_r7  : out std_ulogic_vector (15 downto 0);
      omsp2_r8  : out std_ulogic_vector (15 downto 0);
      omsp2_r9  : out std_ulogic_vector (15 downto 0);
      omsp2_r10 : out std_ulogic_vector (15 downto 0);
      omsp2_r11 : out std_ulogic_vector (15 downto 0);
      omsp2_r12 : out std_ulogic_vector (15 downto 0);
      omsp2_r13 : out std_ulogic_vector (15 downto 0);
      omsp2_r14 : out std_ulogic_vector (15 downto 0);
      omsp2_r15 : out std_ulogic_vector (15 downto 0);

      --Debug interface
      omsp2_dbg_en  : out std_ulogic;
      omsp2_dbg_clk : out std_ulogic;
      omsp2_dbg_rst : out std_ulogic;

      --Interrupt detection
      omsp2_irq_detect : out std_ulogic;
      omsp2_nmi_pnd    : out std_ulogic;

      omsp2_i_state : out std_ulogic_vector (2 downto 0);
      omsp2_e_state : out std_ulogic_vector (3 downto 0);
      omsp2_decode  : out std_ulogic;
      omsp2_ir      : out std_ulogic_vector (15 downto 0);
      omsp2_irq_num : out std_ulogic_vector (5 downto 0);
      omsp2_pc      : out std_ulogic_vector (15 downto 0);

      --CPU internals
      omsp2_mclk    : out std_ulogic;
      omsp2_puc_rst : out std_ulogic;

      --CORE 3
      --CPU registers
      omsp3_r0  : out std_ulogic_vector (15 downto 0);
      omsp3_r1  : out std_ulogic_vector (15 downto 0);
      omsp3_r2  : out std_ulogic_vector (15 downto 0);
      omsp3_r3  : out std_ulogic_vector (15 downto 0);
      omsp3_r4  : out std_ulogic_vector (15 downto 0);
      omsp3_r5  : out std_ulogic_vector (15 downto 0);
      omsp3_r6  : out std_ulogic_vector (15 downto 0);
      omsp3_r7  : out std_ulogic_vector (15 downto 0);
      omsp3_r8  : out std_ulogic_vector (15 downto 0);
      omsp3_r9  : out std_ulogic_vector (15 downto 0);
      omsp3_r10 : out std_ulogic_vector (15 downto 0);
      omsp3_r11 : out std_ulogic_vector (15 downto 0);
      omsp3_r12 : out std_ulogic_vector (15 downto 0);
      omsp3_r13 : out std_ulogic_vector (15 downto 0);
      omsp3_r14 : out std_ulogic_vector (15 downto 0);
      omsp3_r15 : out std_ulogic_vector (15 downto 0);

      --Debug interface
      omsp3_dbg_en  : out std_ulogic;
      omsp3_dbg_clk : out std_ulogic;
      omsp3_dbg_rst : out std_ulogic;

      --Interrupt detection
      omsp3_irq_detect : out std_ulogic;
      omsp3_nmi_pnd    : out std_ulogic;

      omsp3_i_state : out std_ulogic_vector (2 downto 0);
      omsp3_e_state : out std_ulogic_vector (3 downto 0);
      omsp3_decode  : out std_ulogic;
      omsp3_ir      : out std_ulogic_vector (15 downto 0);
      omsp3_irq_num : out std_ulogic_vector (5 downto 0);
      omsp3_pc      : out std_ulogic_vector (15 downto 0);

      --CPU internals
      omsp3_mclk    : out std_ulogic;
      omsp3_puc_rst : out std_ulogic;

      --CORE 4
      --CPU registers
      omsp4_r0  : out std_ulogic_vector (15 downto 0);
      omsp4_r1  : out std_ulogic_vector (15 downto 0);
      omsp4_r2  : out std_ulogic_vector (15 downto 0);
      omsp4_r3  : out std_ulogic_vector (15 downto 0);
      omsp4_r4  : out std_ulogic_vector (15 downto 0);
      omsp4_r5  : out std_ulogic_vector (15 downto 0);
      omsp4_r6  : out std_ulogic_vector (15 downto 0);
      omsp4_r7  : out std_ulogic_vector (15 downto 0);
      omsp4_r8  : out std_ulogic_vector (15 downto 0);
      omsp4_r9  : out std_ulogic_vector (15 downto 0);
      omsp4_r10 : out std_ulogic_vector (15 downto 0);
      omsp4_r11 : out std_ulogic_vector (15 downto 0);
      omsp4_r12 : out std_ulogic_vector (15 downto 0);
      omsp4_r13 : out std_ulogic_vector (15 downto 0);
      omsp4_r14 : out std_ulogic_vector (15 downto 0);
      omsp4_r15 : out std_ulogic_vector (15 downto 0);

      --Debug interface
      omsp4_dbg_en  : out std_ulogic;
      omsp4_dbg_clk : out std_ulogic;
      omsp4_dbg_rst : out std_ulogic;

      --Interrupt detection
      omsp4_irq_detect : out std_ulogic;
      omsp4_nmi_pnd    : out std_ulogic;

      omsp4_i_state : out std_ulogic_vector (2 downto 0);
      omsp4_e_state : out std_ulogic_vector (3 downto 0);
      omsp4_decode  : out std_ulogic;
      omsp4_ir      : out std_ulogic_vector (15 downto 0);
      omsp4_irq_num : out std_ulogic_vector (5 downto 0);
      omsp4_pc      : out std_ulogic_vector (15 downto 0);

      --CPU internals
      omsp4_mclk    : out std_ulogic;
      omsp4_puc_rst : out std_ulogic;

      --CORE 5
      --CPU registers
      omsp5_r0  : out std_ulogic_vector (15 downto 0);
      omsp5_r1  : out std_ulogic_vector (15 downto 0);
      omsp5_r2  : out std_ulogic_vector (15 downto 0);
      omsp5_r3  : out std_ulogic_vector (15 downto 0);
      omsp5_r4  : out std_ulogic_vector (15 downto 0);
      omsp5_r5  : out std_ulogic_vector (15 downto 0);
      omsp5_r6  : out std_ulogic_vector (15 downto 0);
      omsp5_r7  : out std_ulogic_vector (15 downto 0);
      omsp5_r8  : out std_ulogic_vector (15 downto 0);
      omsp5_r9  : out std_ulogic_vector (15 downto 0);
      omsp5_r10 : out std_ulogic_vector (15 downto 0);
      omsp5_r11 : out std_ulogic_vector (15 downto 0);
      omsp5_r12 : out std_ulogic_vector (15 downto 0);
      omsp5_r13 : out std_ulogic_vector (15 downto 0);
      omsp5_r14 : out std_ulogic_vector (15 downto 0);
      omsp5_r15 : out std_ulogic_vector (15 downto 0);

      --Debug interface
      omsp5_dbg_en  : out std_ulogic;
      omsp5_dbg_clk : out std_ulogic;
      omsp5_dbg_rst : out std_ulogic;

      --Interrupt detection
      omsp5_irq_detect : out std_ulogic;
      omsp5_nmi_pnd    : out std_ulogic;

      omsp5_i_state : out std_ulogic_vector (2 downto 0);
      omsp5_e_state : out std_ulogic_vector (3 downto 0);
      omsp5_decode  : out std_ulogic;
      omsp5_ir      : out std_ulogic_vector (15 downto 0);
      omsp5_irq_num : out std_ulogic_vector (5 downto 0);
      omsp5_pc      : out std_ulogic_vector (15 downto 0);

      --CPU internals
      omsp5_mclk    : out std_ulogic;
      omsp5_puc_rst : out std_ulogic;

      --CORE 6
      --CPU registers
      omsp6_r0  : out std_ulogic_vector (15 downto 0);
      omsp6_r1  : out std_ulogic_vector (15 downto 0);
      omsp6_r2  : out std_ulogic_vector (15 downto 0);
      omsp6_r3  : out std_ulogic_vector (15 downto 0);
      omsp6_r4  : out std_ulogic_vector (15 downto 0);
      omsp6_r5  : out std_ulogic_vector (15 downto 0);
      omsp6_r6  : out std_ulogic_vector (15 downto 0);
      omsp6_r7  : out std_ulogic_vector (15 downto 0);
      omsp6_r8  : out std_ulogic_vector (15 downto 0);
      omsp6_r9  : out std_ulogic_vector (15 downto 0);
      omsp6_r10 : out std_ulogic_vector (15 downto 0);
      omsp6_r11 : out std_ulogic_vector (15 downto 0);
      omsp6_r12 : out std_ulogic_vector (15 downto 0);
      omsp6_r13 : out std_ulogic_vector (15 downto 0);
      omsp6_r14 : out std_ulogic_vector (15 downto 0);
      omsp6_r15 : out std_ulogic_vector (15 downto 0);

      --Debug interface
      omsp6_dbg_en  : out std_ulogic;
      omsp6_dbg_clk : out std_ulogic;
      omsp6_dbg_rst : out std_ulogic;

      --Interrupt detection
      omsp6_irq_detect : out std_ulogic;
      omsp6_nmi_pnd    : out std_ulogic;

      omsp6_i_state : out std_ulogic_vector (2 downto 0);
      omsp6_e_state : out std_ulogic_vector (3 downto 0);
      omsp6_decode  : out std_ulogic;
      omsp6_ir      : out std_ulogic_vector (15 downto 0);
      omsp6_irq_num : out std_ulogic_vector (5 downto 0);
      omsp6_pc      : out std_ulogic_vector (15 downto 0);

      --CPU internals
      omsp6_mclk    : out std_ulogic;
      omsp6_puc_rst : out std_ulogic;

      --CORE 7
      --CPU registers
      omsp7_r0  : out std_ulogic_vector (15 downto 0);
      omsp7_r1  : out std_ulogic_vector (15 downto 0);
      omsp7_r2  : out std_ulogic_vector (15 downto 0);
      omsp7_r3  : out std_ulogic_vector (15 downto 0);
      omsp7_r4  : out std_ulogic_vector (15 downto 0);
      omsp7_r5  : out std_ulogic_vector (15 downto 0);
      omsp7_r6  : out std_ulogic_vector (15 downto 0);
      omsp7_r7  : out std_ulogic_vector (15 downto 0);
      omsp7_r8  : out std_ulogic_vector (15 downto 0);
      omsp7_r9  : out std_ulogic_vector (15 downto 0);
      omsp7_r10 : out std_ulogic_vector (15 downto 0);
      omsp7_r11 : out std_ulogic_vector (15 downto 0);
      omsp7_r12 : out std_ulogic_vector (15 downto 0);
      omsp7_r13 : out std_ulogic_vector (15 downto 0);
      omsp7_r14 : out std_ulogic_vector (15 downto 0);
      omsp7_r15 : out std_ulogic_vector (15 downto 0);

      --Debug interface
      omsp7_dbg_en  : out std_ulogic;
      omsp7_dbg_clk : out std_ulogic;
      omsp7_dbg_rst : out std_ulogic;

      --Interrupt detection
      omsp7_irq_detect : out std_ulogic;
      omsp7_nmi_pnd    : out std_ulogic;

      omsp7_i_state : out std_ulogic_vector (2 downto 0);
      omsp7_e_state : out std_ulogic_vector (3 downto 0);
      omsp7_decode  : out std_ulogic;
      omsp7_ir      : out std_ulogic_vector (15 downto 0);
      omsp7_irq_num : out std_ulogic_vector (5 downto 0);
      omsp7_pc      : out std_ulogic_vector (15 downto 0);

      --CPU internals
      omsp7_mclk    : out std_ulogic;
      omsp7_puc_rst : out std_ulogic;

      dco_clk : out std_ulogic;

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
  end component;

  --////////////////////////////////////////////////////////////////
  --
  -- Variables
  --

  --CORE O
  --CPU registers
  signal omsp0_r0  : std_ulogic_vector (15 downto 0);
  signal omsp0_r1  : std_ulogic_vector (15 downto 0);
  signal omsp0_r2  : std_ulogic_vector (15 downto 0);
  signal omsp0_r3  : std_ulogic_vector (15 downto 0);
  signal omsp0_r4  : std_ulogic_vector (15 downto 0);
  signal omsp0_r5  : std_ulogic_vector (15 downto 0);
  signal omsp0_r6  : std_ulogic_vector (15 downto 0);
  signal omsp0_r7  : std_ulogic_vector (15 downto 0);
  signal omsp0_r8  : std_ulogic_vector (15 downto 0);
  signal omsp0_r9  : std_ulogic_vector (15 downto 0);
  signal omsp0_r10 : std_ulogic_vector (15 downto 0);
  signal omsp0_r11 : std_ulogic_vector (15 downto 0);
  signal omsp0_r12 : std_ulogic_vector (15 downto 0);
  signal omsp0_r13 : std_ulogic_vector (15 downto 0);
  signal omsp0_r14 : std_ulogic_vector (15 downto 0);
  signal omsp0_r15 : std_ulogic_vector (15 downto 0);

  --Debug interface
  signal omsp0_dbg_en  : std_ulogic;
  signal omsp0_dbg_clk : std_ulogic;
  signal omsp0_dbg_rst : std_ulogic;

  --Interrupt detection
  signal omsp0_irq_detect : std_ulogic;
  signal omsp0_nmi_pnd    : std_ulogic;

  signal omsp0_i_state : std_ulogic_vector (2 downto 0);
  signal omsp0_e_state : std_ulogic_vector (3 downto 0);
  signal omsp0_decode  : std_ulogic;
  signal omsp0_ir      : std_ulogic_vector (15 downto 0);
  signal omsp0_irq_num : std_ulogic_vector (5 downto 0);
  signal omsp0_pc      : std_ulogic_vector (15 downto 0);

  --CPU internals
  signal omsp0_mclk    : std_ulogic;
  signal omsp0_puc_rst : std_ulogic;

  --CORE 1
  --CPU registers
  signal omsp1_r0  : std_ulogic_vector (15 downto 0);
  signal omsp1_r1  : std_ulogic_vector (15 downto 0);
  signal omsp1_r2  : std_ulogic_vector (15 downto 0);
  signal omsp1_r3  : std_ulogic_vector (15 downto 0);
  signal omsp1_r4  : std_ulogic_vector (15 downto 0);
  signal omsp1_r5  : std_ulogic_vector (15 downto 0);
  signal omsp1_r6  : std_ulogic_vector (15 downto 0);
  signal omsp1_r7  : std_ulogic_vector (15 downto 0);
  signal omsp1_r8  : std_ulogic_vector (15 downto 0);
  signal omsp1_r9  : std_ulogic_vector (15 downto 0);
  signal omsp1_r10 : std_ulogic_vector (15 downto 0);
  signal omsp1_r11 : std_ulogic_vector (15 downto 0);
  signal omsp1_r12 : std_ulogic_vector (15 downto 0);
  signal omsp1_r13 : std_ulogic_vector (15 downto 0);
  signal omsp1_r14 : std_ulogic_vector (15 downto 0);
  signal omsp1_r15 : std_ulogic_vector (15 downto 0);

  --Debug interface
  signal omsp1_dbg_en  : std_ulogic;
  signal omsp1_dbg_clk : std_ulogic;
  signal omsp1_dbg_rst : std_ulogic;

  --Interrupt detection
  signal omsp1_irq_detect : std_ulogic;
  signal omsp1_nmi_pnd    : std_ulogic;

  signal omsp1_i_state : std_ulogic_vector (2 downto 0);
  signal omsp1_e_state : std_ulogic_vector (3 downto 0);
  signal omsp1_decode  : std_ulogic;
  signal omsp1_ir      : std_ulogic_vector (15 downto 0);
  signal omsp1_irq_num : std_ulogic_vector (5 downto 0);
  signal omsp1_pc      : std_ulogic_vector (15 downto 0);

  --CPU internals
  signal omsp1_mclk    : std_ulogic;
  signal omsp1_puc_rst : std_ulogic;

  --CORE 2
  --CPU registers
  signal omsp2_r0  : std_ulogic_vector (15 downto 0);
  signal omsp2_r1  : std_ulogic_vector (15 downto 0);
  signal omsp2_r2  : std_ulogic_vector (15 downto 0);
  signal omsp2_r3  : std_ulogic_vector (15 downto 0);
  signal omsp2_r4  : std_ulogic_vector (15 downto 0);
  signal omsp2_r5  : std_ulogic_vector (15 downto 0);
  signal omsp2_r6  : std_ulogic_vector (15 downto 0);
  signal omsp2_r7  : std_ulogic_vector (15 downto 0);
  signal omsp2_r8  : std_ulogic_vector (15 downto 0);
  signal omsp2_r9  : std_ulogic_vector (15 downto 0);
  signal omsp2_r10 : std_ulogic_vector (15 downto 0);
  signal omsp2_r11 : std_ulogic_vector (15 downto 0);
  signal omsp2_r12 : std_ulogic_vector (15 downto 0);
  signal omsp2_r13 : std_ulogic_vector (15 downto 0);
  signal omsp2_r14 : std_ulogic_vector (15 downto 0);
  signal omsp2_r15 : std_ulogic_vector (15 downto 0);

  --Debug interface
  signal omsp2_dbg_en  : std_ulogic;
  signal omsp2_dbg_clk : std_ulogic;
  signal omsp2_dbg_rst : std_ulogic;

  --Interrupt detection
  signal omsp2_irq_detect : std_ulogic;
  signal omsp2_nmi_pnd    : std_ulogic;

  signal omsp2_i_state : std_ulogic_vector (2 downto 0);
  signal omsp2_e_state : std_ulogic_vector (3 downto 0);
  signal omsp2_decode  : std_ulogic;
  signal omsp2_ir      : std_ulogic_vector (15 downto 0);
  signal omsp2_irq_num : std_ulogic_vector (5 downto 0);
  signal omsp2_pc      : std_ulogic_vector (15 downto 0);

  --CPU internals
  signal omsp2_mclk    : std_ulogic;
  signal omsp2_puc_rst : std_ulogic;

  --CORE 3
  --CPU registers
  signal omsp3_r0  : std_ulogic_vector (15 downto 0);
  signal omsp3_r1  : std_ulogic_vector (15 downto 0);
  signal omsp3_r2  : std_ulogic_vector (15 downto 0);
  signal omsp3_r3  : std_ulogic_vector (15 downto 0);
  signal omsp3_r4  : std_ulogic_vector (15 downto 0);
  signal omsp3_r5  : std_ulogic_vector (15 downto 0);
  signal omsp3_r6  : std_ulogic_vector (15 downto 0);
  signal omsp3_r7  : std_ulogic_vector (15 downto 0);
  signal omsp3_r8  : std_ulogic_vector (15 downto 0);
  signal omsp3_r9  : std_ulogic_vector (15 downto 0);
  signal omsp3_r10 : std_ulogic_vector (15 downto 0);
  signal omsp3_r11 : std_ulogic_vector (15 downto 0);
  signal omsp3_r12 : std_ulogic_vector (15 downto 0);
  signal omsp3_r13 : std_ulogic_vector (15 downto 0);
  signal omsp3_r14 : std_ulogic_vector (15 downto 0);
  signal omsp3_r15 : std_ulogic_vector (15 downto 0);

  --Debug interface
  signal omsp3_dbg_en  : std_ulogic;
  signal omsp3_dbg_clk : std_ulogic;
  signal omsp3_dbg_rst : std_ulogic;

  --Interrupt detection
  signal omsp3_irq_detect : std_ulogic;
  signal omsp3_nmi_pnd    : std_ulogic;

  signal omsp3_i_state : std_ulogic_vector (2 downto 0);
  signal omsp3_e_state : std_ulogic_vector (3 downto 0);
  signal omsp3_decode  : std_ulogic;
  signal omsp3_ir      : std_ulogic_vector (15 downto 0);
  signal omsp3_irq_num : std_ulogic_vector (5 downto 0);
  signal omsp3_pc      : std_ulogic_vector (15 downto 0);

  --CPU internals
  signal omsp3_mclk    : std_ulogic;
  signal omsp3_puc_rst : std_ulogic;

  --CORE 4
  --CPU registers
  signal omsp4_r0  : std_ulogic_vector (15 downto 0);
  signal omsp4_r1  : std_ulogic_vector (15 downto 0);
  signal omsp4_r2  : std_ulogic_vector (15 downto 0);
  signal omsp4_r3  : std_ulogic_vector (15 downto 0);
  signal omsp4_r4  : std_ulogic_vector (15 downto 0);
  signal omsp4_r5  : std_ulogic_vector (15 downto 0);
  signal omsp4_r6  : std_ulogic_vector (15 downto 0);
  signal omsp4_r7  : std_ulogic_vector (15 downto 0);
  signal omsp4_r8  : std_ulogic_vector (15 downto 0);
  signal omsp4_r9  : std_ulogic_vector (15 downto 0);
  signal omsp4_r10 : std_ulogic_vector (15 downto 0);
  signal omsp4_r11 : std_ulogic_vector (15 downto 0);
  signal omsp4_r12 : std_ulogic_vector (15 downto 0);
  signal omsp4_r13 : std_ulogic_vector (15 downto 0);
  signal omsp4_r14 : std_ulogic_vector (15 downto 0);
  signal omsp4_r15 : std_ulogic_vector (15 downto 0);

  --Debug interface
  signal omsp4_dbg_en  : std_ulogic;
  signal omsp4_dbg_clk : std_ulogic;
  signal omsp4_dbg_rst : std_ulogic;

  --Interrupt detection
  signal omsp4_irq_detect : std_ulogic;
  signal omsp4_nmi_pnd    : std_ulogic;

  signal omsp4_i_state : std_ulogic_vector (2 downto 0);
  signal omsp4_e_state : std_ulogic_vector (3 downto 0);
  signal omsp4_decode  : std_ulogic;
  signal omsp4_ir      : std_ulogic_vector (15 downto 0);
  signal omsp4_irq_num : std_ulogic_vector (5 downto 0);
  signal omsp4_pc      : std_ulogic_vector (15 downto 0);

  --CPU internals
  signal omsp4_mclk    : std_ulogic;
  signal omsp4_puc_rst : std_ulogic;

  --CORE 5
  --CPU registers
  signal omsp5_r0  : std_ulogic_vector (15 downto 0);
  signal omsp5_r1  : std_ulogic_vector (15 downto 0);
  signal omsp5_r2  : std_ulogic_vector (15 downto 0);
  signal omsp5_r3  : std_ulogic_vector (15 downto 0);
  signal omsp5_r4  : std_ulogic_vector (15 downto 0);
  signal omsp5_r5  : std_ulogic_vector (15 downto 0);
  signal omsp5_r6  : std_ulogic_vector (15 downto 0);
  signal omsp5_r7  : std_ulogic_vector (15 downto 0);
  signal omsp5_r8  : std_ulogic_vector (15 downto 0);
  signal omsp5_r9  : std_ulogic_vector (15 downto 0);
  signal omsp5_r10 : std_ulogic_vector (15 downto 0);
  signal omsp5_r11 : std_ulogic_vector (15 downto 0);
  signal omsp5_r12 : std_ulogic_vector (15 downto 0);
  signal omsp5_r13 : std_ulogic_vector (15 downto 0);
  signal omsp5_r14 : std_ulogic_vector (15 downto 0);
  signal omsp5_r15 : std_ulogic_vector (15 downto 0);

  --Debug interface
  signal omsp5_dbg_en  : std_ulogic;
  signal omsp5_dbg_clk : std_ulogic;
  signal omsp5_dbg_rst : std_ulogic;

  --Interrupt detection
  signal omsp5_irq_detect : std_ulogic;
  signal omsp5_nmi_pnd    : std_ulogic;

  signal omsp5_i_state : std_ulogic_vector (2 downto 0);
  signal omsp5_e_state : std_ulogic_vector (3 downto 0);
  signal omsp5_decode  : std_ulogic;
  signal omsp5_ir      : std_ulogic_vector (15 downto 0);
  signal omsp5_irq_num : std_ulogic_vector (5 downto 0);
  signal omsp5_pc      : std_ulogic_vector (15 downto 0);

  --CPU internals
  signal omsp5_mclk    : std_ulogic;
  signal omsp5_puc_rst : std_ulogic;

  --CORE 6
  --CPU registers
  signal omsp6_r0  : std_ulogic_vector (15 downto 0);
  signal omsp6_r1  : std_ulogic_vector (15 downto 0);
  signal omsp6_r2  : std_ulogic_vector (15 downto 0);
  signal omsp6_r3  : std_ulogic_vector (15 downto 0);
  signal omsp6_r4  : std_ulogic_vector (15 downto 0);
  signal omsp6_r5  : std_ulogic_vector (15 downto 0);
  signal omsp6_r6  : std_ulogic_vector (15 downto 0);
  signal omsp6_r7  : std_ulogic_vector (15 downto 0);
  signal omsp6_r8  : std_ulogic_vector (15 downto 0);
  signal omsp6_r9  : std_ulogic_vector (15 downto 0);
  signal omsp6_r10 : std_ulogic_vector (15 downto 0);
  signal omsp6_r11 : std_ulogic_vector (15 downto 0);
  signal omsp6_r12 : std_ulogic_vector (15 downto 0);
  signal omsp6_r13 : std_ulogic_vector (15 downto 0);
  signal omsp6_r14 : std_ulogic_vector (15 downto 0);
  signal omsp6_r15 : std_ulogic_vector (15 downto 0);

  --Debug interface
  signal omsp6_dbg_en  : std_ulogic;
  signal omsp6_dbg_clk : std_ulogic;
  signal omsp6_dbg_rst : std_ulogic;

  --Interrupt detection
  signal omsp6_irq_detect : std_ulogic;
  signal omsp6_nmi_pnd    : std_ulogic;

  signal omsp6_i_state : std_ulogic_vector (2 downto 0);
  signal omsp6_e_state : std_ulogic_vector (3 downto 0);
  signal omsp6_decode  : std_ulogic;
  signal omsp6_ir      : std_ulogic_vector (15 downto 0);
  signal omsp6_irq_num : std_ulogic_vector (5 downto 0);
  signal omsp6_pc      : std_ulogic_vector (15 downto 0);

  --CPU internals
  signal omsp6_mclk    : std_ulogic;
  signal omsp6_puc_rst : std_ulogic;

  --CORE 7
  --CPU registers
  signal omsp7_r0  : std_ulogic_vector (15 downto 0);
  signal omsp7_r1  : std_ulogic_vector (15 downto 0);
  signal omsp7_r2  : std_ulogic_vector (15 downto 0);
  signal omsp7_r3  : std_ulogic_vector (15 downto 0);
  signal omsp7_r4  : std_ulogic_vector (15 downto 0);
  signal omsp7_r5  : std_ulogic_vector (15 downto 0);
  signal omsp7_r6  : std_ulogic_vector (15 downto 0);
  signal omsp7_r7  : std_ulogic_vector (15 downto 0);
  signal omsp7_r8  : std_ulogic_vector (15 downto 0);
  signal omsp7_r9  : std_ulogic_vector (15 downto 0);
  signal omsp7_r10 : std_ulogic_vector (15 downto 0);
  signal omsp7_r11 : std_ulogic_vector (15 downto 0);
  signal omsp7_r12 : std_ulogic_vector (15 downto 0);
  signal omsp7_r13 : std_ulogic_vector (15 downto 0);
  signal omsp7_r14 : std_ulogic_vector (15 downto 0);
  signal omsp7_r15 : std_ulogic_vector (15 downto 0);

  --Debug interface
  signal omsp7_dbg_en  : std_ulogic;
  signal omsp7_dbg_clk : std_ulogic;
  signal omsp7_dbg_rst : std_ulogic;

  --Interrupt detection
  signal omsp7_irq_detect : std_ulogic;
  signal omsp7_nmi_pnd    : std_ulogic;

  signal omsp7_i_state : std_ulogic_vector (2 downto 0);
  signal omsp7_e_state : std_ulogic_vector (3 downto 0);
  signal omsp7_decode  : std_ulogic;
  signal omsp7_ir      : std_ulogic_vector (15 downto 0);
  signal omsp7_irq_num : std_ulogic_vector (5 downto 0);
  signal omsp7_pc      : std_ulogic_vector (15 downto 0);

  --CPU internals
  signal omsp7_mclk    : std_ulogic;
  signal omsp7_puc_rst : std_ulogic;

  signal dco_clk : std_ulogic;

  --User Reset Push Button
  signal USER_RESET : std_ulogic;

  --Triple-Output PLL Clock Chip
  signal USER_CLOCK : std_ulogic;

  --User DIP Switch x4
  signal GPIO_DIP1 : std_ulogic;
  signal GPIO_DIP2 : std_ulogic;
  signal GPIO_DIP3 : std_ulogic;
  signal GPIO_DIP4 : std_ulogic;

  --User LEDs
  signal GPIO_LED1 : std_ulogic;
  signal GPIO_LED2 : std_ulogic;
  signal GPIO_LED3 : std_ulogic;
  signal GPIO_LED4 : std_ulogic;

  --Silicon Labs CP2102 USB-to-UART Bridge Chip
  signal USB_RS232_RXD : std_ulogic;
  signal USB_RS232_TXD : std_ulogic;

  --Peripheral Modules (PMODs) and GPIO
  signal PMOD1_P3 : std_ulogic;
  signal PMOD1_P4 : std_ulogic;

begin
  --////////////////////////////////////////////////////////////////
  --
  -- Module Body
  --

  --DUT
  DUT : MSP430_MODEL
    port map (
      --CORE 0
      --CPU registers
      omsp0_r0  => omsp0_r0,
      omsp0_r1  => omsp0_r1,
      omsp0_r2  => omsp0_r2,
      omsp0_r3  => omsp0_r3,
      omsp0_r4  => omsp0_r4,
      omsp0_r5  => omsp0_r5,
      omsp0_r6  => omsp0_r6,
      omsp0_r7  => omsp0_r7,
      omsp0_r8  => omsp0_r8,
      omsp0_r9  => omsp0_r9,
      omsp0_r10 => omsp0_r10,
      omsp0_r11 => omsp0_r11,
      omsp0_r12 => omsp0_r12,
      omsp0_r13 => omsp0_r13,
      omsp0_r14 => omsp0_r14,
      omsp0_r15 => omsp0_r15,

      --Debug interface
      omsp0_dbg_en  => omsp0_dbg_en,
      omsp0_dbg_clk => omsp0_dbg_clk,
      omsp0_dbg_rst => omsp0_dbg_rst,

      --Interrupt detection
      omsp0_irq_detect => omsp0_irq_detect,
      omsp0_nmi_pnd    => omsp0_nmi_pnd,

      omsp0_i_state => omsp0_i_state,
      omsp0_e_state => omsp0_e_state,
      omsp0_decode  => omsp0_decode,
      omsp0_ir      => omsp0_ir,
      omsp0_irq_num => omsp0_irq_num,
      omsp0_pc      => omsp0_pc,

      --CPU internals
      omsp0_mclk    => omsp0_mclk,
      omsp0_puc_rst => omsp0_puc_rst,

      --CORE 1
      --CPU registers
      omsp1_r0  => omsp1_r0,
      omsp1_r1  => omsp1_r1,
      omsp1_r2  => omsp1_r2,
      omsp1_r3  => omsp1_r3,
      omsp1_r4  => omsp1_r4,
      omsp1_r5  => omsp1_r5,
      omsp1_r6  => omsp1_r6,
      omsp1_r7  => omsp1_r7,
      omsp1_r8  => omsp1_r8,
      omsp1_r9  => omsp1_r9,
      omsp1_r10 => omsp1_r10,
      omsp1_r11 => omsp1_r11,
      omsp1_r12 => omsp1_r12,
      omsp1_r13 => omsp1_r13,
      omsp1_r14 => omsp1_r14,
      omsp1_r15 => omsp1_r15,

      --Debug interface
      omsp1_dbg_en  => omsp1_dbg_en,
      omsp1_dbg_clk => omsp1_dbg_clk,
      omsp1_dbg_rst => omsp1_dbg_rst,

      --Interrupt detection
      omsp1_irq_detect => omsp1_irq_detect,
      omsp1_nmi_pnd    => omsp1_nmi_pnd,

      omsp1_i_state => omsp1_i_state,
      omsp1_e_state => omsp1_e_state,
      omsp1_decode  => omsp1_decode,
      omsp1_ir      => omsp1_ir,
      omsp1_irq_num => omsp1_irq_num,
      omsp1_pc      => omsp1_pc,

      --CPU internals
      omsp1_mclk    => omsp1_mclk,
      omsp1_puc_rst => omsp1_puc_rst,

      --CORE 2
      --CPU registers
      omsp2_r0  => omsp2_r0,
      omsp2_r1  => omsp2_r1,
      omsp2_r2  => omsp2_r2,
      omsp2_r3  => omsp2_r3,
      omsp2_r4  => omsp2_r4,
      omsp2_r5  => omsp2_r5,
      omsp2_r6  => omsp2_r6,
      omsp2_r7  => omsp2_r7,
      omsp2_r8  => omsp2_r8,
      omsp2_r9  => omsp2_r9,
      omsp2_r10 => omsp2_r10,
      omsp2_r11 => omsp2_r11,
      omsp2_r12 => omsp2_r12,
      omsp2_r13 => omsp2_r13,
      omsp2_r14 => omsp2_r14,
      omsp2_r15 => omsp2_r15,

      --Debug interface
      omsp2_dbg_en  => omsp2_dbg_en,
      omsp2_dbg_clk => omsp2_dbg_clk,
      omsp2_dbg_rst => omsp2_dbg_rst,

      --Interrupt detection
      omsp2_irq_detect => omsp2_irq_detect,
      omsp2_nmi_pnd    => omsp2_nmi_pnd,

      omsp2_i_state => omsp2_i_state,
      omsp2_e_state => omsp2_e_state,
      omsp2_decode  => omsp2_decode,
      omsp2_ir      => omsp2_ir,
      omsp2_irq_num => omsp2_irq_num,
      omsp2_pc      => omsp2_pc,

      --CPU internals
      omsp2_mclk    => omsp2_mclk,
      omsp2_puc_rst => omsp2_puc_rst,

      --CORE 3
      --CPU registers
      omsp3_r0  => omsp3_r0,
      omsp3_r1  => omsp3_r1,
      omsp3_r2  => omsp3_r2,
      omsp3_r3  => omsp3_r3,
      omsp3_r4  => omsp3_r4,
      omsp3_r5  => omsp3_r5,
      omsp3_r6  => omsp3_r6,
      omsp3_r7  => omsp3_r7,
      omsp3_r8  => omsp3_r8,
      omsp3_r9  => omsp3_r9,
      omsp3_r10 => omsp3_r10,
      omsp3_r11 => omsp3_r11,
      omsp3_r12 => omsp3_r12,
      omsp3_r13 => omsp3_r13,
      omsp3_r14 => omsp3_r14,
      omsp3_r15 => omsp3_r15,

      --Debug interface
      omsp3_dbg_en  => omsp3_dbg_en,
      omsp3_dbg_clk => omsp3_dbg_clk,
      omsp3_dbg_rst => omsp3_dbg_rst,

      --Interrupt detection
      omsp3_irq_detect => omsp3_irq_detect,
      omsp3_nmi_pnd    => omsp3_nmi_pnd,

      omsp3_i_state => omsp3_i_state,
      omsp3_e_state => omsp3_e_state,
      omsp3_decode  => omsp3_decode,
      omsp3_ir      => omsp3_ir,
      omsp3_irq_num => omsp3_irq_num,
      omsp3_pc      => omsp3_pc,

      --CPU internals
      omsp3_mclk    => omsp3_mclk,
      omsp3_puc_rst => omsp3_puc_rst,

      --CORE 4
      --CPU registers
      omsp4_r0  => omsp4_r0,
      omsp4_r1  => omsp4_r1,
      omsp4_r2  => omsp4_r2,
      omsp4_r3  => omsp4_r3,
      omsp4_r4  => omsp4_r4,
      omsp4_r5  => omsp4_r5,
      omsp4_r6  => omsp4_r6,
      omsp4_r7  => omsp4_r7,
      omsp4_r8  => omsp4_r8,
      omsp4_r9  => omsp4_r9,
      omsp4_r10 => omsp4_r10,
      omsp4_r11 => omsp4_r11,
      omsp4_r12 => omsp4_r12,
      omsp4_r13 => omsp4_r13,
      omsp4_r14 => omsp4_r14,
      omsp4_r15 => omsp4_r15,

      --Debug interface
      omsp4_dbg_en  => omsp4_dbg_en,
      omsp4_dbg_clk => omsp4_dbg_clk,
      omsp4_dbg_rst => omsp4_dbg_rst,

      --Interrupt detection
      omsp4_irq_detect => omsp4_irq_detect,
      omsp4_nmi_pnd    => omsp4_nmi_pnd,

      omsp4_i_state => omsp4_i_state,
      omsp4_e_state => omsp4_e_state,
      omsp4_decode  => omsp4_decode,
      omsp4_ir      => omsp4_ir,
      omsp4_irq_num => omsp4_irq_num,
      omsp4_pc      => omsp4_pc,

      --CPU internals
      omsp4_mclk    => omsp4_mclk,
      omsp4_puc_rst => omsp4_puc_rst,

      --CORE 5
      --CPU registers
      omsp5_r0  => omsp5_r0,
      omsp5_r1  => omsp5_r1,
      omsp5_r2  => omsp5_r2,
      omsp5_r3  => omsp5_r3,
      omsp5_r4  => omsp5_r4,
      omsp5_r5  => omsp5_r5,
      omsp5_r6  => omsp5_r6,
      omsp5_r7  => omsp5_r7,
      omsp5_r8  => omsp5_r8,
      omsp5_r9  => omsp5_r9,
      omsp5_r10 => omsp5_r10,
      omsp5_r11 => omsp5_r11,
      omsp5_r12 => omsp5_r12,
      omsp5_r13 => omsp5_r13,
      omsp5_r14 => omsp5_r14,
      omsp5_r15 => omsp5_r15,

      --Debug interface
      omsp5_dbg_en  => omsp5_dbg_en,
      omsp5_dbg_clk => omsp5_dbg_clk,
      omsp5_dbg_rst => omsp5_dbg_rst,

      --Interrupt detection
      omsp5_irq_detect => omsp5_irq_detect,
      omsp5_nmi_pnd    => omsp5_nmi_pnd,

      omsp5_i_state => omsp5_i_state,
      omsp5_e_state => omsp5_e_state,
      omsp5_decode  => omsp5_decode,
      omsp5_ir      => omsp5_ir,
      omsp5_irq_num => omsp5_irq_num,
      omsp5_pc      => omsp5_pc,

      --CPU internals
      omsp5_mclk    => omsp5_mclk,
      omsp5_puc_rst => omsp5_puc_rst,

      --CORE 6
      --CPU registers
      omsp6_r0  => omsp6_r0,
      omsp6_r1  => omsp6_r1,
      omsp6_r2  => omsp6_r2,
      omsp6_r3  => omsp6_r3,
      omsp6_r4  => omsp6_r4,
      omsp6_r5  => omsp6_r5,
      omsp6_r6  => omsp6_r6,
      omsp6_r7  => omsp6_r7,
      omsp6_r8  => omsp6_r8,
      omsp6_r9  => omsp6_r9,
      omsp6_r10 => omsp6_r10,
      omsp6_r11 => omsp6_r11,
      omsp6_r12 => omsp6_r12,
      omsp6_r13 => omsp6_r13,
      omsp6_r14 => omsp6_r14,
      omsp6_r15 => omsp6_r15,

      --Debug interface
      omsp6_dbg_en  => omsp6_dbg_en,
      omsp6_dbg_clk => omsp6_dbg_clk,
      omsp6_dbg_rst => omsp6_dbg_rst,

      --Interrupt detection
      omsp6_irq_detect => omsp6_irq_detect,
      omsp6_nmi_pnd    => omsp6_nmi_pnd,

      omsp6_i_state => omsp6_i_state,
      omsp6_e_state => omsp6_e_state,
      omsp6_decode  => omsp6_decode,
      omsp6_ir      => omsp6_ir,
      omsp6_irq_num => omsp6_irq_num,
      omsp6_pc      => omsp6_pc,

      --CPU internals
      omsp6_mclk    => omsp6_mclk,
      omsp6_puc_rst => omsp6_puc_rst,

      --CORE 7
      --CPU registers
      omsp7_r0  => omsp7_r0,
      omsp7_r1  => omsp7_r1,
      omsp7_r2  => omsp7_r2,
      omsp7_r3  => omsp7_r3,
      omsp7_r4  => omsp7_r4,
      omsp7_r5  => omsp7_r5,
      omsp7_r6  => omsp7_r6,
      omsp7_r7  => omsp7_r7,
      omsp7_r8  => omsp7_r8,
      omsp7_r9  => omsp7_r9,
      omsp7_r10 => omsp7_r10,
      omsp7_r11 => omsp7_r11,
      omsp7_r12 => omsp7_r12,
      omsp7_r13 => omsp7_r13,
      omsp7_r14 => omsp7_r14,
      omsp7_r15 => omsp7_r15,

      --Debug interface
      omsp7_dbg_en  => omsp7_dbg_en,
      omsp7_dbg_clk => omsp7_dbg_clk,
      omsp7_dbg_rst => omsp7_dbg_rst,

      --Interrupt detection
      omsp7_irq_detect => omsp7_irq_detect,
      omsp7_nmi_pnd    => omsp7_nmi_pnd,

      omsp7_i_state => omsp7_i_state,
      omsp7_e_state => omsp7_e_state,
      omsp7_decode  => omsp7_decode,
      omsp7_ir      => omsp7_ir,
      omsp7_irq_num => omsp7_irq_num,
      omsp7_pc      => omsp7_pc,

      --CPU internals
      omsp7_mclk    => omsp7_mclk,
      omsp7_puc_rst => omsp7_puc_rst,

      dco_clk => dco_clk,

      --User Reset Push Button
      USER_RESET => USER_RESET,

      --Triple-Output PLL Clock Chip
      USER_CLOCK => USER_CLOCK,

      --User DIP Switch x4
      GPIO_DIP1 => GPIO_DIP1,
      GPIO_DIP2 => GPIO_DIP2,
      GPIO_DIP3 => GPIO_DIP3,
      GPIO_DIP4 => GPIO_DIP4,

      --User LEDs                 
      GPIO_LED1 => GPIO_LED1,
      GPIO_LED2 => GPIO_LED2,
      GPIO_LED3 => GPIO_LED3,
      GPIO_LED4 => GPIO_LED4,

      --Silicon Labs CP2102 USB-to-UART Bridge Chip
      USB_RS232_RXD => USB_RS232_RXD,
      USB_RS232_TXD => USB_RS232_TXD,

      --Peripheral Modules (PMODs) and GPIO
      PMOD1_P3 => PMOD1_P3,
      PMOD1_P4 => PMOD1_P4);
end RTL;

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

entity MSP430_PU is
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
end MSP430_PU;

architecture MSP430_PU_ARQ of MSP430_PU is

  --Clock & Reset
  signal mclk_omsp    : std_ulogic;
  signal aclk_en      : std_ulogic;
  signal smclk_en     : std_ulogic;
  signal puc_rst_omsp : std_ulogic;

  --Debug interface
  signal dbg_en_omsp : std_ulogic;
  signal dbg_freeze  : std_ulogic;

  --Data memory
  signal dmem_addr_omsp : std_ulogic_vector (DMEM_MSB downto 0);
  signal dmem_cen_omsp  : std_ulogic;
  signal dmem_din_omsp  : std_ulogic_vector (15 downto 0);
  signal dmem_wen_omsp  : std_ulogic_vector (1 downto 0);

  --Program memory
  signal pmem_addr_omsp : std_ulogic_vector (PMEM_MSB downto 0);
  signal pmem_cen_omsp  : std_ulogic;
  signal pmem_din_omsp  : std_ulogic_vector (15 downto 0);
  signal pmem_wen_omsp  : std_ulogic_vector (1 downto 0);

  --Peripheral bus
  signal per_addr : std_ulogic_vector (13 downto 0);
  signal per_din  : std_ulogic_vector (15 downto 0);
  signal per_we   : std_ulogic_vector (1 downto 0);
  signal per_en   : std_ulogic;
  signal per_dout : std_ulogic_vector (15 downto 0);

  --Interrupts
  signal irq_acc : std_ulogic_vector (13 downto 0);
  signal irq_bus : std_ulogic_vector (13 downto 0);
  signal nmi     : std_ulogic;

  --GPIO
  signal irq_port1     : std_ulogic;
  signal irq_port2     : std_ulogic;
  signal p1_din        : std_ulogic_vector (7 downto 0);
  signal p1_dout       : std_ulogic_vector (7 downto 0);
  signal p1_dout_en    : std_ulogic_vector (7 downto 0);
  signal p1_sel        : std_ulogic_vector (7 downto 0);
  signal p2_din        : std_ulogic_vector (7 downto 0);
  signal p2_dout       : std_ulogic_vector (7 downto 0);
  signal p2_dout_en    : std_ulogic_vector (7 downto 0);
  signal p2_sel        : std_ulogic_vector (7 downto 0);
  signal per_dout_gpio : std_ulogic_vector (15 downto 0);

  --Hardware UART
  signal irq_uart_rx   : std_ulogic;
  signal irq_uart_tx   : std_ulogic;
  signal per_dout_uart : std_ulogic_vector (15 downto 0);

  component MSP430_CORE
    port (
      --FRONTEND - SCAN
      scan_enable : in std_ulogic;
      scan_mode   : in std_ulogic;

      --FRONTEND - INTERRUPTION
      irq_acc : out std_ulogic_vector (IRQ_NR - 3 downto 0);
      nmi     : in  std_ulogic;
      irq     : in  std_ulogic_vector (IRQ_NR - 3 downto 0);

      --FRONTEND - RESET
      puc_rst : out std_ulogic;
      reset_n : in  std_ulogic;

      --DATA MEMORY
      dmem_cen  : out std_ulogic;
      dmem_wen  : out std_ulogic_vector (1 downto 0);
      dmem_din  : out std_ulogic_vector (15 downto 0);
      dmem_addr : out std_ulogic_vector (DMEM_MSB downto 0);
      dmem_dout : in  std_ulogic_vector (15 downto 0);

      --INSTRUCTION MEMORY
      pmem_cen  : out std_ulogic;
      pmem_wen  : out std_ulogic_vector (1 downto 0);
      pmem_din  : out std_ulogic_vector (15 downto 0);
      pmem_addr : out std_ulogic_vector (PMEM_MSB downto 0);
      pmem_dout : in  std_ulogic_vector (15 downto 0);

      --PERIPHERAL MEMORY
      per_en   : out std_ulogic;
      per_we   : out std_ulogic_vector (1 downto 0);
      per_addr : out std_ulogic_vector (13 downto 0);
      per_din  : out std_ulogic_vector (15 downto 0);
      per_dout : in  std_ulogic_vector (15 downto 0);

      --EXECUTION - REGISTERS
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

      dbg_clk    : out std_ulogic;
      dbg_rst    : out std_ulogic;
      irq_detect : out std_ulogic;
      nmi_detect : out std_ulogic;

      i_state : out std_ulogic_vector (2 downto 0);
      e_state : out std_ulogic_vector (3 downto 0);
      decode  : out std_ulogic;
      ir      : out std_ulogic_vector (15 downto 0);
      irq_num : out std_ulogic_vector (5 downto 0);
      pc      : out std_ulogic_vector (15 downto 0);

      nodiv_smclk : out std_ulogic;

      --DBG
      dbg_freeze : out std_ulogic;
      dbg_en     : in  std_ulogic;

      --DBG - I2C
      dbg_i2c_sda_out   : out std_ulogic;
      dbg_i2c_scl       : in  std_ulogic;
      dbg_i2c_sda_in    : in  std_ulogic;
      dbg_i2c_addr      : in  std_ulogic_vector (6 downto 0);
      dbg_i2c_broadcast : in  std_ulogic_vector (6 downto 0);

      --DBG - UART
      dbg_uart_txd : out std_ulogic;
      dbg_uart_rxd : in  std_ulogic;

      --BCM
      aclk        : out std_ulogic;
      aclk_en     : out std_ulogic;
      dco_enable  : out std_ulogic;
      dco_wkup    : out std_ulogic;
      lfxt_enable : out std_ulogic;
      lfxt_wkup   : out std_ulogic;
      mclk        : out std_ulogic;
      smclk       : out std_ulogic;
      smclk_en    : out std_ulogic;
      cpu_en      : in  std_ulogic;
      dco_clk     : in  std_ulogic;
      lfxt_clk    : in  std_ulogic;
      wkup        : in  std_ulogic);
  end component MSP430_CORE;

  component GPIO
    port (
      p1_dout : out std_ulogic_vector (7 downto 0);
      p2_dout : out std_ulogic_vector (7 downto 0);
      p3_dout : out std_ulogic_vector (7 downto 0);
      p4_dout : out std_ulogic_vector (7 downto 0);
      p5_dout : out std_ulogic_vector (7 downto 0);
      p6_dout : out std_ulogic_vector (7 downto 0);

      p1_dout_en : out std_ulogic_vector (7 downto 0);
      p2_dout_en : out std_ulogic_vector (7 downto 0);
      p3_dout_en : out std_ulogic_vector (7 downto 0);
      p4_dout_en : out std_ulogic_vector (7 downto 0);
      p5_dout_en : out std_ulogic_vector (7 downto 0);
      p6_dout_en : out std_ulogic_vector (7 downto 0);

      p1_sel : out std_ulogic_vector (7 downto 0);
      p2_sel : out std_ulogic_vector (7 downto 0);
      p3_sel : out std_ulogic_vector (7 downto 0);
      p4_sel : out std_ulogic_vector (7 downto 0);
      p5_sel : out std_ulogic_vector (7 downto 0);
      p6_sel : out std_ulogic_vector (7 downto 0);

      p1dir : out std_ulogic_vector (7 downto 0);
      p1ifg : out std_ulogic_vector (7 downto 0);

      p1_din : in std_ulogic_vector (7 downto 0);
      p2_din : in std_ulogic_vector (7 downto 0);
      p3_din : in std_ulogic_vector (7 downto 0);
      p4_din : in std_ulogic_vector (7 downto 0);
      p5_din : in std_ulogic_vector (7 downto 0);
      p6_din : in std_ulogic_vector (7 downto 0);

      irq_port1 : out std_ulogic;
      irq_port2 : out std_ulogic;

      per_dout : out std_ulogic_vector (15 downto 0);
      mclk     : in  std_ulogic;
      per_en   : in  std_ulogic;
      puc_rst  : in  std_ulogic;
      per_we   : in  std_ulogic_vector (1 downto 0);
      per_addr : in  std_ulogic_vector (13 downto 0);
      per_din  : in  std_ulogic_vector (15 downto 0));
  end component GPIO;

  component UART
    port (
      uart_txd : out std_ulogic;
      uart_rxd : in  std_ulogic;
      smclk_en : in  std_ulogic;

      irq_uart_rx : out std_ulogic;
      irq_uart_tx : out std_ulogic;

      per_dout : out std_ulogic_vector (15 downto 0);
      mclk     : in  std_ulogic;
      per_en   : in  std_ulogic;
      puc_rst  : in  std_ulogic;
      per_we   : in  std_ulogic_vector (1 downto 0);
      per_addr : in  std_ulogic_vector (13 downto 0);
      per_din  : in  std_ulogic_vector (15 downto 0));
  end component UART;

begin

  --Clock & Reset
  mclk    <= mclk_omsp;
  puc_rst <= puc_rst_omsp;

  --Data memory
  dmem_addr <= dmem_addr_omsp;
  dmem_cen  <= dmem_cen_omsp;
  dmem_din  <= dmem_din_omsp;
  dmem_wen  <= dmem_wen_omsp;

  --Program memory
  pmem_addr <= pmem_addr_omsp;
  pmem_cen  <= pmem_cen_omsp;
  pmem_din  <= pmem_din_omsp;
  pmem_wen  <= pmem_wen_omsp;

  CORE : block
  begin
    MSP430_CORE_I : MSP430_CORE
      port map (
        --FRONTEND - SCAN
        scan_enable => '0',
        scan_mode   => '0',

        --FRONTEND - INTERRUPTION
        irq_acc => irq_acc,
        nmi     => nmi,
        irq     => irq_bus,

        --FRONTEND - RESET
        puc_rst => puc_rst_omsp,
        reset_n => reset_n,

        --DATA MEMORY
        dmem_cen  => dmem_cen_omsp,
        dmem_wen  => dmem_wen_omsp,
        dmem_din  => dmem_din_omsp,
        dmem_addr => dmem_addr_omsp,
        dmem_dout => dmem_dout,

        --INSTRUCTION MEMORY            
        pmem_cen  => pmem_cen_omsp,
        pmem_wen  => pmem_wen_omsp,
        pmem_din  => pmem_din_omsp,
        pmem_addr => pmem_addr_omsp,
        pmem_dout => pmem_dout,

        --PERIPHERAL MEMORY     
        per_en   => per_en,
        per_we   => per_we,
        per_addr => per_addr,
        per_din  => per_din,
        per_dout => per_dout,

        --EXECUTION - REGISTERS
        r0  => r0,
        r1  => r1,
        r2  => r2,
        r3  => r3,
        r4  => r4,
        r5  => r5,
        r6  => r6,
        r7  => r7,
        r8  => r8,
        r9  => r9,
        r10 => r10,
        r11 => r11,
        r12 => r12,
        r13 => r13,
        r14 => r14,
        r15 => r15,

        dbg_clk    => dbg_clk,
        dbg_rst    => dbg_rst,
        irq_detect => irq_detect,
        nmi_detect => nmi_pnd,

        i_state => i_state,
        e_state => e_state,
        decode  => decode,
        ir      => ir,
        irq_num => irq_num,
        pc      => pc,

        nodiv_smclk => open,

        --DBG
        dbg_freeze => dbg_freeze,
        dbg_en     => dbg_en_omsp,

        --DBG - I2C
        dbg_i2c_sda_out   => dbg_i2c_sda_out,
        dbg_i2c_scl       => dbg_i2c_scl,
        dbg_i2c_sda_in    => dbg_i2c_sda_in,
        dbg_i2c_addr      => dbg_i2c_addr,
        dbg_i2c_broadcast => dbg_i2c_broadcast,

        --DBG - UART
        dbg_uart_txd => open,
        dbg_uart_rxd => '1',

        --BCM
        aclk        => open,
        aclk_en     => aclk_en,
        dco_enable  => open,
        dco_wkup    => open,
        lfxt_enable => open,
        lfxt_wkup   => open,
        mclk        => mclk_omsp,
        smclk       => open,
        smclk_en    => smclk_en,
        cpu_en      => '1',
        dco_clk     => dco_clk,
        lfxt_clk    => '0',
        wkup        => '0');

    dbg_en_omsp <= '1';
    dbg_en      <= dbg_en_omsp;
  end block CORE;

  EXTERNAL_PERIPHERAL : block
  begin
    GPIO_I : GPIO
      port map (
        p1_dout => p1_dout,
        p2_dout => p2_dout,
        p3_dout => open,
        p4_dout => open,
        p5_dout => open,
        p6_dout => open,

        p1_dout_en => p1_dout_en,
        p2_dout_en => p2_dout_en,
        p3_dout_en => open,
        p4_dout_en => open,
        p5_dout_en => open,
        p6_dout_en => open,

        p1_sel => p1_sel,
        p2_sel => p2_sel,
        p3_sel => open,
        p4_sel => open,
        p5_sel => open,
        p6_sel => open,

        p1dir => open,
        p1ifg => open,

        p1_din => p1_din,
        p2_din => p2_din,
        p3_din => X"00",
        p4_din => X"00",
        p5_din => X"00",
        p6_din => X"00",

        irq_port1 => irq_port1,
        irq_port2 => irq_port2,

        per_dout => per_dout_gpio,
        mclk     => mclk_omsp,
        per_en   => per_en,
        puc_rst  => puc_rst_omsp,
        per_we   => per_we,
        per_din  => per_din,
        per_addr => per_addr);

    --Assign GPIO OUTs
    gpio_out <= p2_dout(1 downto 0) and p2_dout_en(1 downto 0);

    --Assign GPIO INs
    p1_din <= X"0" & gpio_in;

    UART_I : UART
      port map (
        uart_txd => uart_txd,
        uart_rxd => uart_rxd,
        smclk_en => smclk_en,

        irq_uart_rx => irq_uart_rx,
        irq_uart_tx => irq_uart_tx,

        per_dout => per_dout_uart,
        mclk     => mclk_omsp,
        per_en   => per_en,
        puc_rst  => puc_rst_omsp,
        per_we   => per_we,
        per_din  => per_din,
        per_addr => per_addr);

    --Combine peripheral data buses
    per_dout <= per_dout_gpio or
                per_dout_uart;
  end block EXTERNAL_PERIPHERAL;

  INTERRUPTION_BLOCK : block
  begin
    nmi <= '0';
    irq_bus <= ('0',
                '0',
                '0',
                '0',
                '0',
                '0',
                irq_uart_rx,
                irq_uart_tx,
                '0',
                '0',
                irq_port2,
                irq_port1,
                '0',
                '0');
  end block INTERRUPTION_BLOCK;
end MSP430_PU_ARQ;

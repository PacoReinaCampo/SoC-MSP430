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
--   Paco Reina Campo <pacoreinacampo@queenfield.tech>
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.msp430_pkg.all;

entity msp430_core1 is
  port (
    -- CPU registers
    r0  : out std_logic_vector(15 downto 0);
    r1  : out std_logic_vector(15 downto 0);
    r2  : out std_logic_vector(15 downto 0);
    r3  : out std_logic_vector(15 downto 0);
    r4  : out std_logic_vector(15 downto 0);
    r5  : out std_logic_vector(15 downto 0);
    r6  : out std_logic_vector(15 downto 0);
    r7  : out std_logic_vector(15 downto 0);
    r8  : out std_logic_vector(15 downto 0);
    r9  : out std_logic_vector(15 downto 0);
    r10 : out std_logic_vector(15 downto 0);
    r11 : out std_logic_vector(15 downto 0);
    r12 : out std_logic_vector(15 downto 0);
    r13 : out std_logic_vector(15 downto 0);
    r14 : out std_logic_vector(15 downto 0);
    r15 : out std_logic_vector(15 downto 0);

    -- Debug interface
    dbg_en  : out std_logic;
    dbg_clk : out std_logic;
    dbg_rst : out std_logic;

    -- Interrupt detection
    irq_detect : out std_logic;
    nmi_pnd    : out std_logic;

    i_state : out std_logic_vector(2 downto 0);
    e_state : out std_logic_vector(3 downto 0);
    decode  : out std_logic;
    ir      : out std_logic_vector(15 downto 0);
    irq_num : out std_logic_vector(5 downto 0);
    pc      : out std_logic_vector(15 downto 0);

    -- CPU internals
    mclk    : out std_logic;
    puc_rst : out std_logic;

    -- Clock & Reset
    dco_clk : in std_logic;  -- Fast oscillator (fast clock)
    reset_n : in std_logic;  -- Reset Pin (low active, asynchronous and non-glitchy)

    -- Serial Debug Interface (I2C)
    dbg_i2c_addr      : in  std_logic_vector(6 downto 0);  -- Debug interface: I2C Address
    dbg_i2c_broadcast : in  std_logic_vector(6 downto 0);  -- Debug interface: I2C Broadcast Address (for multicore systems)
    dbg_i2c_scl       : in  std_logic;  -- Debug interface: I2C SCL
    dbg_i2c_sda_in    : in  std_logic;  -- Debug interface: I2C SDA IN
    dbg_i2c_sda_out   : out std_logic;  -- Debug interface: I2C SDA OUT

    -- Data Memory
    dmem_dout : in  std_logic_vector(15 downto 0);        -- Data Memory data output
    dmem_addr : out std_logic_vector(DMEM_MSB downto 0);  -- Data Memory address
    dmem_cen  : out std_logic;                            -- Data Memory chip enable (low active)
    dmem_din  : out std_logic_vector(15 downto 0);        -- Data Memory data input
    dmem_wen  : out std_logic_vector(1 downto 0);         -- Data Memory write enable (low active)

    -- Program Memory
    pmem_dout : in  std_logic_vector(15 downto 0);        -- Program Memory data output
    pmem_addr : out std_logic_vector(PMEM_MSB downto 0);  -- Program Memory address
    pmem_cen  : out std_logic;                            -- Program Memory chip enable (low active)
    pmem_din  : out std_logic_vector(15 downto 0);        -- Program Memory data input (optional)
    pmem_wen  : out std_logic_vector(1 downto 0);         -- Program Memory write enable (low active) (optional)

    -- LEDs
    switch : in  std_logic_vector(3 downto 0);   -- Input switches
    led    : out std_logic_vector(1 downto 0));  -- LEDs
end msp430_core1;

architecture rtl of msp430_core1 is
component msp430_pu
  port (
    --FRONTEND - SCAN
    scan_enable : in std_logic;
    scan_mode   : in std_logic;

    --FRONTEND - INTERRUPTION
    irq_acc : out std_logic_vector (IRQ_NR - 3 downto 0);
    nmi     : in  std_logic;
    irq     : in  std_logic_vector (IRQ_NR - 3 downto 0);

    --FRONTEND - RESET
    puc_rst : out std_logic;
    reset_n : in  std_logic;

    --DATA MEMORY
    dmem_cen  : out std_logic;
    dmem_wen  : out std_logic_vector (1 downto 0);
    dmem_din  : out std_logic_vector (15 downto 0);
    dmem_addr : out std_logic_vector (DMEM_MSB downto 0);
    dmem_dout : in  std_logic_vector (15 downto 0);

    --INSTRUCTION MEMORY
    pmem_cen  : out std_logic;
    pmem_wen  : out std_logic_vector (1 downto 0);
    pmem_din  : out std_logic_vector (15 downto 0);
    pmem_addr : out std_logic_vector (PMEM_MSB downto 0);
    pmem_dout : in  std_logic_vector (15 downto 0);

    --PERIPHERAL MEMORY
    per_en   : out std_logic;
    per_we   : out std_logic_vector (1 downto 0);
    per_addr : out std_logic_vector (13 downto 0);
    per_din  : out std_logic_vector (15 downto 0);
    per_dout : in  std_logic_vector (15 downto 0);

    --EXECUTION - REGISTERS
    r0  : out std_logic_vector (15 downto 0);
    r1  : out std_logic_vector (15 downto 0);
    r2  : out std_logic_vector (15 downto 0);
    r3  : out std_logic_vector (15 downto 0);
    r4  : out std_logic_vector (15 downto 0);
    r5  : out std_logic_vector (15 downto 0);
    r6  : out std_logic_vector (15 downto 0);
    r7  : out std_logic_vector (15 downto 0);
    r8  : out std_logic_vector (15 downto 0);
    r9  : out std_logic_vector (15 downto 0);
    r10 : out std_logic_vector (15 downto 0);
    r11 : out std_logic_vector (15 downto 0);
    r12 : out std_logic_vector (15 downto 0);
    r13 : out std_logic_vector (15 downto 0);
    r14 : out std_logic_vector (15 downto 0);
    r15 : out std_logic_vector (15 downto 0);

    dbg_clk    : out std_logic;
    dbg_rst    : out std_logic;
    irq_detect : out std_logic;
    nmi_detect : out std_logic;

    i_state : out std_logic_vector (2 downto 0);
    e_state : out std_logic_vector (3 downto 0);
    decode  : out std_logic;
    ir      : out std_logic_vector (15 downto 0);
    irq_num : out std_logic_vector (5 downto 0);
    pc      : out std_logic_vector (15 downto 0);

    nodiv_smclk : out std_logic;

    --DBG
    dbg_freeze : out std_logic;
    dbg_en     : in  std_logic;

    --DBG - I2C
    dbg_i2c_sda_out   : out std_logic;
    dbg_i2c_scl       : in  std_logic;
    dbg_i2c_sda_in    : in  std_logic;
    dbg_i2c_addr      : in  std_logic_vector (6 downto 0);
    dbg_i2c_broadcast : in  std_logic_vector (6 downto 0);

    --DBG - UART
    dbg_uart_txd : out std_logic;
    dbg_uart_rxd : in  std_logic;

    --BCM
    aclk        : out std_logic;
    aclk_en     : out std_logic;
    dco_enable  : out std_logic;
    dco_wkup    : out std_logic;
    lfxt_enable : out std_logic;
    lfxt_wkup   : out std_logic;
    mclk        : out std_logic;
    smclk       : out std_logic;
    smclk_en    : out std_logic;
    cpu_en      : in  std_logic;
    dco_clk     : in  std_logic;
    lfxt_clk    : in  std_logic;
    wkup        : in  std_logic);
end component msp430_pu;

component msp430_gpio
  port (
    p1_dout : out std_logic_vector (7 downto 0);
    p2_dout : out std_logic_vector (7 downto 0);
    p3_dout : out std_logic_vector (7 downto 0);
    p4_dout : out std_logic_vector (7 downto 0);
    p5_dout : out std_logic_vector (7 downto 0);
    p6_dout : out std_logic_vector (7 downto 0);

    p1_dout_en : out std_logic_vector (7 downto 0);
    p2_dout_en : out std_logic_vector (7 downto 0);
    p3_dout_en : out std_logic_vector (7 downto 0);
    p4_dout_en : out std_logic_vector (7 downto 0);
    p5_dout_en : out std_logic_vector (7 downto 0);
    p6_dout_en : out std_logic_vector (7 downto 0);

    p1_sel : out std_logic_vector (7 downto 0);
    p2_sel : out std_logic_vector (7 downto 0);
    p3_sel : out std_logic_vector (7 downto 0);
    p4_sel : out std_logic_vector (7 downto 0);
    p5_sel : out std_logic_vector (7 downto 0);
    p6_sel : out std_logic_vector (7 downto 0);

    p1dir : out std_logic_vector (7 downto 0);
    p1ifg : out std_logic_vector (7 downto 0);

    p1_din : in std_logic_vector (7 downto 0);
    p2_din : in std_logic_vector (7 downto 0);
    p3_din : in std_logic_vector (7 downto 0);
    p4_din : in std_logic_vector (7 downto 0);
    p5_din : in std_logic_vector (7 downto 0);
    p6_din : in std_logic_vector (7 downto 0);

    irq_port1 : out std_logic;
    irq_port2 : out std_logic;

    per_dout : out std_logic_vector (15 downto 0);
    mclk     : in  std_logic;
    per_en   : in  std_logic;
    puc_rst  : in  std_logic;
    per_we   : in  std_logic_vector (1 downto 0);
    per_addr : in  std_logic_vector (13 downto 0);
    per_din  : in  std_logic_vector (15 downto 0));
end component msp430_gpio;

component msp430_ta
  port (
    ta_out0 : out std_logic;
    ta_out1 : out std_logic;
    ta_out2 : out std_logic;
            
    ta_out0_en : out std_logic;
    ta_out1_en : out std_logic;
    ta_out2_en : out std_logic;
          
    ta_cci0a : in std_logic;
    ta_cci1a : in std_logic;
    ta_cci2a : in std_logic;
    
    ta_cci0b : in std_logic;
    ta_cci1b : in std_logic;
    ta_cci2b : in std_logic;

    aclk_en     : in std_logic;
    dbg_freeze  : in std_logic;
    inclk       : in std_logic;
    irq_ta0_acc : in std_logic;
    smclk_en    : in std_logic;
    taclk       : in std_logic;
    
    irq_ta0 : out std_logic;
    irq_ta1 : out std_logic;

    tar    : out std_logic_vector (15 downto 0);
    taccr0 : out std_logic_vector (15 downto 0);
        
    per_dout : out std_logic_vector (15 downto 0);
    mclk     : in std_logic;
    per_en   : in std_logic;
    puc_rst  : in std_logic;
    per_we   : in std_logic_vector (1 downto 0);
    per_addr : in std_logic_vector (13 downto 0);
    per_din  : in std_logic_vector (15 downto 0));
end component msp430_ta;

component msp430_uart
  port (
    uart_txd : out std_logic;
    uart_rxd : in  std_logic;
    smclk_en : in  std_logic;

    irq_uart_rx : out std_logic;
    irq_uart_tx : out std_logic;

    per_dout : out std_logic_vector (15 downto 0);
    mclk     : in  std_logic;
    per_en   : in  std_logic;
    puc_rst  : in  std_logic;
    per_we   : in  std_logic_vector (1 downto 0);
    per_addr : in  std_logic_vector (13 downto 0);
    per_din  : in  std_logic_vector (15 downto 0));
end component msp430_uart;

  --=============================================================================
  -- 1)  INTERNAL WIRES/REGISTERS/PARAMETERS DECLARATION
  --=============================================================================

  -- Clock & Reset
  signal mclk_omsp    : std_logic;
  signal aclk_en      : std_logic;
  signal smclk_en     : std_logic;
  signal puc_rst_omsp : std_logic;

  -- Debug interface
  signal dbg_freeze : std_logic;

  -- Peripheral bus
  signal per_addr : std_logic_vector(13 downto 0);
  signal per_din  : std_logic_vector(15 downto 0);
  signal per_we   : std_logic_vector(1 downto 0);
  signal per_en   : std_logic;
  signal per_dout : std_logic_vector(15 downto 0);

  -- Interrupts
  signal irq_acc : std_logic_vector(13 downto 0);
  signal irq_bus : std_logic_vector(13 downto 0);
  signal nmi     : std_logic;

  -- GPIO
  signal irq_port1     : std_logic;
  signal irq_port2     : std_logic;
  signal p1_din        : std_logic_vector(7 downto 0);
  signal p1_dout       : std_logic_vector(7 downto 0);
  signal p1_dout_en    : std_logic_vector(7 downto 0);
  signal p1_sel        : std_logic_vector(7 downto 0);
  signal p2_din        : std_logic_vector(7 downto 0);
  signal p2_dout       : std_logic_vector(7 downto 0);
  signal p2_dout_en    : std_logic_vector(7 downto 0);
  signal p2_sel        : std_logic_vector(7 downto 0);
  signal per_dout_gpio : std_logic_vector(15 downto 0);

  -- Timer A
  signal irq_ta0     : std_logic;
  signal irq_ta1     : std_logic;
  signal per_dout_tA : std_logic_vector(15 downto 0);

begin
  --=============================================================================
  -- 2)  OPENMSP430 CORE
  --=============================================================================
  msp430_pu_0 : msp430_pu
    generic map (
      INST_NR  => 1,
      TOTAL_NR => 1)
    port map (
      -- OUTPUTs
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

      aclk            => open,             -- ASIC ONLY: ACLK
      aclk_en         => aclk_en,          -- FPGA ONLY: ACLK enable
      dbg_freeze      => dbg_freeze,       -- Freeze peripherals
      dbg_i2c_sda_out => dbg_i2c_sda_out,  -- Debug interface: I2C SDA OUT
      dbg_uart_txd    => open,             -- Debug interface: UART TXD
      dco_enable      => open,             -- ASIC ONLY: Fast oscillator enable
      dco_wkup        => open,             -- ASIC ONLY: Fast oscillator wake-up (asynchronous)
      dmem_addr       => dmem_addr,        -- Data Memory address
      dmem_cen        => dmem_cen,         -- Data Memory chip enable (low active)
      dmem_din        => dmem_din,         -- Data Memory data input
      dmem_wen        => dmem_wen,         -- Data Memory write enable (low active)
      irq_acc         => irq_acc,          -- Interrupt request accepted (one-hot signal)
      lfxt_enable     => open,             -- ASIC ONLY: Low frequency oscillator enable
      lfxt_wkup       => open,             -- ASIC ONLY: Low frequency oscillator wake-up (asynchronous)
      mclk            => mclk_omsp,        -- Main system clock
      per_addr        => per_addr,         -- Peripheral address
      per_din         => per_din,          -- Peripheral data input
      per_we          => per_we,           -- Peripheral write enable (high active)
      per_en          => per_en,           -- Peripheral enable (high active)
      pmem_addr       => pmem_addr,        -- Program Memory address
      pmem_cen        => pmem_cen,         -- Program Memory chip enable (low active)
      pmem_din        => pmem_din,         -- Program Memory data input (optional)
      pmem_wen        => pmem_wen,         -- Program Memory write enable (low active) (optional)
      puc_rst         => puc_rst_omsp,     -- Main system reset
      smclk           => open,             -- ASIC ONLY: SMCLK
      smclk_en        => smclk_en,         -- FPGA ONLY: SMCLK enable

      -- INPUTs
      cpu_en            => '1',                -- Enable CPU code execution (asynchronous and non-glitchy)
      dbg_en            => dbg_en,             -- Debug interface enable (asynchronous and non-glitchy)
      dbg_i2c_addr      => dbg_i2c_addr,       -- Debug interface: I2C Address
      dbg_i2c_broadcast => dbg_i2c_broadcast,  -- Debug interface: I2C Broadcast Address (for multicore systems)
      dbg_i2c_scl       => dbg_i2c_scl,        -- Debug interface: I2C SCL
      dbg_i2c_sda_in    => dbg_i2c_sda_in,     -- Debug interface: I2C SDA IN
      dbg_uart_rxd      => '1',                -- Debug interface: UART RXD (asynchronous)
      dco_clk           => dco_clk,            -- Fast oscillator (fast clock)
      dmem_dout         => dmem_dout,          -- Data Memory data output
      irq               => irq_bus,            -- Maskable interrupts
      lfxt_clk          => '0',                -- Low frequency oscillator (typ 32kHz)
      nmi               => nmi,                -- Non-maskable interrupt (asynchronous)
      per_dout          => per_dout,           -- Peripheral data output
      pmem_dout         => pmem_dout,          -- Program Memory data output
      reset_n           => reset_n,            -- Reset Pin (low active, asynchronous and non-glitchy)
      scan_enable       => '0',                -- ASIC ONLY: Scan enable (active during scan shifting)
      scan_mode         => '0',                -- ASIC ONLY: Scan mode
      wkup              => '0');               -- ASIC ONLY: System Wake-up (asynchronous and non-glitchy)

  dbg_en <= '1';

  --=============================================================================
  -- 3)  OPENMSP430 PERIPHERALS
  --=============================================================================

  -- Digital I/O
  gpio_0 : msp430_gpio
    port map (
      -- OUTPUTs
      irq_port1  => irq_port1,          -- Port 1 interrupt
      irq_port2  => irq_port2,          -- Port 2 interrupt
      p1_dout    => p1_dout,            -- Port 1 data output
      p1_dout_en => p1_dout_en,         -- Port 1 data output enable
      p1_sel     => p1_sel,             -- Port 1 function select
      p2_dout    => p2_dout,            -- Port 2 data output
      p2_dout_en => p2_dout_en,         -- Port 2 data output enable
      p2_sel     => p2_sel,             -- Port 2 function select
      p3_dout    => open,               -- Port 3 data output
      p3_dout_en => open,               -- Port 3 data output enable
      p3_sel     => open,               -- Port 3 function select
      p4_dout    => open,               -- Port 4 data output
      p4_dout_en => open,               -- Port 4 data output enable
      p4_sel     => open,               -- Port 4 function select
      p5_dout    => open,               -- Port 5 data output
      p5_dout_en => open,               -- Port 5 data output enable
      p5_sel     => open,               -- Port 5 function select
      p6_dout    => open,               -- Port 6 data output
      p6_dout_en => open,               -- Port 6 data output enable
      p6_sel     => open,               -- Port 6 function select
      per_dout   => per_dout_gpio,      -- Peripheral data output
      p1dir      => open,
      p1ifg      => open,

      -- INPUTs
      mclk     => mclk_omsp,            -- Main system clock
      p1_din   => p1_din,               -- Port 1 data input
      p2_din   => p2_din,               -- Port 2 data input
      p3_din   => X"00",                -- Port 3 data input
      p4_din   => X"00",                -- Port 4 data input
      p5_din   => X"00",                -- Port 5 data input
      p6_din   => X"00",                -- Port 6 data input
      per_addr => per_addr,             -- Peripheral address
      per_din  => per_din,              -- Peripheral data input
      per_en   => per_en,               -- Peripheral enable (high active)
      per_we   => per_we,               -- Peripheral write enable (high active)
      puc_rst  => puc_rst_omsp);        -- Main system reset

  -- Assign LEDs
  led <= p2_dout(1 downto 0) and p2_dout_en(1 downto 0);

  -- Assign Switches
  p1_din(7 downto 4) <= X"0";
  p1_din(3 downto 0) <= switch;

  -- Timer A
  ta_0 : msp430_ta
    port map (
      -- OUTPUTs
      irq_ta0    => irq_ta0,            -- Timer A interrupt: TACCR0
      irq_ta1    => irq_ta1,            -- Timer A interrupt: TAIV, TACCR1, TACCR2
      per_dout   => per_dout_tA,        -- Peripheral data output
      ta_out0    => open,               -- Timer A output 0
      ta_out0_en => open,               -- Timer A output 0 enable
      ta_out1    => open,               -- Timer A output 1
      ta_out1_en => open,               -- Timer A output 1 enable
      ta_out2    => open,               -- Timer A output 2
      ta_out2_en => open,               -- Timer A output 2 enable
      tar        => open,
      taccr0     => open,

      -- INPUTs
      aclk_en     => aclk_en,           -- ACLK enable (from CPU)
      dbg_freeze  => dbg_freeze,        -- Freeze Timer A counter
      inclk       => '0',               -- INCLK external timer clock (SLOW)
      irq_ta0_acc => irq_acc(9),        -- Interrupt request TACCR0 accepted
      mclk        => mclk_omsp,         -- Main system clock
      per_addr    => per_addr,          -- Peripheral address
      per_din     => per_din,           -- Peripheral data input
      per_en      => per_en,            -- Peripheral enable (high active)
      per_we      => per_we,            -- Peripheral write enable (high active)
      puc_rst     => puc_rst_omsp,      -- Main system reset
      smclk_en    => smclk_en,          -- SMCLK enable (from CPU)
      ta_cci0a    => '0',               -- Timer A capture 0 input A
      ta_cci0b    => '0',               -- Timer A capture 0 input B
      ta_cci1a    => '0',               -- Timer A capture 1 input A
      ta_cci1b    => '0',               -- Timer A capture 1 input B
      ta_cci2a    => '0',               -- Timer A capture 2 input A
      ta_cci2b    => '0',               -- Timer A capture 2 input B
      taclk       => '0');              -- TACLK external timer clock (SLOW)

  -- Combine peripheral data buses
  per_dout <= per_dout_gpio or per_dout_tA;

  -- Assign interrupts
  nmi <= '0';
  irq_bus <= ('0' &                     -- Vector 13  (0xFFFA)
              '0' &                     -- Vector 12  (0xFFF8)
              '0' &                     -- Vector 11  (0xFFF6)
              '0' &                     -- Vector 10  (0xFFF4) - Watchdog -
              '0' &                     -- Vector  9  (0xFFF2) - Reserved (Timer-A 0 from system 0)
              '0' &                     -- Vector  8  (0xFFF0) - Reserved (Timer-A 1 from system 0)
              '0' &                     -- Vector  7  (0xFFEE) - Reserved (UART RX from system 0)
              '0' &                     -- Vector  6  (0xFFEC) - Reserved (UART TX from system 0)
              irq_ta0 &                 -- Vector  5  (0xFFEA)
              irq_ta1 &                 -- Vector  4  (0xFFE8)
              '0' &                     -- Vector  3  (0xFFE6) - Reserved (Port 2 from system 0)
              '0' &                     -- Vector  2  (0xFFE4) - Reserved (Port 1 from system 0)
              irq_port2 &               -- Vector  1  (0xFFE2)
              irq_port1);               -- Vector  0  (0xFFE0)

  mclk    <= mclk_omsp;
  puc_rst <= puc_rst_omsp;
end rtl;

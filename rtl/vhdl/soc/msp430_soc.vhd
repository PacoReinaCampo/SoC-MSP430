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

entity msp430_soc is
  port (
    --CORE 0
    -- CPU registers
    omsp0_r0  : out std_logic_vector(15 downto 0);
    omsp0_r1  : out std_logic_vector(15 downto 0);
    omsp0_r2  : out std_logic_vector(15 downto 0);
    omsp0_r3  : out std_logic_vector(15 downto 0);
    omsp0_r4  : out std_logic_vector(15 downto 0);
    omsp0_r5  : out std_logic_vector(15 downto 0);
    omsp0_r6  : out std_logic_vector(15 downto 0);
    omsp0_r7  : out std_logic_vector(15 downto 0);
    omsp0_r8  : out std_logic_vector(15 downto 0);
    omsp0_r9  : out std_logic_vector(15 downto 0);
    omsp0_r10 : out std_logic_vector(15 downto 0);
    omsp0_r11 : out std_logic_vector(15 downto 0);
    omsp0_r12 : out std_logic_vector(15 downto 0);
    omsp0_r13 : out std_logic_vector(15 downto 0);
    omsp0_r14 : out std_logic_vector(15 downto 0);
    omsp0_r15 : out std_logic_vector(15 downto 0);

    -- Debug interface
    omsp0_dbg_en  : out std_logic;
    omsp0_dbg_clk : out std_logic;
    omsp0_dbg_rst : out std_logic;

    -- Interrupt detection
    omsp0_irq_detect : out std_logic;
    omsp0_nmi_pnd    : out std_logic;

    omsp0_i_state : out std_logic_vector(2 downto 0);
    omsp0_e_state : out std_logic_vector(3 downto 0);
    omsp0_decode  : out std_logic;
    omsp0_ir      : out std_logic_vector(15 downto 0);
    omsp0_irq_num : out std_logic_vector(5 downto 0);
    omsp0_pc      : out std_logic_vector(15 downto 0);

    -- CPU internals
    omsp0_mclk    : out std_logic;
    omsp0_puc_rst : out std_logic;

    --CORE 1
    -- CPU registers
    omsp1_r0  : out std_logic_vector(15 downto 0);
    omsp1_r1  : out std_logic_vector(15 downto 0);
    omsp1_r2  : out std_logic_vector(15 downto 0);
    omsp1_r3  : out std_logic_vector(15 downto 0);
    omsp1_r4  : out std_logic_vector(15 downto 0);
    omsp1_r5  : out std_logic_vector(15 downto 0);
    omsp1_r6  : out std_logic_vector(15 downto 0);
    omsp1_r7  : out std_logic_vector(15 downto 0);
    omsp1_r8  : out std_logic_vector(15 downto 0);
    omsp1_r9  : out std_logic_vector(15 downto 0);
    omsp1_r10 : out std_logic_vector(15 downto 0);
    omsp1_r11 : out std_logic_vector(15 downto 0);
    omsp1_r12 : out std_logic_vector(15 downto 0);
    omsp1_r13 : out std_logic_vector(15 downto 0);
    omsp1_r14 : out std_logic_vector(15 downto 0);
    omsp1_r15 : out std_logic_vector(15 downto 0);

    -- Debug interface
    omsp1_dbg_en  : out std_logic;
    omsp1_dbg_clk : out std_logic;
    omsp1_dbg_rst : out std_logic;

    -- Interrupt detection
    omsp1_irq_detect : out std_logic;
    omsp1_nmi_pnd    : out std_logic;

    omsp1_i_state : out std_logic_vector(2 downto 0);
    omsp1_e_state : out std_logic_vector(3 downto 0);
    omsp1_decode  : out std_logic;
    omsp1_ir      : out std_logic_vector(15 downto 0);
    omsp1_irq_num : out std_logic_vector(5 downto 0);
    omsp1_pc      : out std_logic_vector(15 downto 0);

    -- CPU internals
    omsp1_mclk    : out std_logic;
    omsp1_puc_rst : out std_logic;

    -- Data memory
    omsp0_dmem_addr    : out std_logic_vector(DMEM_MSB downto 0);
    omsp0_dmem_cen_sp  : out std_logic;
    omsp0_dmem_cen_dp  : out std_logic;
    omsp0_dmem_din     : out std_logic_vector(15 downto 0);
    omsp0_dmem_wen     : out std_logic_vector(1 downto 0);
    omsp0_dmem_dout_sp : in  std_logic_vector(15 downto 0);
    omsp0_dmem_dout_dp : in  std_logic_vector(15 downto 0);

    omsp1_dmem_addr    : out std_logic_vector(DMEM_MSB downto 0);
    omsp1_dmem_cen_sp  : out std_logic;
    omsp1_dmem_cen_dp  : out std_logic;
    omsp1_dmem_din     : out std_logic_vector(15 downto 0);
    omsp1_dmem_wen     : out std_logic_vector(1 downto 0);
    omsp1_dmem_dout_sp : in  std_logic_vector(15 downto 0);
    omsp1_dmem_dout_dp : in  std_logic_vector(15 downto 0);

    -- Program memory
    omsp0_pmem_addr : out std_logic_vector(PMEM_MSB downto 0);
    omsp0_pmem_cen  : out std_logic;
    omsp0_pmem_din  : out std_logic_vector(15 downto 0);
    omsp0_pmem_wen  : out std_logic_vector(1 downto 0);
    omsp0_pmem_dout : in  std_logic_vector(15 downto 0);

    omsp1_pmem_addr : out std_logic_vector(PMEM_MSB downto 0);
    omsp1_pmem_cen  : out std_logic;
    omsp1_pmem_din  : out std_logic_vector(15 downto 0);
    omsp1_pmem_wen  : out std_logic_vector(1 downto 0);
    omsp1_pmem_dout : in  std_logic_vector(15 downto 0);

    dco_clk : out std_logic;

    ------------------------------------------------
    -- User Reset Push Button
    ------------------------------------------------
    USER_RESET : in std_logic;

    ------------------------------------------------
    -- TI CDCE913 Triple-Output PLL Clock Chip
    --   Y1: 40 MHz; USER_CLOCK can be used as
    --              external configuration clock
    --   Y2: 66.667 MHz
    --   Y3: 100 MHz 
    ------------------------------------------------
    USER_CLOCK : in std_logic;

    ------------------------------------------------
    -- User DIP Switch x4
    ------------------------------------------------
    GPIO_DIP1 : in std_logic;
    GPIO_DIP2 : in std_logic;
    GPIO_DIP3 : in std_logic;
    GPIO_DIP4 : in std_logic;

    ------------------------------------------------
    -- User LEDs    
    ------------------------------------------------
    GPIO_LED1 : out std_logic;
    GPIO_LED2 : out std_logic;
    GPIO_LED3 : out std_logic;
    GPIO_LED4 : out std_logic;

    ------------------------------------------------
    -- Silicon Labs CP2102 USB-to-UART Bridge Chip
    ------------------------------------------------
    USB_RS232_RXD : in  std_logic;
    USB_RS232_TXD : out std_logic;

    ------------------------------------------------
    -- Peripheral Modules (PMODs) and GPIO
    --     https://www.digilentinc.com/PMODs
    ------------------------------------------------

    -- Connector J5
    PMOD1_P3 : inout std_logic;
    PMOD1_P4 : in    std_logic);
end msp430_soc;

architecture rtl of msp430_soc is
  component msp430_core0
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

      -- UART
      uart_rxd : in  std_logic;         -- UART Data Receive (RXD)
      uart_txd : out std_logic;         -- UART Data Transmit (TXD)

      -- Switches & LEDs
      switch : in  std_logic_vector(3 downto 0);   -- Input switches
      led    : out std_logic_vector(1 downto 0));  -- LEDs
  end component msp430_core0;

  component msp430_core1
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
      dbg_i2c_scl       : in  std_logic;                     -- Debug interface: I2C SCL
      dbg_i2c_sda_in    : in  std_logic;                     -- Debug interface: I2C SDA IN
      dbg_i2c_sda_out   : out std_logic;                     -- Debug interface: I2C SDA OUT

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
  end component msp430_core1;

  component msp430_io_cell
    port (
      pad         : inout std_logic;
      data_in     : out   std_logic;
      data_out    : in    std_logic;
      data_out_en : in    std_logic);
  end component msp430_io_cell;

  --=============================================================================
  -- 1)  INTERNAL WIRES/REGISTERS/PARAMETERS DECLARATION
  --=============================================================================

  -- Clock generation
  signal dco_clk_omsp : std_logic;

  -- Reset generation
  signal reset_pin   : std_logic;
  signal reset_pin_n : std_logic;
  signal reset_n     : std_logic;

  -- Debug interface
  signal omsp_dbg_i2c_scl      : std_logic;
  signal omsp_dbg_i2c_sda_in   : std_logic;
  signal omsp_dbg_i2c_sda_out  : std_logic;
  signal omsp0_dbg_i2c_sda_out : std_logic;
  signal omsp1_dbg_i2c_sda_out : std_logic;

  -- Data memory
  signal omsp0_dmem_cen      : std_logic;
  signal omsp0_dmem_dout     : std_logic_vector(15 downto 0);
  signal omsp0_dmem_dout_sel : std_logic;

  signal omsp1_dmem_cen      : std_logic;
  signal omsp1_dmem_dout     : std_logic_vector(15 downto 0);
  signal omsp1_dmem_dout_sel : std_logic;

  -- UART
  signal omsp0_uart_rxd : std_logic;
  signal omsp0_uart_txd : std_logic;

  -- LEDs & Switches
  signal omsp_switch : std_logic_vector(3 downto 0);
  signal omsp0_led   : std_logic_vector(1 downto 0);
  signal omsp1_led   : std_logic_vector(1 downto 0);

  -- Top level reset generation
  signal dco_rst : std_logic;
begin
  --=============================================================================
  -- 2)  RESET GENERATION & FPGA STARTUP
  --=============================================================================

  -- Reset input buffer
  reset_pin   <= USER_RESET;
  reset_pin_n <= not reset_pin;

  -- Release the reset only, if the DCM is locked
  reset_n <= reset_pin_n;

  sync_reset_dco : msp430_sync_reset
    port map (
      rst_s => dco_rst,
      clk   => dco_clk_omsp,
      rst_a => not reset_n);

  --=============================================================================
  -- 3)  CLOCK GENERATION
  --=============================================================================

  -- Input buffers
  dco_clk_omsp <= USER_CLOCK;

  --=============================================================================
  -- 4)  OPENMSP430 SYSTEM 0
  --=============================================================================

  msp430_core0_0 : msp430_core0
    port map (
      -- CPU registers
      r0  => omsp0_r0,
      r1  => omsp0_r1,
      r2  => omsp0_r2,
      r3  => omsp0_r3,
      r4  => omsp0_r4,
      r5  => omsp0_r5,
      r6  => omsp0_r6,
      r7  => omsp0_r7,
      r8  => omsp0_r8,
      r9  => omsp0_r9,
      r10 => omsp0_r10,
      r11 => omsp0_r11,
      r12 => omsp0_r12,
      r13 => omsp0_r13,
      r14 => omsp0_r14,
      r15 => omsp0_r15,

      -- Debug interface
      dbg_en  => omsp0_dbg_en,
      dbg_clk => omsp0_dbg_clk,
      dbg_rst => omsp0_dbg_rst,

      -- Interrupt detection
      irq_detect => omsp0_irq_detect,
      nmi_pnd    => omsp0_nmi_pnd,

      i_state => omsp0_i_state,
      e_state => omsp0_e_state,
      decode  => omsp0_decode,
      ir      => omsp0_ir,
      irq_num => omsp0_irq_num,
      pc      => omsp0_pc,

      -- CPU internals
      mclk    => omsp0_mclk,
      puc_rst => omsp0_puc_rst,

      -- Clock & Reset
      dco_clk => dco_clk_omsp,  -- Fast oscillator (fast clock)
      reset_n => reset_n,       -- Reset Pin (low active, asynchronous and non-glitchy)

      -- Serial Debug Interface (I2C)
      dbg_i2c_addr      => std_logic_vector(to_unsigned(50, 7)),  -- Debug interface: I2C Address
      dbg_i2c_broadcast => std_logic_vector(to_unsigned(49, 7)),  -- Debug interface: I2C Broadcast Address (for multicore systems)
      dbg_i2c_scl       => omsp_dbg_i2c_scl,                      -- Debug interface: I2C SCL
      dbg_i2c_sda_in    => omsp_dbg_i2c_sda_in,                   -- Debug interface: I2C SDA IN
      dbg_i2c_sda_out   => omsp0_dbg_i2c_sda_out,                 -- Debug interface: I2C SDA OUT

      -- Data Memory
      dmem_addr => omsp0_dmem_addr,     -- Data Memory address
      dmem_cen  => omsp0_dmem_cen,      -- Data Memory chip enable (low active)
      dmem_din  => omsp0_dmem_din,      -- Data Memory data input
      dmem_wen  => omsp0_dmem_wen,      -- Data Memory write enable (low active)
      dmem_dout => omsp0_dmem_dout,     -- Data Memory data output

      -- Program Memory
      pmem_addr => omsp0_pmem_addr,     -- Program Memory address
      pmem_cen  => omsp0_pmem_cen,      -- Program Memory chip enable (low active)
      pmem_din  => omsp0_pmem_din,      -- Program Memory data input (optional)
      pmem_wen  => omsp0_pmem_wen,      -- Program Memory write enable (low active) (optional)
      pmem_dout => omsp0_pmem_dout,     -- Program Memory data output

      -- UART
      uart_rxd => omsp0_uart_rxd,       -- UART Data Receive (RXD)
      uart_txd => omsp0_uart_txd,       -- UART Data Transmit (TXD)

      -- Switches & LEDs
      switch => omsp_switch,            -- Input switches
      led    => omsp0_led);             -- LEDs

  --=============================================================================
  -- 5)  OPENMSP430 SYSTEM 1
  --=============================================================================
  msp430_core1_0 : msp430_core1
    port map (
      -- CPU registers
      r0  => omsp1_r0,
      r1  => omsp1_r1,
      r2  => omsp1_r2,
      r3  => omsp1_r3,
      r4  => omsp1_r4,
      r5  => omsp1_r5,
      r6  => omsp1_r6,
      r7  => omsp1_r7,
      r8  => omsp1_r8,
      r9  => omsp1_r9,
      r10 => omsp1_r10,
      r11 => omsp1_r11,
      r12 => omsp1_r12,
      r13 => omsp1_r13,
      r14 => omsp1_r14,
      r15 => omsp1_r15,

      -- Debug interface
      dbg_en  => omsp1_dbg_en,
      dbg_clk => omsp1_dbg_clk,
      dbg_rst => omsp1_dbg_rst,

      -- Interrupt detection
      irq_detect => omsp1_irq_detect,
      nmi_pnd    => omsp1_nmi_pnd,

      i_state => omsp1_i_state,
      e_state => omsp1_e_state,
      decode  => omsp1_decode,
      ir      => omsp1_ir,
      irq_num => omsp1_irq_num,
      pc      => omsp1_pc,

      -- CPU internals
      mclk    => omsp1_mclk,
      puc_rst => omsp1_puc_rst,

      -- Clock & Reset
      dco_clk => dco_clk_omsp,  -- Fast oscillator (fast clock)
      reset_n => reset_n,       -- Reset Pin (low active, asynchronous and non-glitchy)

      -- Serial Debug Interface (I2C)
      dbg_i2c_addr      => std_logic_vector(to_unsigned(51, 7)),  -- Debug interface: I2C Address
      dbg_i2c_broadcast => std_logic_vector(to_unsigned(49, 7)),  -- Debug interface: I2C Broadcast Address (for multicore systems)
      dbg_i2c_scl       => omsp_dbg_i2c_scl,                      -- Debug interface: I2C SCL
      dbg_i2c_sda_in    => omsp_dbg_i2c_sda_in,                   -- Debug interface: I2C SDA IN
      dbg_i2c_sda_out   => omsp1_dbg_i2c_sda_out,                 -- Debug interface: I2C SDA OUT

      -- Data Memory
      dmem_addr => omsp1_dmem_addr,     -- Data Memory address
      dmem_cen  => omsp1_dmem_cen,      -- Data Memory chip enable (low active)
      dmem_din  => omsp1_dmem_din,      -- Data Memory data input
      dmem_wen  => omsp1_dmem_wen,      -- Data Memory write enable (low active)
      dmem_dout => omsp1_dmem_dout,     -- Data Memory data output

      -- Program Memory
      pmem_addr => omsp1_pmem_addr,  -- Program Memory address
      pmem_cen  => omsp1_pmem_cen,   -- Program Memory chip enable (low active)
      pmem_din  => omsp1_pmem_din,   -- Program Memory data input (optional)
      pmem_wen  => omsp1_pmem_wen,   -- Program Memory write enable (low active) (optional)
      pmem_dout => omsp1_pmem_dout,  -- Program Memory data output

      -- Switches & LEDs
      switch => omsp_switch,            -- Input switches
      led    => omsp1_led);             -- LEDs

  --=============================================================================
  -- 6)  PROGRAM AND DATA MEMORIES
  --=============================================================================

  -- Memory muxing (CPU 0)
  omsp0_dmem_cen_sp <= omsp0_dmem_addr(DMEM_MSB) or omsp0_dmem_cen;
  omsp0_dmem_cen_dp <= not omsp0_dmem_addr(DMEM_MSB) or omsp0_dmem_cen;
  omsp0_dmem_dout   <= omsp0_dmem_dout_sp when omsp0_dmem_dout_sel else omsp0_dmem_dout_dp;

  processing_0 : process (dco_clk_omsp, dco_rst)
  begin
    if (dco_rst) then
      omsp0_dmem_dout_sel <= '1';
    elsif (rising_edge(dco_clk_omsp)) then
      if (not omsp0_dmem_cen_sp) then
        omsp0_dmem_dout_sel <= '1';
      elsif (not omsp0_dmem_cen_dp) then
        omsp0_dmem_dout_sel <= '0';
      end if;
    end if;
  end process;

  -- Memory muxing (CPU 1)
  omsp1_dmem_cen_sp <= omsp1_dmem_addr(DMEM_MSB) or omsp1_dmem_cen;
  omsp1_dmem_cen_dp <= not omsp1_dmem_addr(DMEM_MSB) or omsp1_dmem_cen;
  omsp1_dmem_dout   <= omsp1_dmem_dout_sp when omsp1_dmem_dout_sel else omsp1_dmem_dout_dp;

  processing_1 : process (dco_clk, dco_rst)
  begin
    if (dco_rst) then
      omsp1_dmem_dout_sel <= '1';
    elsif (rising_edge(dco_clk_omsp)) then
      if (not omsp1_dmem_cen_sp) then
        omsp1_dmem_dout_sel <= '1';
      elsif (not omsp1_dmem_cen_dp) then
        omsp1_dmem_dout_sel <= '0';
      end if;
    end if;
  end process;

  --=============================================================================
  -- 7)  I/O CELLS
  --=============================================================================

  ------------------------------------------------
  -- User DIP Switch x4
  ------------------------------------------------
  omsp_switch(3) <= GPIO_DIP4;
  omsp_switch(2) <= GPIO_DIP3;
  omsp_switch(1) <= GPIO_DIP2;
  omsp_switch(0) <= GPIO_DIP1;

  ------------------------------------------------
  -- User LEDs    
  ------------------------------------------------
  GPIO_LED4 <= omsp1_led(1);
  GPIO_LED3 <= omsp1_led(0);
  GPIO_LED2 <= omsp0_led(1);
  GPIO_LED1 <= omsp0_led(0);

  ------------------------------------------------
  -- Silicon Labs CP2102 USB-to-UART Bridge Chip
  ------------------------------------------------
  omsp0_uart_rxd <= USB_RS232_RXD;
  USB_RS232_TXD  <= omsp0_uart_txd;

  ------------------------------------------------
  -- Peripheral Modules (PMODs) and GPIO
  --     https://www.digilentinc.com/PMODs
  ------------------------------------------------

  omsp_dbg_i2c_sda_out <= omsp0_dbg_i2c_sda_out and omsp1_dbg_i2c_sda_out;

  -- Connector J5
  PMOD_P3_PIN : msp430_io_cell
    port map (
      data_out_en => omsp_dbg_i2c_sda_out,
      data_in     => omsp_dbg_i2c_sda_in,
      data_out    => '0',
      pad         => PMOD1_P3);

  omsp_dbg_i2c_scl <= PMOD1_P4;
  dco_clk          <= dco_clk_omsp;
end rtl;

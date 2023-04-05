-- Converted from bench/verilog/regression/peripheral_spram_testbench.sv
-- by verilog2vhdl - QueenField

--------------------------------------------------------------------------------
--                                            __ _      _     _               --
--                                           / _(_)    | |   | |              --
--                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              --
--               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              --
--              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              --
--               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              --
--                  | |                                                       --
--                  |_|                                                       --
--                                                                            --
--                                                                            --
--              MPSoC-RISCV CPU                                               --
--              Master Slave Interface Tesbench                               --
--              AMBA3 AHB-Lite Bus Interface                                  --
--                                                                            --
--------------------------------------------------------------------------------

-- Copyright (c) 2018-2019 by the author(s)
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
--------------------------------------------------------------------------------
-- Author(s):
--   Paco Reina Campo <pacoreinacampo@queenfield.tech>
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.peripheral_spram_ahb3_pkg.all;

entity peripheral_spram_testbench is
end peripheral_spram_testbench;

architecture rtl of peripheral_spram_testbench is
  ------------------------------------------------------------------------------
  -- Variables
  ------------------------------------------------------------------------------

  --Common signals
  signal HRESETn : std_logic;
  signal HCLK    : std_logic;

  --AHB3 signals
  signal mst_spsoc_ram_HSEL      : std_logic;
  signal mst_spsoc_ram_HADDR     : std_logic_vector(PLEN-1 downto 0);
  signal mst_spsoc_ram_HWDATA    : std_logic_vector(XLEN-1 downto 0);
  signal mst_spsoc_ram_HRDATA    : std_logic_vector(XLEN-1 downto 0);
  signal mst_spsoc_ram_HWRITE    : std_logic;
  signal mst_spsoc_ram_HSIZE     : std_logic_vector(2 downto 0);
  signal mst_spsoc_ram_HBURST    : std_logic_vector(2 downto 0);
  signal mst_spsoc_ram_HPROT     : std_logic_vector(3 downto 0);
  signal mst_spsoc_ram_HTRANS    : std_logic_vector(1 downto 0);
  signal mst_spsoc_ram_HMASTLOCK : std_logic;
  signal mst_spsoc_ram_HREADY    : std_logic;
  signal mst_spsoc_ram_HREADYOUT : std_logic;
  signal mst_spsoc_ram_HRESP     : std_logic;

  ------------------------------------------------------------------------------
  -- Components
  ------------------------------------------------------------------------------
  component mpsoc_ahb3_spram
    generic (
      MEM_SIZE          : integer := 256;  --Memory in Bytes
      MEM_DEPTH         : integer := 256;  --Memory depth
      PLEN              : integer := 64;
      XLEN              : integer := 64;
      TECHNOLOGY        : string  := "GENERIC";
      REGISTERED_OUTPUT : string  := "NO"
      );
    port (
      HRESETn : in std_logic;
      HCLK    : in std_logic;

      --AHB Slave Interfaces (receive data from AHB Masters)
      --AHB Masters connect to these ports
      HSEL      : in  std_logic;
      HADDR     : in  std_logic_vector(PLEN-1 downto 0);
      HWDATA    : in  std_logic_vector(XLEN-1 downto 0);
      HRDATA    : out std_logic_vector(XLEN-1 downto 0);
      HWRITE    : in  std_logic;
      HSIZE     : in  std_logic_vector(2 downto 0);
      HBURST    : in  std_logic_vector(2 downto 0);
      HPROT     : in  std_logic_vector(3 downto 0);
      HTRANS    : in  std_logic_vector(1 downto 0);
      HMASTLOCK : in  std_logic;
      HREADYOUT : out std_logic;
      HREADY    : in  std_logic;
      HRESP     : out std_logic
      );
  end component;

begin
  ------------------------------------------------------------------------------
  -- Module Body
  ------------------------------------------------------------------------------

  --DUT AHB3
  ahb3_spram : mpsoc_ahb3_spram
    generic map (
      MEM_SIZE          => 256,
      MEM_DEPTH         => 256,
      PLEN              => PLEN,
      XLEN              => XLEN,
      TECHNOLOGY        => TECHNOLOGY,
      REGISTERED_OUTPUT => "NO"
      )
    port map (
      HRESETn => HRESETn,
      HCLK    => HCLK,

      HSEL      => mst_spsoc_ram_HSEL,
      HADDR     => mst_spsoc_ram_HADDR,
      HWDATA    => mst_spsoc_ram_HWDATA,
      HRDATA    => mst_spsoc_ram_HRDATA,
      HWRITE    => mst_spsoc_ram_HWRITE,
      HSIZE     => mst_spsoc_ram_HSIZE,
      HBURST    => mst_spsoc_ram_HBURST,
      HPROT     => mst_spsoc_ram_HPROT,
      HTRANS    => mst_spsoc_ram_HTRANS,
      HMASTLOCK => mst_spsoc_ram_HMASTLOCK,
      HREADYOUT => mst_spsoc_ram_HREADYOUT,
      HREADY    => mst_spsoc_ram_HREADY,
      HRESP     => mst_spsoc_ram_HRESP
      );
end rtl;

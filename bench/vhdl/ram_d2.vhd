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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.msp430_pkg.all;

entity ram_d2 is
  port (
    clka  : in  std_logic;
    ena   : in  std_logic;
    wea   : in  std_logic_vector(1 downto 0);
    addra : in  std_logic_vector(DMEM_MSB-1 downto 0);
    dina  : in  std_logic_vector(15 downto 0);
    douta : out std_logic_vector(15 downto 0);
    clkb  : in  std_logic;
    enb   : in  std_logic;
    web   : in  std_logic_vector(1 downto 0);
    addrb : in  std_logic_vector(DMEM_MSB-1 downto 0);
    dinb  : in  std_logic_vector(15 downto 0);
    doutb : out std_logic_vector(15 downto 0));
end ram_d2;

architecture rtl of ram_d2 is
begin
  --============
  -- RAM
  --============
  dp : ram_dp
    generic map (
      ADDR_MSB => DMEM_MSB - 1,
      MEM_SIZE => DMEM_SIZE)
    port map (
      -- OUTPUTs
      ram_douta => douta,  -- RAM data output (Port A)
      ram_doutb => doutb,  -- RAM data output (Port B)

      -- INPUTs
      ram_addra => addra,     -- RAM address (Port A)
      ram_cena  => not ena,   -- RAM chip enable (low active) (Port A)
      ram_clka  => clka,      -- RAM clock (Port A)
      ram_dina  => dina,      -- RAM data input (Port A)
      ram_wena  => not wea,   -- RAM write enable (low active) (Port A)
      ram_addrb => addrb,     -- RAM address (Port B)
      ram_cenb  => not enb,   -- RAM chip enable (low active) (Port B)
      ram_clkb  => clkb,      -- RAM clock (Port B)
      ram_dinb  => dinb,      -- RAM data input (Port B)
      ram_wenb  => not web);  -- RAM write enable (low active) (Port B)  
end rtl;

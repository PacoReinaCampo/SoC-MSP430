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
-- *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
--

library IEEE;
use IEEE.STD_LOGIC_1164 .all;
use IEEE.NUMERIC_STD .all;
use WORK.MSP430_PACK .all;

entity soc_ram_d1 is
  port (
    clka  : in  std_logic;
    ena   : in  std_logic;
    wea   : in  std_logic_vector(1 downto 0);
    addra : in  std_logic_vector(DMEM_MSB-1 downto 0);
    dina  : in  std_logic_vector(15 downto 0);
    douta : out std_logic_vector(15 downto 0));
end soc_ram_d1;

architecture rtl of soc_ram_d1 is
begin
  --============
  -- RAM
  --============
  dp : soc_ram_dp
    generic map (
      ADDR_MSB => DMEM_MSB,
      MEM_SIZE => DMEM_SIZE)
    port map (
      -- OUTPUTs
      soc_ram_dout => douta,                -- RAM data output

      -- INPUTs
      soc_ram_addr => addra,                -- RAM address
      soc_ram_cen  => not ena,              -- RAM chip enable (low active)
      soc_ram_clk  => clka,                 -- RAM clock
      soc_ram_din  => dina,                 -- RAM data input
      soc_ram_wen  => not wea);             -- RAM write enable (low active)
end rtl;

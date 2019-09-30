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

entity INSTRUCTION_MEMORY_SHARED_SINGLEPORT is
  port (
    clka  : in  std_ulogic;
    ena   : in  std_ulogic;
    wea   : in  std_ulogic_vector(1 downto 0);
    addra : in  std_ulogic_vector(PMEM_MSB downto 0);
    dina  : in  std_ulogic_vector(15 downto 0);
    douta : out std_ulogic_vector(15 downto 0));
end INSTRUCTION_MEMORY_SHARED_SINGLEPORT;

architecture INSTRUCTION_MEMORY_SHARED_SINGLEPORT_ARQ of INSTRUCTION_MEMORY_SHARED_SINGLEPORT is
  --////////////////////////////////////////////////////////////////
  --
  -- Types
  --
  type type_mem_array is array (2**PMEM_MSB-1 downto 0) of std_ulogic_vector(15 downto 0);  --memory array

  --////////////////////////////////////////////////////////////////
  --
  -- Variables
  --
  signal mem_array : type_mem_array;  --memory array

begin
  --////////////////////////////////////////////////////////////////
  --
  -- Module Body
  --

  --write side
  generating_0 : for i in 0 to (16+7)/8 - 1 generate
    generating_1 : if (i*8+8 > 16) generate
      processing_0 : process (clka)
      begin
        if (rising_edge(clka)) then
          if (wea(0) ='0' and ena ='0' and to_unsigned(i, PMEM_MSB) = unsigned(addra)) then
            mem_array(i)(15 downto i*8) <= dina(15 downto i*8);
          end if;
        end if;
      end process;
    end generate;
    generating_2 : if (i*8+8 <= 16) generate
      processing_1 : process (clka)
      begin
        if (rising_edge(clka)) then
          if (wea(0) ='0' and ena ='0' and to_unsigned(i, PMEM_MSB) = unsigned(addra)) then
            mem_array(i)(i*8 downto i) <= dina(i*8 downto i);
          end if;
        end if;
      end process;
    end generate;
  end generate;

  --read side
  --per Altera's recommendations; avoids bypass logic
  processing_2 : process (clka)
  begin
    if (rising_edge(clka)) then
      douta <= mem_array(to_integer(unsigned(addra)));
    end if;
  end process;
end INSTRUCTION_MEMORY_SHARED_SINGLEPORT_ARQ;

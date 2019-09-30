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

entity DATA_MEMORY_SHARED_QUADPORT is
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
end DATA_MEMORY_SHARED_QUADPORT;

architecture DATA_MEMORY_SHARED_QUADPORT_ARQ of DATA_MEMORY_SHARED_QUADPORT is

  constant nd : integer := 4;

  type M_ND1_15 is array (nd - 1 downto 0) of std_ulogic_vector (15 downto 0);
  type M_ND1_DMEM_MSB1 is array (nd - 1 downto 0) of std_ulogic_vector (DMEM_MSB downto 0);
  type M_ND1_1 is array (nd - 1 downto 0) of std_ulogic_vector (1 downto 0);

  signal dout   : M_ND1_15;
  signal addr   : M_ND1_DMEM_MSB1;
  signal not_en : std_ulogic_vector (nd - 1 downto 0);
  signal clk    : std_ulogic_vector (nd - 1 downto 0);
  signal din    : M_ND1_15;
  signal not_we : M_ND1_1;

  component DATA_MEMORY_SHARED_SINGLEPORT
    port (
      clka  : in  std_ulogic;
      ena   : in  std_ulogic;
      wea   : in  std_ulogic_vector (1 downto 0);
      addra : in  std_ulogic_vector (DMEM_MSB downto 0);
      dina  : in  std_ulogic_vector (15 downto 0);
      douta : out std_ulogic_vector (15 downto 0));
  end component DATA_MEMORY_SHARED_SINGLEPORT;

begin
  douta <= dout(0);
  doutb <= dout(1);
  doutx <= dout(2);
  douty <= dout(3);

  addr   <= (addry, addrx, addrb, addra);
  not_en <= (not eny, not enx, not enb, not ena);
  clk    <= (clky, clkx, clkb, clka);
  din    <= (diny, dinx, dinb, dina);
  not_we <= (not wey, not wex, not web, not wea);

  DATA_MEMORY_SHARED_I : for i in nd - 1 downto 0 generate
    DATA_MEMORY_SHARED_SP : DATA_MEMORY_SHARED_SINGLEPORT
      port map (
        douta => dout (i),
        clka  => clk (i),
        ena   => not_en (i),
        wea   => not_we (i),
        dina  => din (i),
        addra => addr (i));
  end generate DATA_MEMORY_SHARED_I;
end DATA_MEMORY_SHARED_QUADPORT_ARQ;

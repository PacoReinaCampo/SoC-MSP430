////////////////////////////////////////////////////////////////////////////////
//                                            __ _      _     _               //
//                                           / _(_)    | |   | |              //
//                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              //
//               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              //
//              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              //
//               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              //
//                  | |                                                       //
//                  |_|                                                       //
//                                                                            //
//                                                                            //
//              MSP430 CPU                                                    //
//              Processing Unit                                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/* Copyright (c) 2015-2016 by the author(s)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * =============================================================================
 * Author(s):
 *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
 */

`include "msp430_defines.sv"

module ram_p2 (
  input                clka,
  input                ena,
  input  [        1:0] wea,
  input  [`PMEM_MSB:0] addra,
  input  [       15:0] dina,
  output [       15:0] douta,

  input                clkb,
  input                enb,
  input  [        1:0] web,
  input  [`PMEM_MSB:0] addrb,
  input  [       15:0] dinb,
  output [       15:0] doutb
);

  //============
  // RAM
  //============

  ram_dp #(
    .ADDR_MSB(`PMEM_MSB),
    .MEM_SIZE(`PMEM_SIZE)
  )
  dp (
    // OUTPUTs
    .ram_douta     ( douta),      // RAM data output (Port A)
    .ram_doutb     ( doutb),      // RAM data output (Port B)

    // INPUTs
    .ram_addra     ( addra),      // RAM address (Port A)
    .ram_cena      (~ena),        // RAM chip enable (low active) (Port A)
    .ram_clka      ( clka),       // RAM clock (Port A)
    .ram_dina      ( dina),       // RAM data input (Port A)
    .ram_wena      (~wea),        // RAM write enable (low active) (Port A)
    .ram_addrb     ( addrb),      // RAM address (Port B)
    .ram_cenb      (~enb),        // RAM chip enable (low active) (Port B)
    .ram_clkb      ( clkb),       // RAM clock (Port B)
    .ram_dinb      ( dinb),       // RAM data input (Port B)
    .ram_wenb      (~web)         // RAM write enable (low active) (Port B)
  );
endmodule // ram_p2


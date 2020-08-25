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

module ram_sp #(
  parameter ADDR_MSB = 6,         // MSB of the address bus
  parameter MEM_SIZE = 256        // Memory size in bytes
)
  (
  // OUTPUTs
  output [      15:0] ram_dout,       // RAM data output

  // INPUTs
  input  [ADDR_MSB:0] ram_addr,       // RAM address
  input               ram_cen,        // RAM chip enable (low active)
  input               ram_clk,        // RAM clock
  input  [      15:0] ram_din,        // RAM data input
  input  [       1:0] ram_wen         // RAM write enable (low active)
);

  // RAM
  //============

  reg   [      15:0] mem [0:(MEM_SIZE/2)-1];
  reg   [ADDR_MSB:0] ram_addr_reg;

  wire  [      15:0] mem_val = mem[ram_addr];

  always @(posedge ram_clk) begin
    if (~ram_cen && (ram_addr<(MEM_SIZE/2))) begin
      if      (ram_wen==2'b00) mem[ram_addr] <= ram_din;
      else if (ram_wen==2'b01) mem[ram_addr] <= {ram_din[15:8], mem_val[7:0]};
      else if (ram_wen==2'b10) mem[ram_addr] <= {mem_val[15:8], ram_din[7:0]};
      ram_addr_reg <= ram_addr;
    end
  end

  assign ram_dout = mem[ram_addr_reg];
endmodule // ram_sp

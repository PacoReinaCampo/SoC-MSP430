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

module ram_dp #(
  parameter ADDR_MSB   =  6,         // MSB of the address bus
  parameter MEM_SIZE   =  256        // Memory size in bytes
)
  (
    // OUTPUTs
    output      [15:0] ram_douta,      // RAM data output (Port A)
    output      [15:0] ram_doutb,      // RAM data output (Port B)

    // INPUTs
    input [ADDR_MSB:0] ram_addra,      // RAM address (Port A)
    input              ram_cena,       // RAM chip enable (low active) (Port A)
    input              ram_clka,       // RAM clock (Port A)
    input [      15:0] ram_dina,       // RAM data input (Port A)
    input [       1:0] ram_wena,       // RAM write enable (low active) (Port A)

    input [ADDR_MSB:0] ram_addrb,      // RAM address (Port B)
    input              ram_cenb,       // RAM chip enable (low active) (Port B)
    input              ram_clkb,       // RAM clock (Port B)
    input [      15:0] ram_dinb,       // RAM data input (Port B)
    input [       1:0] ram_wenb        // RAM write enable (low active) (Port B)
  );

  // RAM
  //============

  reg   [      15:0] mem [0:(MEM_SIZE/2)-1];
  reg   [ADDR_MSB:0] ram_addra_reg;
  reg   [ADDR_MSB:0] ram_addrb_reg;

  wire  [      15:0] mem_vala = mem[ram_addra];
  wire  [      15:0] mem_valb = mem[ram_addrb];

  always @(posedge ram_clka) begin
    if (~ram_cena && (ram_addra<(MEM_SIZE/2))) begin
      if      (ram_wena==2'b00) mem[ram_addra] <=  ram_dina;
      else if (ram_wena==2'b01) mem[ram_addra] <= {ram_dina[15:8],  mem_vala[7:0]};
      else if (ram_wena==2'b10) mem[ram_addra] <= {mem_vala[15:8],  ram_dina[7:0]};
      ram_addra_reg <= ram_addra;
    end
  end

  assign ram_douta = mem[ram_addra_reg];

  always @(posedge ram_clkb) begin
    if (~ram_cenb && (ram_addrb<(MEM_SIZE/2))) begin
      if      (ram_wenb==2'b00) mem[ram_addrb] <=  ram_dinb;
      else if (ram_wenb==2'b01) mem[ram_addrb] <= {ram_dinb[15:8],  mem_valb[7:0]};
      else if (ram_wenb==2'b10) mem[ram_addrb] <= {mem_valb[15:8],  ram_dinb[7:0]};
      ram_addrb_reg <= ram_addrb;
    end
  end

  assign ram_doutb = mem[ram_addrb_reg];
endmodule // ram_dp

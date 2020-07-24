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
//              MPSoC-RISCV CPU                                               //
//              General Purpose Input Output Bridge                           //
//              Blackbone Bus Interface                                       //
//              Universal Verification Methodology                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/* Copyright (c) 2018-2019 by the author(s)
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

interface dutintf;
  logic        mclk;
  logic        mrst;
  logic [ 7:0] per_addr;
  logic        per_we;
  logic        per_en;
  logic [31:0] per_dout;
  logic [31:0] per_din;
endinterface

module bb_slave(dutintf dif);
  logic [31:0] mem [256];
  logic [ 1:0] bb_st;

  const logic [1:0] SETUP = 0;
  const logic [1:0] W_ENABLE = 1;
  const logic [1:0] R_ENABLE = 2;

  // SETUP -> ENABLE
  always @(negedge dif.mrst or posedge dif.mclk) begin
    if (dif.mrst == 0) begin
      bb_st <= 0;
      dif.per_dout <= 0;
    end
    else begin
      case (bb_st)
        SETUP : begin
          // clear the per_dout
          dif.per_dout <= 0;
          // Move to ENABLE
          if (!dif.per_en) begin
            if (dif.per_we) begin
              bb_st <= W_ENABLE;
            end
            else begin
              bb_st <= R_ENABLE;
            end
          end
        end
        W_ENABLE : begin
          // write per_din to memory
          if (dif.per_en && dif.per_we) begin
            mem[dif.per_addr] <= dif.per_din;
          end
          // return to SETUP
          bb_st <= SETUP;
        end
        R_ENABLE : begin
          // read per_dout from memory
          if (dif.per_en && !dif.per_we) begin
            dif.per_dout <= mem[dif.per_addr];
          end
          // return to SETUP
          bb_st <= SETUP;
        end
      endcase
    end
  end
endmodule

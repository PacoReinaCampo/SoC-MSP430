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

`timescale 1 ns /100 ps
 
module  soc_msp430_dac (

  // OUTPUTs
  output       [11:0] vout,           // Peripheral data output
 
  // INPUTs
  input               din,            // SPI Serial Data
  input               scl,;           // SPI Serial Clock
  input               sync_n          // SPI Frame synchronization signal (low active)
);

//============================================================================
// 1) SPI INTERFACE
//============================================================================

  // SPI Transfer Start detection
  reg sync_dly_n;
  always @(negedge sclk) begin
    sync_dly_n <= sync_n;
  end

  wire spi_tfx_start = ~sync_n & sync_dly_n;

  // Data counter
  reg [3:0] spi_cnt;
  wire      spi_cnt_done = (spi_cnt==4'hf);

  always @(negedge sclk) begin
    if (sync_n)             spi_cnt <= 4'hf;
    else if (spi_tfx_start) spi_cnt <= 4'he;
    else if (~spi_cnt_done) spi_cnt <= spi_cnt-1;
  end

  wire spi_tfx_done = sync_n & ~sync_dly_n & spi_cnt_done;

  // Value to be shifted in
  reg  [15:0] dac_shifter;

  always @(negedge sclk) begin
    dac_shifter <= {dac_shifter[14:0], din};
  end

  // DAC Output value
  reg  [11:0] vout;

  always @(negedge sclk) begin
    if (spi_tfx_done) begin
      vout <= dac_shifter[11:0];
    end
  end
endmodule // soc_msp430_dac
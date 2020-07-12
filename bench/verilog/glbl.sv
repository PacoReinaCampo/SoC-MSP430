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

`timescale  1 ps / 1 ps

module glbl ();

  parameter ROC_WIDTH = 100000;
  parameter TOC_WIDTH = 0;

  wire GSR;
  wire GTS;
  wire PRLD;

  reg GSR_int;
  reg GTS_int;
  reg PRLD_int;

  //--------   JTAG Globals --------------
  wire JTAG_TDO_GLBL;
  wire JTAG_TCK_GLBL;
  wire JTAG_TDI_GLBL;
  wire JTAG_TMS_GLBL;
  wire JTAG_TRST_GLBL;

  reg JTAG_CAPTURE_GLBL;
  reg JTAG_RESET_GLBL;
  reg JTAG_SHIFT_GLBL;
  reg JTAG_UPDATE_GLBL;

  reg JTAG_SEL1_GLBL = 0;
  reg JTAG_SEL2_GLBL = 0 ;
  reg JTAG_SEL3_GLBL = 0;
  reg JTAG_SEL4_GLBL = 0;

  reg JTAG_USER_TDO1_GLBL = 1'bz;
  reg JTAG_USER_TDO2_GLBL = 1'bz;
  reg JTAG_USER_TDO3_GLBL = 1'bz;
  reg JTAG_USER_TDO4_GLBL = 1'bz;

  assign (weak1, weak0) GSR = GSR_int;
  assign (weak1, weak0) GTS = GTS_int;
  assign (weak1, weak0) PRLD = PRLD_int;

  initial begin
    GSR_int = 1'b1;
    PRLD_int = 1'b1;
    #(ROC_WIDTH)
    GSR_int = 1'b0;
    PRLD_int = 1'b0;
  end

  initial begin
    GTS_int = 1'b1;
    #(TOC_WIDTH)
    GTS_int = 1'b0;
  end

endmodule

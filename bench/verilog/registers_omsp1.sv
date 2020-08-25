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

// Data Memory cells
//======================

wire       [15:0] omsp1_mem200 = ram_d1_omsp1.sp.mem[0];
wire       [15:0] omsp1_mem202 = ram_d1_omsp1.sp.mem[1];
wire       [15:0] omsp1_mem204 = ram_d1_omsp1.sp.mem[2];
wire       [15:0] omsp1_mem206 = ram_d1_omsp1.sp.mem[3];
wire       [15:0] omsp1_mem208 = ram_d1_omsp1.sp.mem[4];
wire       [15:0] omsp1_mem20A = ram_d1_omsp1.sp.mem[5];
wire       [15:0] omsp1_mem20C = ram_d1_omsp1.sp.mem[6];
wire       [15:0] omsp1_mem20E = ram_d1_omsp1.sp.mem[7];
wire       [15:0] omsp1_mem210 = ram_d1_omsp1.sp.mem[8];
wire       [15:0] omsp1_mem212 = ram_d1_omsp1.sp.mem[9];
wire       [15:0] omsp1_mem214 = ram_d1_omsp1.sp.mem[10];
wire       [15:0] omsp1_mem216 = ram_d1_omsp1.sp.mem[11];
wire       [15:0] omsp1_mem218 = ram_d1_omsp1.sp.mem[12];
wire       [15:0] omsp1_mem21A = ram_d1_omsp1.sp.mem[13];
wire       [15:0] omsp1_mem21C = ram_d1_omsp1.sp.mem[14];
wire       [15:0] omsp1_mem21E = ram_d1_omsp1.sp.mem[15];
wire       [15:0] omsp1_mem220 = ram_d1_omsp1.sp.mem[16];
wire       [15:0] omsp1_mem222 = ram_d1_omsp1.sp.mem[17];
wire       [15:0] omsp1_mem224 = ram_d1_omsp1.sp.mem[18];
wire       [15:0] omsp1_mem226 = ram_d1_omsp1.sp.mem[19];
wire       [15:0] omsp1_mem228 = ram_d1_omsp1.sp.mem[20];
wire       [15:0] omsp1_mem22A = ram_d1_omsp1.sp.mem[21];
wire       [15:0] omsp1_mem22C = ram_d1_omsp1.sp.mem[22];
wire       [15:0] omsp1_mem22E = ram_d1_omsp1.sp.mem[23];
wire       [15:0] omsp1_mem230 = ram_d1_omsp1.sp.mem[24];
wire       [15:0] omsp1_mem232 = ram_d1_omsp1.sp.mem[25];
wire       [15:0] omsp1_mem234 = ram_d1_omsp1.sp.mem[26];
wire       [15:0] omsp1_mem236 = ram_d1_omsp1.sp.mem[27];
wire       [15:0] omsp1_mem238 = ram_d1_omsp1.sp.mem[28];
wire       [15:0] omsp1_mem23A = ram_d1_omsp1.sp.mem[29];
wire       [15:0] omsp1_mem23C = ram_d1_omsp1.sp.mem[30];
wire       [15:0] omsp1_mem23E = ram_d1_omsp1.sp.mem[31];
wire       [15:0] omsp1_mem240 = ram_d1_omsp1.sp.mem[32];
wire       [15:0] omsp1_mem242 = ram_d1_omsp1.sp.mem[33];
wire       [15:0] omsp1_mem244 = ram_d1_omsp1.sp.mem[34];
wire       [15:0] omsp1_mem246 = ram_d1_omsp1.sp.mem[35];
wire       [15:0] omsp1_mem248 = ram_d1_omsp1.sp.mem[36];
wire       [15:0] omsp1_mem24A = ram_d1_omsp1.sp.mem[37];
wire       [15:0] omsp1_mem24C = ram_d1_omsp1.sp.mem[38];
wire       [15:0] omsp1_mem24E = ram_d1_omsp1.sp.mem[39];
wire       [15:0] omsp1_mem250 = ram_d1_omsp1.sp.mem[40];
wire       [15:0] omsp1_mem252 = ram_d1_omsp1.sp.mem[41];
wire       [15:0] omsp1_mem254 = ram_d1_omsp1.sp.mem[42];
wire       [15:0] omsp1_mem256 = ram_d1_omsp1.sp.mem[43];
wire       [15:0] omsp1_mem258 = ram_d1_omsp1.sp.mem[44];
wire       [15:0] omsp1_mem25A = ram_d1_omsp1.sp.mem[45];
wire       [15:0] omsp1_mem25C = ram_d1_omsp1.sp.mem[46];
wire       [15:0] omsp1_mem25E = ram_d1_omsp1.sp.mem[47];
wire       [15:0] omsp1_mem260 = ram_d1_omsp1.sp.mem[48];
wire       [15:0] omsp1_mem262 = ram_d1_omsp1.sp.mem[49];
wire       [15:0] omsp1_mem264 = ram_d1_omsp1.sp.mem[50];
wire       [15:0] omsp1_mem266 = ram_d1_omsp1.sp.mem[51];
wire       [15:0] omsp1_mem268 = ram_d1_omsp1.sp.mem[52];
wire       [15:0] omsp1_mem26A = ram_d1_omsp1.sp.mem[53];
wire       [15:0] omsp1_mem26C = ram_d1_omsp1.sp.mem[54];
wire       [15:0] omsp1_mem26E = ram_d1_omsp1.sp.mem[55];
wire       [15:0] omsp1_mem270 = ram_d1_omsp1.sp.mem[56];
wire       [15:0] omsp1_mem272 = ram_d1_omsp1.sp.mem[57];
wire       [15:0] omsp1_mem274 = ram_d1_omsp1.sp.mem[58];
wire       [15:0] omsp1_mem276 = ram_d1_omsp1.sp.mem[59];
wire       [15:0] omsp1_mem278 = ram_d1_omsp1.sp.mem[60];
wire       [15:0] omsp1_mem27A = ram_d1_omsp1.sp.mem[61];
wire       [15:0] omsp1_mem27C = ram_d1_omsp1.sp.mem[62];
wire       [15:0] omsp1_mem27E = ram_d1_omsp1.sp.mem[63];
wire       [15:0] omsp1_mem280 = ram_d1_omsp1.sp.mem[64];

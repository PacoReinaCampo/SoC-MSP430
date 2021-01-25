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

+incdir+../../../../../rtl/verilog/pkg/

//=============================================================================
// Testbench related
//=============================================================================

+incdir+../../../../../bench/verilog/main/

../../../../../bench/verilog/main/ram_d1.sv
../../../../../bench/verilog/main/ram_d2.sv
../../../../../bench/verilog/main/ram_dp.sv
../../../../../bench/verilog/main/ram_p2.sv
../../../../../bench/verilog/main/ram_sp.sv
../../../../../bench/verilog/main/glbl.sv
../../../../../bench/verilog/main/msp430_debug.sv
../../../../../bench/verilog/main/msp430_testbench.sv


//=============================================================================
// SoC-MSP430
//=============================================================================

../../../../../rtl/verilog/pu/msp430_pu0.sv
../../../../../rtl/verilog/pu/msp430_pu1.sv

../../../../../rtl/verilog/soc/msp430_soc.sv
../../../../../rtl/verilog/soc/msp430_io_cell.sv

//=============================================================================
// PU-MSP430
//=============================================================================

../../../../../pu/rtl/verilog/core/fuse/msp430_and_gate.sv
../../../../../pu/rtl/verilog/core/fuse/msp430_clock_gate.sv
../../../../../pu/rtl/verilog/core/fuse/msp430_clock_mux.sv
../../../../../pu/rtl/verilog/core/fuse/msp430_scan_mux.sv
../../../../../pu/rtl/verilog/core/fuse/msp430_sync_cell.sv
../../../../../pu/rtl/verilog/core/fuse/msp430_sync_reset.sv
../../../../../pu/rtl/verilog/core/fuse/msp430_wakeup_cell.sv

../../../../../pu/rtl/verilog/core/omsp/msp430_alu.sv
../../../../../pu/rtl/verilog/core/omsp/msp430_dbg_hwbrk.sv
../../../../../pu/rtl/verilog/core/omsp/msp430_dbg_i2c.sv
../../../../../pu/rtl/verilog/core/omsp/msp430_dbg_uart.sv
../../../../../pu/rtl/verilog/core/omsp/msp430_register_file.sv

../../../../../pu/rtl/verilog/core/main/msp430_bcm.sv
../../../../../pu/rtl/verilog/core/main/msp430_dbg.sv
../../../../../pu/rtl/verilog/core/main/msp430_execution.sv
../../../../../pu/rtl/verilog/core/main/msp430_frontend.sv
../../../../../pu/rtl/verilog/core/main/msp430_gpio.sv
../../../../../pu/rtl/verilog/core/main/msp430_memory.sv
../../../../../pu/rtl/verilog/core/main/msp430_multiplier.sv
../../../../../pu/rtl/verilog/core/main/msp430_sfr.sv
../../../../../pu/rtl/verilog/core/main/msp430_ta.sv
../../../../../pu/rtl/verilog/core/main/msp430_watchdog.sv
../../../../../pu/rtl/verilog/core/main/msp430_template08.sv
../../../../../pu/rtl/verilog/core/main/msp430_template16.sv
../../../../../pu/rtl/verilog/core/main/msp430_uart.sv

../../../../../pu/rtl/verilog/pu/msp430_core.sv

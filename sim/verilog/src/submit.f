//=============================================================================
// Copyright (C) 2001 Authors
//
// This source file may be used and distributed without restriction provided
// that this copyright statement is not removed from the file and that any
// derivative work contains the original copyright notice and the associated
// disclaimer.
//
// This source file is free software; you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published
// by the Free Software Foundation; either version 2.1 of the License, or
// (at your option) any later version.
//
// This source is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
// License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this source; if not, write to the Free Software Foundation,
// Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
//
//-----------------------------------------------------------------------------
// 
// File Name: submit.f
// 
// Author(s):
//             - Olivier Girard,    olgirard@gmail.com
//
//-----------------------------------------------------------------------------
// $Rev: 136 $
// $LastChangedBy: olivier.girard $
// $LastChangedDate: 2012-03-22 22:14:16 +0100 (Thu, 22 Mar 2012) $
//=============================================================================

+incdir+../../../rtl/verilog/pkg/

//=============================================================================
// Testbench related
//=============================================================================

../../../bench/verilog/RAM_D1.v
../../../bench/verilog/RAM_D2.v
../../../bench/verilog/RAM_P2.v
../../../bench/verilog/glbl.v
../../../bench/verilog/msp_debug.v
../../../bench/verilog/RAM_DP.v
../../../bench/verilog/RAM_SP.v
../../../bench/verilog/tb_openMSP430.v


//=============================================================================
// SoC-MSP430
//=============================================================================

../../../rtl/verilog/soc/MSP430_CORE0.v
../../../rtl/verilog/soc/MSP430_CORE1.v
../../../rtl/verilog/soc/MSP430_SoC.v
../../../rtl/verilog/soc/io_cell.v

//=============================================================================
// PU-MSP430
//=============================================================================

../../../pu/rtl/verilog/core/MSP430_CORE.v

../../../pu/rtl/verilog/core/main/BCM.v
../../../pu/rtl/verilog/core/main/DBG.v
../../../pu/rtl/verilog/core/main/EXECUTION.v
../../../pu/rtl/verilog/core/main/FRONTEND.v
../../../pu/rtl/verilog/core/main/GPIO.v
../../../pu/rtl/verilog/core/main/MEMORY.v
../../../pu/rtl/verilog/core/main/MULTIPLIER.v
../../../pu/rtl/verilog/core/main/SFR.v
../../../pu/rtl/verilog/core/main/T_A.v
../../../pu/rtl/verilog/core/main/T_WATCHDOG.v
../../../pu/rtl/verilog/core/main/TEMPLATE_08.v
../../../pu/rtl/verilog/core/main/TEMPLATE_16.v
../../../pu/rtl/verilog/core/main/UART.v

../../../pu/rtl/verilog/core/fuse/omsp_and_gate.v
../../../pu/rtl/verilog/core/fuse/omsp_clock_gate.v
../../../pu/rtl/verilog/core/fuse/omsp_clock_mux.v
../../../pu/rtl/verilog/core/fuse/omsp_scan_mux.v
../../../pu/rtl/verilog/core/fuse/omsp_sync_cell.v
../../../pu/rtl/verilog/core/fuse/omsp_sync_reset.v
../../../pu/rtl/verilog/core/fuse/omsp_wakeup_cell.v

../../../pu/rtl/verilog/core/omsp/omsp_alu.v
../../../pu/rtl/verilog/core/omsp/omsp_dbg_hwbrk.v
../../../pu/rtl/verilog/core/omsp/omsp_dbg_i2c.v
../../../pu/rtl/verilog/core/omsp/omsp_dbg_uart.v
../../../pu/rtl/verilog/core/omsp/omsp_register_file.v


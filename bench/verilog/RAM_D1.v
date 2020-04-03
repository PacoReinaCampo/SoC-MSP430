//----------------------------------------------------------------------------
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
//----------------------------------------------------------------------------
// 
// *File Name: ram.v
// 
// *Module Description:
//                      Scalable RAM model
//
// *Author(s):
//              - Olivier Girard,    olgirard@gmail.com
//
//----------------------------------------------------------------------------
// $Rev: 103 $
// $LastChangedBy: olivier.girard $
// $LastChangedDate: 2011-03-05 15:44:48 +0100 (Sat, 05 Mar 2011) $
//----------------------------------------------------------------------------

`include "openMSP430_defines.v"

module RAM_D1 (
  clka,
  ena,
  wea,
  addra,
  dina,
  douta
);

input clka;
input ena;
input [1 : 0] wea;
input [`DMEM_MSB - 1 : 0] addra;
input [15 : 0] dina;
output [15 : 0] douta;

//============
// RAM
//============

RAM_SP #(.ADDR_MSB(`DMEM_MSB - 1), .MEM_SIZE(`DMEM_SIZE)) RAM_SP_inst (

// OUTPUTs
    .ram_dout     ( douta),      // RAM data output

// INPUTs
    .ram_addr     ( addra),      // RAM address
    .ram_cen      (~ena),        // RAM chip enable (low active)
    .ram_clk      ( clka),       // RAM clock
    .ram_din      ( dina),       // RAM data input
    .ram_wen      (~wea)         // RAM write enable (low active)
);


endmodule // RAM_D1


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
// *File Name: registers.v
// 
// *Module Description:
//                      Direct connections to internal registers & memory.
//
//
// *Author(s):
//              - Olivier Girard,    olgirard@gmail.com
//
//----------------------------------------------------------------------------
// $Rev: 143 $
// $LastChangedBy: olivier.girard $
// $LastChangedDate: 2012-05-09 22:20:03 +0200 (Wed, 09 May 2012) $
//----------------------------------------------------------------------------

// Data Memory cells
//======================

wire       [15:0] omsp0_mem200 = RAM_D1_omsp0.RAM_SP_inst.mem[0];
wire       [15:0] omsp0_mem202 = RAM_D1_omsp0.RAM_SP_inst.mem[1];
wire       [15:0] omsp0_mem204 = RAM_D1_omsp0.RAM_SP_inst.mem[2];
wire       [15:0] omsp0_mem206 = RAM_D1_omsp0.RAM_SP_inst.mem[3];
wire       [15:0] omsp0_mem208 = RAM_D1_omsp0.RAM_SP_inst.mem[4];
wire       [15:0] omsp0_mem20A = RAM_D1_omsp0.RAM_SP_inst.mem[5];
wire       [15:0] omsp0_mem20C = RAM_D1_omsp0.RAM_SP_inst.mem[6];
wire       [15:0] omsp0_mem20E = RAM_D1_omsp0.RAM_SP_inst.mem[7];
wire       [15:0] omsp0_mem210 = RAM_D1_omsp0.RAM_SP_inst.mem[8];
wire       [15:0] omsp0_mem212 = RAM_D1_omsp0.RAM_SP_inst.mem[9];
wire       [15:0] omsp0_mem214 = RAM_D1_omsp0.RAM_SP_inst.mem[10];
wire       [15:0] omsp0_mem216 = RAM_D1_omsp0.RAM_SP_inst.mem[11];
wire       [15:0] omsp0_mem218 = RAM_D1_omsp0.RAM_SP_inst.mem[12];
wire       [15:0] omsp0_mem21A = RAM_D1_omsp0.RAM_SP_inst.mem[13];
wire       [15:0] omsp0_mem21C = RAM_D1_omsp0.RAM_SP_inst.mem[14];
wire       [15:0] omsp0_mem21E = RAM_D1_omsp0.RAM_SP_inst.mem[15];
wire       [15:0] omsp0_mem220 = RAM_D1_omsp0.RAM_SP_inst.mem[16];
wire       [15:0] omsp0_mem222 = RAM_D1_omsp0.RAM_SP_inst.mem[17];
wire       [15:0] omsp0_mem224 = RAM_D1_omsp0.RAM_SP_inst.mem[18];
wire       [15:0] omsp0_mem226 = RAM_D1_omsp0.RAM_SP_inst.mem[19];
wire       [15:0] omsp0_mem228 = RAM_D1_omsp0.RAM_SP_inst.mem[20];
wire       [15:0] omsp0_mem22A = RAM_D1_omsp0.RAM_SP_inst.mem[21];
wire       [15:0] omsp0_mem22C = RAM_D1_omsp0.RAM_SP_inst.mem[22];
wire       [15:0] omsp0_mem22E = RAM_D1_omsp0.RAM_SP_inst.mem[23];
wire       [15:0] omsp0_mem230 = RAM_D1_omsp0.RAM_SP_inst.mem[24];
wire       [15:0] omsp0_mem232 = RAM_D1_omsp0.RAM_SP_inst.mem[25];
wire       [15:0] omsp0_mem234 = RAM_D1_omsp0.RAM_SP_inst.mem[26];
wire       [15:0] omsp0_mem236 = RAM_D1_omsp0.RAM_SP_inst.mem[27];
wire       [15:0] omsp0_mem238 = RAM_D1_omsp0.RAM_SP_inst.mem[28];
wire       [15:0] omsp0_mem23A = RAM_D1_omsp0.RAM_SP_inst.mem[29];
wire       [15:0] omsp0_mem23C = RAM_D1_omsp0.RAM_SP_inst.mem[30];
wire       [15:0] omsp0_mem23E = RAM_D1_omsp0.RAM_SP_inst.mem[31];
wire       [15:0] omsp0_mem240 = RAM_D1_omsp0.RAM_SP_inst.mem[32];
wire       [15:0] omsp0_mem242 = RAM_D1_omsp0.RAM_SP_inst.mem[33];
wire       [15:0] omsp0_mem244 = RAM_D1_omsp0.RAM_SP_inst.mem[34];
wire       [15:0] omsp0_mem246 = RAM_D1_omsp0.RAM_SP_inst.mem[35];
wire       [15:0] omsp0_mem248 = RAM_D1_omsp0.RAM_SP_inst.mem[36];
wire       [15:0] omsp0_mem24A = RAM_D1_omsp0.RAM_SP_inst.mem[37];
wire       [15:0] omsp0_mem24C = RAM_D1_omsp0.RAM_SP_inst.mem[38];
wire       [15:0] omsp0_mem24E = RAM_D1_omsp0.RAM_SP_inst.mem[39];
wire       [15:0] omsp0_mem250 = RAM_D1_omsp0.RAM_SP_inst.mem[40];
wire       [15:0] omsp0_mem252 = RAM_D1_omsp0.RAM_SP_inst.mem[41];
wire       [15:0] omsp0_mem254 = RAM_D1_omsp0.RAM_SP_inst.mem[42];
wire       [15:0] omsp0_mem256 = RAM_D1_omsp0.RAM_SP_inst.mem[43];
wire       [15:0] omsp0_mem258 = RAM_D1_omsp0.RAM_SP_inst.mem[44];
wire       [15:0] omsp0_mem25A = RAM_D1_omsp0.RAM_SP_inst.mem[45];
wire       [15:0] omsp0_mem25C = RAM_D1_omsp0.RAM_SP_inst.mem[46];
wire       [15:0] omsp0_mem25E = RAM_D1_omsp0.RAM_SP_inst.mem[47];
wire       [15:0] omsp0_mem260 = RAM_D1_omsp0.RAM_SP_inst.mem[48];
wire       [15:0] omsp0_mem262 = RAM_D1_omsp0.RAM_SP_inst.mem[49];
wire       [15:0] omsp0_mem264 = RAM_D1_omsp0.RAM_SP_inst.mem[50];
wire       [15:0] omsp0_mem266 = RAM_D1_omsp0.RAM_SP_inst.mem[51];
wire       [15:0] omsp0_mem268 = RAM_D1_omsp0.RAM_SP_inst.mem[52];
wire       [15:0] omsp0_mem26A = RAM_D1_omsp0.RAM_SP_inst.mem[53];
wire       [15:0] omsp0_mem26C = RAM_D1_omsp0.RAM_SP_inst.mem[54];
wire       [15:0] omsp0_mem26E = RAM_D1_omsp0.RAM_SP_inst.mem[55];
wire       [15:0] omsp0_mem270 = RAM_D1_omsp0.RAM_SP_inst.mem[56];
wire       [15:0] omsp0_mem272 = RAM_D1_omsp0.RAM_SP_inst.mem[57];
wire       [15:0] omsp0_mem274 = RAM_D1_omsp0.RAM_SP_inst.mem[58];
wire       [15:0] omsp0_mem276 = RAM_D1_omsp0.RAM_SP_inst.mem[59];
wire       [15:0] omsp0_mem278 = RAM_D1_omsp0.RAM_SP_inst.mem[60];
wire       [15:0] omsp0_mem27A = RAM_D1_omsp0.RAM_SP_inst.mem[61];
wire       [15:0] omsp0_mem27C = RAM_D1_omsp0.RAM_SP_inst.mem[62];
wire       [15:0] omsp0_mem27E = RAM_D1_omsp0.RAM_SP_inst.mem[63];
wire       [15:0] omsp0_mem280 = RAM_D1_omsp0.RAM_SP_inst.mem[64];


// Program Memory cells
//======================
reg   [15:0] pmem [0:8191];

// Interrupt vectors
wire  [15:0] irq_vect_15 = pmem[(1<<(`PMEM_MSB+1))-1];  // RESET Vector
wire  [15:0] irq_vect_14 = pmem[(1<<(`PMEM_MSB+1))-2];  // NMI
wire  [15:0] irq_vect_13 = pmem[(1<<(`PMEM_MSB+1))-3];  // IRQ 13
wire  [15:0] irq_vect_12 = pmem[(1<<(`PMEM_MSB+1))-4];  // IRQ 12
wire  [15:0] irq_vect_11 = pmem[(1<<(`PMEM_MSB+1))-5];  // IRQ 11
wire  [15:0] irq_vect_10 = pmem[(1<<(`PMEM_MSB+1))-6];  // IRQ 10
wire  [15:0] irq_vect_09 = pmem[(1<<(`PMEM_MSB+1))-7];  // IRQ  9
wire  [15:0] irq_vect_08 = pmem[(1<<(`PMEM_MSB+1))-8];  // IRQ  8
wire  [15:0] irq_vect_07 = pmem[(1<<(`PMEM_MSB+1))-9];  // IRQ  7
wire  [15:0] irq_vect_06 = pmem[(1<<(`PMEM_MSB+1))-10]; // IRQ  6
wire  [15:0] irq_vect_05 = pmem[(1<<(`PMEM_MSB+1))-11]; // IRQ  5
wire  [15:0] irq_vect_04 = pmem[(1<<(`PMEM_MSB+1))-12]; // IRQ  4
wire  [15:0] irq_vect_03 = pmem[(1<<(`PMEM_MSB+1))-13]; // IRQ  3
wire  [15:0] irq_vect_02 = pmem[(1<<(`PMEM_MSB+1))-14]; // IRQ  2
wire  [15:0] irq_vect_01 = pmem[(1<<(`PMEM_MSB+1))-15]; // IRQ  1
wire  [15:0] irq_vect_00 = pmem[(1<<(`PMEM_MSB+1))-16]; // IRQ  0

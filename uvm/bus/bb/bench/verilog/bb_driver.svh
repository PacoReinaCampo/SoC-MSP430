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

class bb_driver extends uvm_driver#(bb_transaction);
  `uvm_component_utils(bb_driver)

  virtual dutintf vintf;

  bb_transaction bb_trans;
  function new(string name, uvm_component parent);
    super.new(name, parent);
    bb_trans = new();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual dutintf)::get(this, "*", "vintf", vintf)) begin
      `uvm_error("","driver virtual interface failed")
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    vintf.rst_n = 0;
    #5;
    @(posedge vintf.mmclk);
    vintf.rst_n = 1;
    forever begin
    seq_item_port.get_next_item(req);
    vintf.per_addr = req.per_addr;
    vintf.per_we = req.per_we;
    vintf.per_din = req.per_din;
    vintf.per_en = req.per_en;
    //`uvm_info("",$sformatf("per_addr is %x, per_din is %x, per_en is %x, per_we is %x", vintf.per_addr, vintf.per_din, vintf.per_en, vintf.per_we), UVM_LOW)
    @(posedge vintf.mmclk);
    seq_item_port.item_done();
    end
  endtask
endclass

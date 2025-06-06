###################################################################################
##                                            __ _      _     _                  ##
##                                           / _(_)    | |   | |                 ##
##                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |                 ##
##               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |                 ##
##              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |                 ##
##               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|                 ##
##                  | |                                                          ##
##                  |_|                                                          ##
##                                                                               ##
##                                                                               ##
##              Architecture                                                     ##
##              QueenField                                                       ##
##                                                                               ##
###################################################################################

###################################################################################
##                                                                               ##
## Copyright (c) 2019-2020 by the author(s)                                      ##
##                                                                               ##
## Permission is hereby granted, free of charge, to any person obtaining a copy  ##
## of this software and associated documentation files (the "Software"), to deal ##
## in the Software without restriction, including without limitation the rights  ##
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     ##
## copies of the Software, and to permit persons to whom the Software is         ##
## furnished to do so, subject to the following conditions:                      ##
##                                                                               ##
## The above copyright notice and this permission notice shall be included in    ##
## all copies or substantial portions of the Software.                           ##
##                                                                               ##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    ##
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      ##
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   ##
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        ##
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, ##
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     ##
## THE SOFTWARE.                                                                 ##
##                                                                               ##
## ============================================================================= ##
## Author(s):                                                                    ##
##   Paco Reina Campo <pacoreinacampo@queenfield.tech>                           ##
##                                                                               ##
###################################################################################

+incdir+../../../../../../../pu/rtl/verilog/pkg
+incdir+../../../../../../../rtl/verilog/soc/optimsoc/bootrom
+incdir+../../../../../../../verification/tasks/library/cpp/verilator/inc
+incdir+../../../../../../../verification/tasks/library/cpp/glip

../../../../../../../peripheral/dma/rtl/verilog/code/pkg/core/peripheral_dma_pkg.sv

../../../../../../../rtl/verilog/pkg/arbiter/soc_arbiter_rr.sv
../../../../../../../rtl/verilog/pkg/functions/soc_optimsoc_functions.sv
../../../../../../../rtl/verilog/pkg/configuration/soc_optimsoc_configuration.sv
../../../../../../../rtl/verilog/pkg/constants/soc_optimsoc_constants.sv

../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/interfaces/common/peripheral_dbg_soc_dii_channel_flat.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/interfaces/common/peripheral_dbg_soc_dii_channel.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/interfaces/msp430/peripheral_dbg_soc_mmsp430_trace_exec.sv

../../../../../../../verification/tasks/library/verilog/optimsoc/glip/soc_glip_channel.sv

../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/buffer/peripheral_dbg_soc_dii_buffer.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/buffer/peripheral_dbg_soc_osd_fifo.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/eventpacket/peripheral_dbg_soc_osd_event_packetization_fixedwidth.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/eventpacket/peripheral_dbg_soc_osd_event_packetization.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/regaccess/peripheral_dbg_soc_osd_regaccess_demux.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/regaccess/peripheral_dbg_soc_osd_regaccess_layer.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/regaccess/peripheral_dbg_soc_osd_regaccess.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/timestamp/peripheral_dbg_soc_osd_timestamp.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/tracesample/peripheral_dbg_soc_osd_tracesample.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_debug_ring_expand.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_debug_ring.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_demux.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_gateway_demux.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_gateway_mux.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_gateway.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_mux_rr.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_mux.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/ctm/common/peripheral_dbg_soc_osd_ctm.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/ctm/msp430/peripheral_dbg_soc_osd_ctm_mmsp430.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/dem_uart/peripheral_dbg_soc_osd_dem_uart_16550.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/dem_uart/peripheral_dbg_soc_osd_dem_uart.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/dem_uart/peripheral_dbg_soc_osd_dem_uart_bb.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/him/peripheral_dbg_soc_osd_him.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/mam/common/peripheral_dbg_soc_osd_mam.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/mam/bb/peripheral_dbg_soc_mam_adapter_bb.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/mam/bb/peripheral_dbg_soc_osd_mam_if_bb.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/mam/bb/peripheral_dbg_soc_osd_mam_bb.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/scm/peripheral_dbg_soc_osd_scm.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/stm/common/peripheral_dbg_soc_osd_stm.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/stm/msp430/mmsp430/peripheral_dbg_soc_osd_stm_mmsp430.sv
../../../../../../../peripheral/dbg/rtl/soc/verilog/code/peripheral/top/peripheral_dbg_soc_interface.sv

../../../../../../../peripheral/dma/rtl/verilog/code/core/peripheral_dma_initiator_nocreq.sv
../../../../../../../peripheral/dma/rtl/verilog/code/core/peripheral_dma_packet_buffer.sv
../../../../../../../peripheral/dma/rtl/verilog/code/core/peripheral_dma_request_table.sv
../../../../../../../peripheral/dma/rtl/verilog/code/peripheral/bb/peripheral_dma_initiator_nocres_bb.sv
../../../../../../../peripheral/dma/rtl/verilog/code/peripheral/bb/peripheral_dma_initiator_req_bb.sv
../../../../../../../peripheral/dma/rtl/verilog/code/peripheral/bb/peripheral_dma_initiator_bb.sv
../../../../../../../peripheral/dma/rtl/verilog/code/peripheral/bb/peripheral_dma_interface_bb.sv
../../../../../../../peripheral/dma/rtl/verilog/code/peripheral/bb/peripheral_dma_target_bb.sv
../../../../../../../peripheral/dma/rtl/verilog/code/peripheral/bb/peripheral_dma_top_bb.sv

../../../../../../../peripheral/mpi/rtl/verilog/code/core/peripheral_mpi_buffer.sv
../../../../../../../peripheral/mpi/rtl/verilog/code/core/peripheral_mpi_buffer_endpoint.sv
../../../../../../../peripheral/mpi/rtl/verilog/code/peripheral/bb/peripheral_mpi_bb.sv

../../../../../../../peripheral/noc/rtl/verilog/code/core/main/peripheral_arbiter_rr.sv
../../../../../../../peripheral/noc/rtl/verilog/code/core/main/peripheral_noc_buffer.sv
../../../../../../../peripheral/noc/rtl/verilog/code/core/main/peripheral_noc_demux.sv
../../../../../../../peripheral/noc/rtl/verilog/code/core/main/peripheral_noc_mux.sv
../../../../../../../peripheral/noc/rtl/verilog/code/core/main/peripheral_noc_vchannel_mux.sv
../../../../../../../peripheral/noc/rtl/verilog/code/core/router/peripheral_noc_router_input.sv
../../../../../../../peripheral/noc/rtl/verilog/code/core/router/peripheral_noc_router_lookup_slice.sv
../../../../../../../peripheral/noc/rtl/verilog/code/core/router/peripheral_noc_router_lookup.sv
../../../../../../../peripheral/noc/rtl/verilog/code/core/router/peripheral_noc_router_output.sv
../../../../../../../peripheral/noc/rtl/verilog/code/core/router/peripheral_noc_router.sv

../../../../../../../pu/rtl/verilog/core/fuse/pu_msp430_and_gate.sv
../../../../../../../pu/rtl/verilog/core/fuse/pu_msp430_clock_gate.sv
../../../../../../../pu/rtl/verilog/core/fuse/pu_msp430_clock_mux.sv
../../../../../../../pu/rtl/verilog/core/fuse/pu_msp430_scan_mux.sv
../../../../../../../pu/rtl/verilog/core/fuse/pu_msp430_sync_cell.sv
../../../../../../../pu/rtl/verilog/core/fuse/pu_msp430_sync_reset.sv
../../../../../../../pu/rtl/verilog/core/fuse/pu_msp430_wakeup_cell.sv
../../../../../../../pu/rtl/verilog/core/main/pu_msp430_bcm.sv
../../../../../../../pu/rtl/verilog/peripheral/pu_msp430_dac.sv
../../../../../../../pu/rtl/verilog/debug/pu_msp430_dbg.sv
../../../../../../../pu/rtl/verilog/core/execute/pu_msp430_execution.sv
../../../../../../../pu/rtl/verilog/core/decode/pu_msp430_frontend.sv
../../../../../../../pu/rtl/verilog/peripheral/pu_msp430_gpio.sv
../../../../../../../pu/rtl/verilog/core/memory/pu_msp430_memory.sv
../../../../../../../pu/rtl/verilog/core/execute/pu_msp430_multiplier.sv
../../../../../../../pu/rtl/verilog/core/main/pu_msp430_sfr.sv
../../../../../../../pu/rtl/verilog/peripheral/pu_msp430_ta.sv
../../../../../../../pu/rtl/verilog/peripheral/pu_msp430_template08.sv
../../../../../../../pu/rtl/verilog/peripheral/pu_msp430_template16.sv
../../../../../../../pu/rtl/verilog/peripheral/pu_msp430_uart.sv
../../../../../../../pu/rtl/verilog/peripheral/pu_msp430_watchdog.sv
../../../../../../../pu/rtl/verilog/core/execute/pu_msp430_alu.sv
../../../../../../../pu/rtl/verilog/debug/pu_msp430_dbg_hwbrk.sv
../../../../../../../pu/rtl/verilog/debug/pu_msp430_dbg_i2c.sv
../../../../../../../pu/rtl/verilog/debug/pu_msp430_dbg_uart.sv
../../../../../../../pu/rtl/verilog/core/execute/pu_msp430_register_file.sv
../../../../../../../pu/rtl/verilog/pu/pu_msp430_core.sv
../../../../../../../pu/rtl/verilog/pu/pu_msp430_pu0.sv
../../../../../../../pu/rtl/verilog/pu/pu_msp430_pu1.sv
../../../../../../../pu/rtl/verilog/soc/pu_msp430_io_cell.sv
../../../../../../../pu/rtl/verilog/soc/pu_msp430_soc.sv

../../../../../../../rtl/verilog/soc/adapter/soc_network_adapter_configuration.sv
../../../../../../../rtl/verilog/soc/adapter/soc_network_adapter_ct.sv
../../../../../../../rtl/verilog/soc/bootrom/soc_bootrom.sv
../../../../../../../rtl/verilog/soc/interconnection/bus/soc_b3_bb.sv
../../../../../../../rtl/verilog/soc/interconnection/decode/soc_decode_bb.sv
../../../../../../../rtl/verilog/soc/interconnection/mux/soc_mux_bb.sv
../../../../../../../rtl/verilog/soc/main/soc_msp430_tile.sv
../../../../../../../rtl/verilog/soc/spram/soc_sram_sp_implemented_plain.sv
../../../../../../../rtl/verilog/soc/spram/soc_sram_sp.sv
../../../../../../../rtl/verilog/soc/spram/soc_sram_sp_bb.sv
../../../../../../../rtl/verilog/soc/spram/soc_bb2sram.sv

../../../../../../../verification/tasks/library/verilog/optimsoc/main/soc_msp430_testbench.sv

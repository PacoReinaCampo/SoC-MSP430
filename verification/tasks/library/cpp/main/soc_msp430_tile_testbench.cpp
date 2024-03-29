#include "Vsoc_msp430_tile_testbench__Syms.h"
#include "Vsoc_msp430_tile_testbench__Dpi.h"

#include <VerilatedToplevel.h>
#include <VerilatedControl.h>

#include <ctime>
#include <cstdlib>

using namespace simutilVerilator;

VERILATED_TOPLEVEL(soc_msp430_tile_testbench,clk, rst)

int main(int argc, char *argv[])
{
    soc_msp430_tile_testbench ct("TOP");

    VerilatedControl &simctrl = VerilatedControl::instance();
    simctrl.init(ct, argc, argv);

    simctrl.addMemory("TOP.soc_msp430_tile_testbench.u_compute_tile.gen_sram.u_ram.sp_ram.gen_soc_sram_sp_impl.u_impl");
    simctrl.setMemoryFuncs(do_readmemh, do_readmemh_file);
    simctrl.run();

    return 0;
}

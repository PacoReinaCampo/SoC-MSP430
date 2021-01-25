#!/bin/bash

###############################################################################
#                            Parameter Check                                  #
###############################################################################
EXPECTED_ARGS=1
if [ $# -ne $EXPECTED_ARGS ]; then
    echo "ERROR    : wrong number of arguments"
    echo "USAGE    : msp430sim <test name>"
    echo "Example  : msp430sim leds"
    echo ""
    echo "In order to switch the HDL Simulator, the OMSP_SIMULATOR environment"
    echo "variable can be set to the following values:"
    echo ""
    echo "                  - iverilog  : Icarus Verilog  (default)"
    echo "                  - msim      : ModelSim"
    echo "                  - xsim      : Xilinx Simulator"
    echo ""
    exit 1
fi


###############################################################################
#                     Check if the required files exist                       #
###############################################################################
softdir=../../../../../software/baremetal/$1;
elffile=../../../../../software/baremetal/$1/$1.elf;
verfile=../../../../../bench/verilog/cases/$1.sv;
if [ $OMSP_SIMULATOR == "msim" ]; then
    submit_verilog=../src/submit.verilog.f;
    submit_vhdl=../src/submit.vhdl.f;
fi
if [ $OMSP_SIMULATOR == "xsim" ]; then
    submit_verilog=../src/submit.verilog.prj;
    submit_vhdl=../src/submit.vhdl.prj;
fi
incfile=../../../../../rtl/verilog/pkg/msp430_defines.sv;

if [ ! -e $softdir ]; then
    echo "Software directory doesn't exist: $softdir"
    exit 1
fi
if [ ! -e $verfile ]; then
    echo "Verilog stimulus file $verfile doesn't exist: $verfile"
    exit 1
fi
if [ ! -e $submit_verilog ]; then
    echo "Verilog submit file $submit doesn't exist: $submit_verilog"
    exit 1
fi
if [ ! -e $submit_vhdl ]; then
    echo "VHDL submit file $submit doesn't exist: $submit_vhdl"
    exit 1
fi


###############################################################################
#                               Cleanup                                       #
###############################################################################
echo "Cleanup..."
rm -rf *.vcd
rm -rf *.vpd
rm -rf *.trn
rm -rf *.dsn
rm -rf pmem.*
rm -rf stimulus.sv


###############################################################################
#                              Run simulation                                 #
###############################################################################
echo " ======================================================="
echo "| Start simulation:             $1"
echo " ======================================================="

# Make C program
cd $softdir
make clean
make
cd ../../../sim/mixed/baremetal/multi/run/

# Create links
if [ `uname -o` = "Cygwin" ]
then
    cp $elffile pmem.elf
    cp $verfile stimulus.sv
else
    ln -s $elffile pmem.elf
    ln -s $verfile stimulus.sv
fi

# Make local copy of the openMSP403 configuration file
# and prepare it for MSPGCC preprocessing
cp  $incfile  ./pmem.h
sed -i 's/`ifdef/#ifdef/g'   ./pmem.h
sed -i 's/`else/#else/g'     ./pmem.h
sed -i 's/`endif/#endif/g'   ./pmem.h
sed -i 's/`define/#define/g' ./pmem.h
sed -i 's/`//g'              ./pmem.h
sed -i "s/'//g"              ./pmem.h

# Use MSPGCC preprocessor to extract the Program, Data
# and Peripheral memory sizes
msp430-gcc -E -P -x c ../bin/omsp_config.sh > pmem.sh

# Source the extracted configuration file
source pmem.sh

# Create IHEX file from ELF
echo "Convert ELF file to IHEX format..."
msp430-objcopy -O ihex  pmem.elf pmem.ihex

# Generate Program memory file
echo "Convert IHEX file to Verilog MEMH format..."
../bin/ihex2mem.tcl -ihex pmem.ihex -out pmem.mem -mem_size $pmemsize

# Start verilog simulation
echo "Start Verilog simulation..."
../bin/rtlsim.sh stimulus.sv pmem.mem $submit_verilog $submit_vhdl

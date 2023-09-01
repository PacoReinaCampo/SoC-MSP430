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
softdir=../../../../../../../software/procedures/$1;
elffile=../../../../../../../software/procedures/$1/$1.elf;
verfile=../../../../../../../bench/verilog/cases/$1.sv;
if [ $OMSP_SIMULATOR == "iverilog" ]; then
    submit=../src/submit.f;
fi
if [ $OMSP_SIMULATOR == "msim" ]; then
    submit=../src/submit.f;
fi
if [ $OMSP_SIMULATOR == "xsim" ]; then
    submit=../src/submit.prj;
fi
incfile=../../../../../../../rtl/verilog/pkg/main/pu_msp430_defines.sv;

if [ ! -e $softdir ]; then
    echo "Software directory doesn't exist: $softdir"
    exit 1
fi
if [ ! -e $verfile ]; then
    echo "Verilog stimulus file $verfile doesn't exist: $verfile"
    exit 1
fi
if [ ! -e $submit ]; then
    echo "Verilog submit file $submit doesn't exist: $submit"
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
cd ../../../sim/verilog/verification/procedures/soc/multi/run/

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
msp430-objcopy -O ihex pmem.elf pmem.ihex

# Generate Program memory file
echo "Convert IHEX file to Verilog MEMH format..."
../bin/ihex2mem.tcl -ihex pmem.ihex -out pmem.mem -mem_size $pmemsize

# Start verilog simulation
echo "Start Verilog simulation..."
../bin/rtlsim.sh stimulus.sv pmem.mem $submit

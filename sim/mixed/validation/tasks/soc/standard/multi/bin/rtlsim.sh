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
EXPECTED_ARGS=4
if [ $# -ne $EXPECTED_ARGS ]; then
    echo "ERROR    : wrong number of arguments"
    echo "USAGE    : rtlsim.sh <verilog stimulus file> <memory file> <submit file>"
    echo "Example  : rtlsim.sh ./stimulus.v            pmem.mem      ../src/submit.f"
    echo "OMSP_SIMULATOR env keeps simulator name iverilog/cver/verilog/ncverilog/msim/vcs"
    exit 1
fi


###############################################################################
#                     Check if the required files exist                       #
###############################################################################

if [ ! -e $1 ]; then
    echo "Verilog stimulus file $1 doesn't exist"
    exit 1
fi
if [ ! -e $2 ]; then
    echo "Memory file $2 doesn't exist"
    exit 1
fi
if [ ! -e $3 ]; then
    echo "Verilog submit file $3 doesn't exist"
    exit 1
fi
if [ ! -e $4 ]; then
    echo "VHDL submit file $4 doesn't exist"
    exit 1
fi


###############################################################################
#                         Start verilog simulation                            #
###############################################################################

if [ "${OMSP_SIMULATOR:-iverilog}" = iverilog ]; then
    
    rm -rf simv
    
    NODUMP=${OMSP_NODUMP-0}
    if [ $NODUMP -eq 1 ]; then
        iverilog -o simv -c $5 -D NODUMP
    else
        iverilog -o simv -c $5
    fi
    
    if [ `uname -o` = "Cygwin" ]; then
        vvp.exe ./simv
    else
        ./simv
    fi
    
else
    
    NODUMP=${OMSP_NODUMP-0}
    if [ $NODUMP -eq 1 ]; then
        vargs="+define+NODUMP"
    else
        vargs=""
    fi
    
    case $OMSP_SIMULATOR in
        msim* )
            # Modelsim
            if [ -d work ]; then  vdel -all; fi
            vlib work
            vcom -2008 -f $4
        exec vlog -sv +acc=prn -f $3 $vargs -timescale "1ns / 100ps" -R -c -do "run -all";;
        xsim* )
            # Xilinx Simulator
            rm -rf xsim.dir
            xvhdl -2008 -prj $4
            xvlog -i ../../../../../../../../rtl/verilog/pkg/standard -prj $3
            xelab soc_msp430_testbench
        exec xsim -R soc_msp430_testbench;;
    esac
    
    echo "Running: $OMSP_SIMULATOR -f $5 $vargs"
    exec $OMSP_SIMULATOR -f $5 $vargs
fi

#!/bin/bash

###############################################################################
#                            Parameter Check                                  #
###############################################################################
EXPECTED_ARGS=3
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


###############################################################################
#                         Start verilog simulation                            #
###############################################################################

if [ "${OMSP_SIMULATOR:-iverilog}" = iverilog ]; then

    rm -rf simv
    
    NODUMP=${OMSP_NODUMP-0}
    if [ $NODUMP -eq 1 ]
      then
        iverilog -o simv -c $3 -D NODUMP
      else
        iverilog -o simv -c $3
    fi
    
    if [ `uname -o` = "Cygwin" ]
      then
	    vvp.exe ./simv
      else
        ./simv
    fi

else

    NODUMP=${OMSP_NODUMP-0}
    if [ $NODUMP -eq 1 ] ; then
       vargs="+define+NODUMP"
    else
       vargs=""
    fi

   case $OMSP_SIMULATOR in 
    cver* ) 
       vargs="$vargs +define+VXL +define+CVER" ;;
    verilog* )
       vargs="$vargs +define+VXL" ;;
    ncverilog* )
       rm -rf INCA_libs
       vargs="$vargs +access+r +nclicq +ncinput+../bin/cov_ncverilog.tcl -covdut openMSP430 -covfile ../bin/cov_ncverilog.ccf -coverage all +define+TRN_FILE" ;;
    vcs* )
       rm -rf csrc simv*
       vargs="$vargs -R -debug_pp +vcs+lic+wait +v2k +define+VPD_FILE" ;;
    msim* )
       # Modelsim
       if [ -d work ]; then  vdel -all; fi
       vlib work
       exec vlog -sv +acc=prn -f $3 $vargs -R -c -do "run -all" ;;
    isim )
       # Xilinx simulator
       rm -rf fuse* isim*
       fuse msp430_testbench glbl -mt off -v 1 -prj $3 -o isim.exe -i ../../../../rtl/verilog/pkg/
       echo "run all" > isim.tcl
       ./isim.exe -tclbatch isim.tcl
       exit
   esac
   
   echo "Running: $OMSP_SIMULATOR -f $3 $vargs"
   exec $OMSP_SIMULATOR -f $3 $vargs
fi

@echo off
call ../../../../settings64_vivado.bat

xvlog -prj soc.prj \
-i ../../../../pu/rtl/verilog/pkg \
-i ../../../../rtl/verilog/soc/bootrom \
-i ../../../../dma/rtl/verilog/bb/pkg
xelab soc_msp430_testbench
xsim -R soc_msp430_testbench
pause

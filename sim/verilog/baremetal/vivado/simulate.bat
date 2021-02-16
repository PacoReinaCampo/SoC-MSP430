@echo off
call ../../../../settings64_vivado.bat

xvlog -prj soc.prj \
-i ../../../../pu/rtl/verilog/pkg \
-i ../../../../rtl/verilog/soc/bootrom \
-i ../../../../dma/rtl/verilog/wb/pkg
xelab or1k_tile
xsim -R or1k_tile
pause

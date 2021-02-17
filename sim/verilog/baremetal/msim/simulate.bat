@echo off
call ../../../../settings64_msim.bat

vlib work
vlog -sv -f soc.vc
vsim -c -do run.do work.soc_msp430_testbench
pause

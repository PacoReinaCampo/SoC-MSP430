all: build

build:
	@if [ ! -e work ]; then vlib work; fi
	@vcom -2008 -f msp430.vc
	vsim -c -do run.do work.MSP430_TESTBENCH

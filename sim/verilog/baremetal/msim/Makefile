all: build simulate

build:
	if [ ! -e work ]; then vlib work; fi
	vlog -sv -f soc.vc

simulate:
	vsim -c -do run.do work.soc_msp430_testbench

clean:
	rm -rf work transcript

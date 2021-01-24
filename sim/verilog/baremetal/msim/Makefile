all: build simulate

build:
	if [ ! -e work ]; then vlib work; fi
	vlog -sv -f soc.vc

simulate:
	vsim -c -do run.do work.msp430_tile_testbench

clean:
	rm -rf work transcript stdout.*

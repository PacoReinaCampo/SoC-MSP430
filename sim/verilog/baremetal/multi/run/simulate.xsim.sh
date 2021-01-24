#!/bin/bash
export PATH=$PATH:/opt/Xilinx/Vivado/2020.2/bin/

# Enable/Disable waveform dumping
OMSP_NODUMP=0
export OMSP_NODUMP

# Choose simulator:
#                   - iverilog  : Icarus Verilog  (default)
#                   - msim      : ModelSim
#                   - xsim      : Xilinx Simulator
OMSP_SIMULATOR=xsim
export OMSP_SIMULATOR

../bin/msp430sim.sh leds

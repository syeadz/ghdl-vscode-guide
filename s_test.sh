#!/bin/bash
# This script will test a single VHDL file given as an argument
# and store the waveform in a folder
# Note that you do not need to include the file extension
# Also it will build the file first

file=$1
set -x
# Directory to store waveform files
dir=wf

# First build the file
./s_build.sh $file

# Create waveform folder if not exist
mkdir -p $dir

# Create testbench file name
file_tb="${file}_tb"  # Use curly braces for variable interpolation

# Build testbench file
ghdl -a "${file_tb}.vhd"
# Compile and elaborate the testbench
ghdl -e "${file_tb}"
# Run simulation
ghdl -r "${file_tb}" --vcd="${dir}/${file}.vcd"

# Remove the testbench file
# Sometimes not created, uncomment if needed
# rm $file_tb
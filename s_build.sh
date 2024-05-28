#!/bin/bash
# This script will build a single VHDL file given as an argument
# Note that you do not need to include the file extension

file=$1
set -x

ghdl -a --ieee=synopsys -fexplicit $file.vhd 
#!/bin/bash
# This script will build all the VHDL files in the current directory
# Note that you might need to run it twice to due dependencies

for i in *.vhd;
do
  ./s_build.sh ${i::-4}
done

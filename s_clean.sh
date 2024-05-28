#!/bin/bash
# This script will clean up the directory of all object files and compiled files

file=$1
set -x

rm *.o
rm *.cf
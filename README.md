# GHDL VSCode Guide

This quick-start guide is designed to help you set up and use VSCode with bash scripts to create and test VHDL design components efficiently. We'll build and test a 1-bit full adder along with its testbench. Skip to the [Quickstart](#quickstart-building-and-testing-adder1bit) section to get started quickly. Make sure to clone the repository to follow along.

After following this guide, you should be able to build and test VHDL components rapidly using Bash scripts as well as having error checking and highlighting for written VHDL code on VSCode.

**WARNING:** Some components and testbenches behave unexpectedly on Quartus and the Altera board.

## Prerequisites

- **Linux OS or WSL on Windows** (to run Bash scripts and commands)
  - Note: You might be able to do everything on Windows with PowerShell scripts and a Windows installation of GHDL and GTKWave, but this guide covers only Linux and WSL. However there is a [video](https://www.youtube.com/watch?v=H2GyAIYwZbw) on Youtube that shows how to use GHDL and GTKWave on Windows.
  - If you're using WSL, make sure to look up how to run [VSCode in WSL](https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-vscode).
- **VSCode with the TerosHDL extension**
- **GHDL and GTKWave**

### Installing GHDL and GTKWave

Run the following commands on Ubuntu to install GHDL and GTKWave:

```sh
sudo apt update && sudo apt upgrade # Update package lists
sudo apt-get install ghdl gtkwave
```

## GHDL Basics

You can skip this section if don't really care. For more information, refer to:

- [GHDL Quick Start Guide](https://ghdl-rad.readthedocs.io/en/stable/using/QuickStartGuide.html) (detailed)
- [Using GTKWave](https://lauri.võsandi.com/hdl/gtkwave.html) (summarized, also shows how to use GTKWave)

### Building

To build a design unit, run:

```sh
ghdl -a --ieee=synopsys -fexplicit <myfile.vhd>
```

Build both the design unit and its testbench separately. This command will generate a `work.cf` file that keeps track of all design units and a `.o` (object) file for your unit.

### Testing (Running the Testbench)

After building the testbench, run:

```sh
ghdl -e <myfile_tb>  # No file extension
```

This compiles and elaborates the testbench, creating an executable. To run a simulation, execute:

```sh
ghdl -r <myfile_tb> --vcd=<waveform name>.vcd
```

This runs the testbench and creates a VCD file that you can analyze using GTKWave.

## Quickstart Building and Testing adder1bit

Run the following commands in the terminal to build and test the adder1bit. You can either run the commands manually or use the provided scripts.

### Manually

```sh
# Build adder1bit
ghdl -a --ieee=synopsys -fexplicit adder1bit.vhd

# Build adder1bit's testbench
ghdl -a adder1bit_tb.vhd

# Compile and elaborate the testbench
ghdl -e adder1bit_tb

# Run simulation (ensure the folder exists or omit the folder path)
ghdl -r adder1bit_tb --vcd="wf/adder1bit.vcd"
```

### With Scripts (Recommended)

Refer to the "Information on Scripts" section for details on what each script does. **Make sure that the testbench is named `<component name>_tb.vhd`**.

```sh
# Test script automatically builds both adder1bit.vhd and adder1bit_tb.vhd. Also creates the waveform folder.
./s_test.sh adder1bit  # Runs simulation and creates VCD file
# Now you can use GTKWave to analyze the component

# SPECIAL NOTE:
# If there is no testbench or you don't need to test the file, just use the build script
./s_build.sh adder1bit  # Builds the file without running the testbench
```

### Using GTKWave to Analyze adder1bit

Refer to [Using GTKWave](https://lauri.võsandi.com/hdl/gtkwave.html) for screenshots and a quick guide.

- Run `gtkwave wf/adder1bit.vcd` to open the waveform in GTKWave.
- Click on the component name in the top left to see all its signals. Use the dropdown to view nested components.
- Select all signals, then click "Append" to add them to the graph.
- In the graph window, press `Ctrl + 0` to zoom out and view all signal changes.
- Click and drag on the graph to see signal values in the new signal window.

#### Special Tips

- If you modify the component or its testbench while the VCD file is open, rebuild and rerun the test, then reload (or press `Ctrl + R`) in GTKWave to refresh the VCD file.
- Change the data format of signals (default is hex) by right-clicking a highlighted signal and selecting a different format, such as binary or decimal. This is useful for testing arithmetic operations or shifts.

## Information on Scripts

### s_build_all.sh

Usage: `./s_build_all.sh`

This script builds all `.vhd` files in the current directory. May need to run it multiple times if some files depend on others.

### s_build.sh

Usage: `./s_build.sh <file name without extension>`

This script builds a single `.vhd` file.

### s_test.sh

Usage: `./s_test.sh <file name without extension>`

This script builds a single `.vhd` file and its testbench, runs the simulation, and creates a VCD file. **Make sure that the testbench is named `<component name>_tb.vhd`**. Note there is a commented line in the script to automatically delete the testbench executable after running the simulation. On certain systems there is no executable generated, but on others it is. Uncomment the line if you want less clutter. Also creates the waveform folder if it doesn't exist.

### s_clean.sh

Usage: `./s_clean.sh`

This script removes all `.o` files and the `work.cf` file. Use it to clean up build files.

## Bonus Features

- There is .vscode folder with settings.json file that makes it so that .o files are not shown in the file explorer. This is to reduce clutter. You can remove the settings.json file if you want to see the .o files.
- There is .gitignore file that ignores .o files and the work.cf file. You can remove the .gitignore file if you want to track these files. It also ignores the waveform folder, if you don't want to track the VCD files.

## Possible Issues

- With WSL on Windows 10, you might face issues running GTKWave as it is a graphical application. Configure an X server to run it.

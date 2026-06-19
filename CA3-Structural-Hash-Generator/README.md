# CA3 - Structural Hash Generator Using Basic FPGA Cells

This project implements a simplified hash generator using structural Verilog and basic programmable FPGA cells.

## Overview

This project is a simplified version of the RTL hash generator from CA1. The data width is reduced from 32 bits to 8 bits, and the rotate module is replaced with a multiplier.

The main goal is to manually implement the design using only the provided basic FPGA cells and understand how Verilog designs can be built structurally at the cell level.

## Features

- Simplified hash generator implementation
- 8-bit datapath design
- Structural Verilog implementation
- Manual implementation using basic FPGA cells
- Datapath and Controller design
- FSM-based control logic
- Cell-level design and resource analysis
- Simulation-based verification

## Allowed Basic Cells

The design is implemented using only the provided cells:

- `C1`
- `C2`
- `S1`
- `S2`

No built-in Verilog logical operators or primitive gates are used inside the custom modules.

## Changes Compared to CA1

- Data width is reduced from 32 bits to 8 bits.
- Initial values are changed to 8-bit values.
- The rotate module is replaced with a multiplier.
- The design is implemented structurally using basic cells.
- The number of input messages is reduced.
- Resource usage is analyzed by counting the used cells.

## Technologies Used

- Verilog HDL
- Structural Design
- FPGA Cell-Level Design
- FSM Design
- Datapath and Controller Design
- ModelSim Simulation

## System Components

The project includes:

- Top-level module
- Datapath
- Controller
- Basic cell modules
- Multiplier module
- Register and mux structures
- Testbench
- Cell count files/tools

## Suggested Project Structure

```text
.
├── src/
│   ├── top.v
│   ├── datapath.v
│   ├── controller.v
│   ├── multiplier.v
│   ├── basic_cells/
│   │   ├── c1.v
│   │   ├── c2.v
│   │   ├── s1.v
│   │   └── s2.v
│   └── modules/
├── tb/
│   └── testbench.v
├── tools/
│   └── cell_counter/
├── number.txt
└── README.md
```

## Simulation

To run the simulation:

```bash
vlog src/**/*.v tb/testbench.v
vsim work.testbench
run -all
```

If cell counting tools are used, make sure the required executable files and `number.txt` are placed correctly before running the simulation.

## What I Learned

- Implementing digital circuits structurally
- Building complex hardware modules from small programmable cells
- Designing with hardware resource limitations
- Simplifying datapath and controller logic
- Understanding FPGA cell-level implementation
- Analyzing resource usage in digital designs

## Course

Computer-Aided Design of Digital Systems  
Fall 1404

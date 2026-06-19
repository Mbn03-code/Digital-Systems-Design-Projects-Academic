# CA5 - Scheduling Algorithms and Verilog Code Generator

This project implements scheduling algorithms for Data Flow Graphs and generates Verilog code for the corresponding datapath and controller.

## Overview

The program receives a mathematical expression and scheduling constraints as input, converts the expression into a Data Flow Graph, schedules the operations, and generates Verilog code for the final hardware design.

The project focuses on high-level synthesis concepts such as scheduling, resource allocation, datapath generation, controller generation, and simulation-ready Verilog output.

## Features

- Mathematical expression parsing
- Data Flow Graph generation
- Resource-constrained scheduling
- Latency-constrained scheduling
- Scheduled DFG visualization
- Verilog datapath generation
- Verilog controller generation
- Top-level Verilog module generation
- JSON-based input and output
- ModelSim-compatible generated Verilog code

## Scheduling Algorithms

The project implements two scheduling approaches:

- Resource-Constrained Minimum-Latency Scheduling
- Latency-Constrained Minimum-Resource Scheduling

## Supported Operations

The system supports three main operation groups:

- `ALU`: addition and subtraction
- `MUL`: multiplication and division
- `LOG`: logical AND and OR

## Technologies Used

- Python
- Verilog HDL
- JSON
- Data Flow Graph
- Scheduling Algorithms
- High-Level Synthesis Concepts
- ModelSim Simulation

## Suggested Project Structure

```text
.
├── main.py
├── scheduler.py
├── verilog_generator.py
├── dfg_builder.py
├── graph_visualizer.py
├── samples/
│   └── sample1/
│       └── input.json
├── output/
│   ├── scheduled_info.json
│   ├── datapath.v
│   ├── controller.v
│   └── top.v
└── README.md
```

## Input

The program receives a folder path that contains an `input.json` file.

Example:

```bash
python main.py ./samples/sample1/
```

The input file includes:

- Mathematical expression
- Scheduling algorithm type
- Resource constraints
- Latency constraints

## Output

After running the program, the following files are generated:

- Initial Data Flow Graph image
- Scheduled Data Flow Graph image
- Scheduling result JSON file
- Verilog Datapath module
- Verilog Controller module
- Verilog Top module

## Generated Verilog Design

The generated hardware contains:

- `clk` input
- `rst` input
- `start` input
- input variables from the expression
- `result` output
- `done` output

The controller includes the required states based on the scheduling result, and the datapath performs the scheduled operations.

## Running the Program

```bash
python main.py ./samples/sample1/
```

## Simulation

After generating Verilog files, compile them in ModelSim:

```bash
vlog output/*.v
vsim work.top
run -all
```

## What I Learned

- Converting mathematical expressions into Data Flow Graphs
- Implementing scheduling algorithms
- Understanding resource and latency trade-offs
- Generating Verilog code automatically
- Designing datapath and controller modules from scheduled operations
- Preparing generated hardware for simulation

## Course

Computer-Aided Design of Digital Systems  
Fall 1404

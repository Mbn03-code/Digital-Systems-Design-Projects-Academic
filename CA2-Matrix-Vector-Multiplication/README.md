# CA2 - Matrix-Vector Multiplication Hardware Design

This project implements a hardware design for matrix-vector multiplication as part of the **Computer-Aided Design of Digital Systems** course.

## Overview

The system reads input data from memory, performs matrix-vector multiplication using processing elements, and writes the computed results back to output memory.

The project focuses on designing a **Controller** and **Datapath** for a multi-cycle hardware operation and verifying the circuit behavior using waveform simulation.

## Features

- Matrix-vector multiplication hardware implementation
- Memory-based input and output handling
- Datapath and Controller separation
- Multi-state FSM controller
- Processing Element-based computation
- Row-by-row execution flow
- Output write-back mechanism
- Simulation and waveform-based debugging

## Controller States

The controller includes the following main states:

- `Idle`
- `LoadA`
- `LoadB0`
- `LoadB1`
- `RunBits`
- `WriteOut`
- `NextRow`
- `Done`

## System Components

The design includes:

- Top-level module
- Controller
- Datapath
- Processing Elements
- Address generation logic
- Memory read/write control
- Testbench
- Simulation waveform verification

## Technologies Used

- Verilog HDL
- RTL Design
- FSM Design
- Datapath and Controller Design
- Digital System Design
- ModelSim Simulation

## How It Works

1. The system starts in the `Idle` state.
2. After receiving the `start` signal, the controller begins loading input data.
3. Matrix row values are loaded into internal registers.
4. Vector values are loaded in two steps using `LoadB0` and `LoadB1`.
5. Processing elements perform the required computations.
6. The result of each row is written to output memory.
7. The controller moves to the next row.
8. After all rows are processed, the `done` signal is activated.

## Suggested Project Structure

```text
.
├── src/
│   ├── top.v
│   ├── controller.v
│   ├── datapath.v
│   ├── processing_element.v
│   └── memory_interface.v
├── tb/
│   └── testbench.v
├── docs/
│   └── report.pdf
└── README.md
```

## Simulation

To simulate the design:

```bash
vlog src/*.v tb/testbench.v
vsim work.testbench
run -all
```

The correctness of the design can be checked using waveform signals such as:

- `clk`
- `rst`
- `start`
- `done`
- `address`
- `write`
- controller state signals
- datapath output signals

## What I Learned

- Designing a multi-state controller
- Managing memory read and write operations
- Building a datapath for arithmetic computation
- Using processing elements for hardware acceleration
- Debugging RTL designs using simulation waveforms
- Coordinating control signals with datapath behavior

## Course

Computer-Aided Design of Digital Systems  
Fall 1404

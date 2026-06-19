# CA1 - RTL Hash Generator

This project implements a hardware-based hash generator at the RTL level for the **Computer-Aided Design of Digital Systems** course.

## Overview

The system receives a 128-bit input message, divides it into four 32-bit words, and processes the data through a 64-round hashing algorithm to generate a 128-bit hash output.

The main focus of this project is designing the system using separate **Datapath** and **Controller** units, implementing handshaking signals, and verifying the hardware behavior through simulation.

## Features

- 128-bit input message processing
- 128-bit hash output generation
- 64-round iterative hashing algorithm
- Pseudo-random word selection module
- Separate Datapath and Controller design
- Moore FSM-based controller
- Handshaking using `start`, `done`, `rnd_start`, and `rnd_done`
- Modular RTL implementation in Verilog
- Simulation and verification using testbenches

## System Components

The project consists of the following main parts:

- Pseudo-random number generator
- Hash computation unit
- Datapath
- Controller
- ROM for constant values
- Rotate module
- Top-level integration module
- Testbench for verification

## Technologies Used

- Verilog HDL
- RTL Design
- Finite State Machine
- Datapath and Controller Design
- Digital System Design
- ModelSim / Verilog Simulator

## How It Works

1. The input message is loaded into internal registers.
2. The 128-bit message is divided into four 32-bit words.
3. A pseudo-random generator produces a 2-bit index for selecting one of the message words.
4. The selected word is combined with the current hash state.
5. The algorithm runs for 64 iterations.
6. The final values of registers `A`, `B`, `C`, and `D` are concatenated to generate the final 128-bit hash output.

## Suggested Project Structure

```text
.
├── src/
│   ├── top.v
│   ├── hash_datapath.v
│   ├── hash_controller.v
│   ├── random_generator.v
│   ├── rotate.v
│   └── rom.v
├── tb/
│   └── testbench.v
├── memory/
│   └── constant.mem
└── README.md
```

## Simulation

To run the simulation, compile the Verilog files and run the testbench:

```bash
vlog src/*.v tb/testbench.v
vsim work.testbench
run -all
```

## What I Learned

- Designing RTL hardware modules in Verilog
- Separating Datapath and Controller logic
- Implementing Moore finite state machines
- Using handshaking signals between modules
- Working with registers, counters, ROM, and iterative hardware algorithms
- Verifying digital circuits using simulation

## Course

Computer-Aided Design of Digital Systems  
Fall 1404

# CA4 - Hash Generator Synthesis and Actel Cell Mapping

This project synthesizes a simplified hash generator using Yosys and maps the synthesized netlist to Actel-style basic cells.

## Overview

This project is based on the simplified hash generator from previous assignments. The design is synthesized using Yosys, converted into a LUT-based Verilog netlist, and then mapped to Actel-compatible cells using a custom Python script.

The main goal is to compare automatic synthesis results with the manually implemented structural design from CA3.

## Features

- Simplified hash generator synthesis
- Yosys-based Verilog synthesis
- LUT-based netlist generation
- Mapping generic cells to Actel-style cells
- Python-based netlist transformation
- Cell count analysis
- Comparison with manual structural implementation

## Mapping Targets

The mapper converts the following generated cells:

- `LUT1`
- `LUT2`
- `DFF`
- `SDFF`

Into Actel-compatible cells such as:

- `C1`
- `C2`
- `S1`
- `S2`

## Technologies Used

- Verilog HDL
- Python
- Yosys
- FPGA Synthesis
- LUT Mapping
- Actel Cell Mapping
- Digital System Design

## System Components

The project includes:

- Simplified Verilog hash generator
- Yosys synthesis script
- Python LUT mapper
- Generated LUT-based Verilog netlist
- Actel-mapped Verilog output
- Simulation files
- Cell count report

## Suggested Project Structure

```text
.
├── src/
│   ├── top.v
│   ├── datapath.v
│   ├── controller.v
│   └── hash_modules.v
├── synthesis/
│   ├── lut2synth.ys
│   ├── lut2mapper.py
│   └── synthesized_output.v
├── mapped/
│   └── actel_mapped_output.v
├── tb/
│   └── testbench.v
└── README.md
```

## How It Works

1. The simplified Verilog design is prepared for synthesis.
2. Verilog files are added to the Yosys synthesis script.
3. Yosys generates a LUT-based Verilog netlist.
4. The Python mapper reads the synthesized output.
5. `LUT1`, `LUT2`, `DFF`, and `SDFF` are mapped to Actel-compatible cells.
6. The mapped design is simulated and verified.
7. The number of used cells is compared with the previous manual implementation.

## Running Synthesis

Install Yosys:

```bash
sudo apt install yosys
```

Run the synthesis script:

```bash
yosys -s lut2synth.ys
```

Run the mapper:

```bash
python lut2mapper.py <output_code_of_lut2synth.v> --cell c2 --count-cells
```

To map LUTs using `C1` instead of `C2`:

```bash
python lut2mapper.py <output_code_of_lut2synth.v> --cell c1 --count-cells
```

## Simulation

After generating the mapped Verilog file, compile and simulate it:

```bash
vlog mapped/*.v tb/testbench.v
vsim work.testbench
run -all
```

## What I Learned

- Using Yosys for Verilog synthesis
- Understanding LUT-based synthesis output
- Mapping synthesized cells to target FPGA cells
- Writing Python scripts for netlist transformation
- Comparing manual and automatic synthesis results
- Analyzing hardware resource usage

## Course

Computer-Aided Design of Digital Systems  
Fall 1404

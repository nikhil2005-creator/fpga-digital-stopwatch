# FPGA Digital Stopwatch

A digital stopwatch implemented in Verilog/SystemVerilog using Xilinx Vivado and an Artix-7 FPGA board.

## Features

- Start and stop controls
- Asynchronous reset
- Clock division for real-time timing from the board clock
- Minute and second counters
- Counter rollover at 59 seconds
- Designed for a 10-minute range (minutes 0–9)
- Testbench-based simulation

## Repository Structure

```text
fpga-digital-stopwatch/
├── README.md
├── rtl/
│   └── README.md
├── sim/
│   └── README.md
├── constraints/
│   └── README.md
└── docs/
    └── README.md
```

> **Note:** The RTL, testbench, and XDC source files will be added to their respective folders. The current project report describes both a hardware version with clock division and a faster simulation version without clock division.

## Design Overview

The hardware design divides the incoming FPGA clock to produce a slower timing signal. The stopwatch control logic uses the start input to begin counting, the stop input to pause counting, and reset to clear the time. Seconds increment up to 59, then roll over to zero while the minute counter increments. The minutes counter is 4 bits wide and the seconds counter is 6 bits wide.

## Tools

- Verilog/SystemVerilog
- Xilinx Vivado
- Artix-7 FPGA
- Icarus Verilog (optional simulation flow)

## Simulation

Use the simulation-specific RTL variant when you want to test behavior quickly without waiting for the hardware clock divider to count a full second. The exact compile command will be documented alongside the testbench once the source files are added.

## FPGA Constraints

The design report includes an XDC file for Artix-7 I/O assignments and LVCMOS33 I/O standards. Confirm the package pins against the exact FPGA board before using the constraints on hardware.

## Project Documentation

The accompanying project report contains the problem statement, block and circuit diagrams, truth table, RTL examples, testbench, XDC constraints, simulation waveform, RTL schematic, synthesis schematic, and utilization report.

## Status

Project documentation is being organized for publication. Add the original RTL and testbench files before treating the repository as a complete, reproducible implementation.

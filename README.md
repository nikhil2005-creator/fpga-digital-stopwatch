# FPGA Digital Stopwatch

A digital stopwatch written in SystemVerilog and intended for an Artix-7 FPGA, developed using Xilinx Vivado. The design supports start, stop, asynchronous reset, seconds counting, and minute rollover.

## Features

- Start and stop controls
- Active-high asynchronous reset
- Clock divider for real-time hardware operation
- Seconds counter from 0 to 59
- Minutes counter from 0 to 9 (10-minute range, then wraps to 00:00)
- Separate fast simulation model so the behavior can be explored without waiting for the hardware clock divider
- XDC constraints transcribed from the supplied project report

## Repository structure

```text
fpga-digital-stopwatch/
├── README.md
├── rtl/
│   ├── stopwatch.sv          # FPGA hardware design with clock divider
│   └── stopwatch_sim.sv      # Fast simulation model without clock divider
├── sim/
│   └── stopwatch_tb.sv       # Testbench; generates stopwatch.vcd
├── constraints/
│   └── stopwatch.xdc         # Pin and I/O-standard constraints from the report
├── docs/
│   └── implementation-notes.md
└── .gitignore
```

## Hardware design

The top-level hardware module is `STOPWATCH` in `rtl/stopwatch.sv`. The clock divider toggles `clk_div` after 50,000,000 input-clock cycles. For a 100 MHz input clock, this creates a 1 Hz rising-edge tick for the stopwatch counter. The control and counter logic increments seconds while running; at 59 seconds, seconds reset to zero and minutes increment. After minute 9, the count wraps to zero.

Inputs:
- `clk`: board clock
- `reset`: active-high asynchronous reset
- `start`: enables counting
- `stop`: pauses counting

Outputs:
- `minutes[3:0]`: minute count
- `seconds[5:0]`: second count

## Run the simulation

The simulation model intentionally omits the hardware clock divider: each rising edge of `clk` acts like a one-second tick. This makes simulation faster and is **not** the module intended for FPGA programming.

With Icarus Verilog installed, run from the repository root:

```bash
iverilog -g2012 -s stopwatch_tb -o stopwatch_sim rtl/stopwatch_sim.sv sim/stopwatch_tb.sv
vvp stopwatch_sim
```

The testbench writes `stopwatch.vcd`. Open it with GTKWave to inspect reset, start, stop, resume, and counter signals.

## Vivado / FPGA use

1. Create or open a Vivado RTL project for the exact Artix-7 device on your board.
2. Add `rtl/stopwatch.sv` as a design source and select `STOPWATCH` as the top module.
3. Add `constraints/stopwatch.xdc` as a constraints file.
4. Confirm the board's clock frequency and verify every package pin in the XDC against the exact board's master constraints file before generating a bitstream.
5. Run synthesis and implementation, then program the board.

The divider value in the supplied design assumes a 100 MHz clock. The original report does not specify the exact board model in its text, so the pin mapping must be verified before hardware use. Add a `create_clock` timing constraint that matches the actual board clock.

## Project documentation

The supplied project report includes a problem statement, block/circuit diagrams, truth table, RTL examples, testbench, XDC constraints, simulation waveform, RTL/synthesis schematics, and a utilization report.

## Notes

- The fast simulation model is for verification convenience; use the clock-divider hardware model for the FPGA.
- The XDC pin assignments are transcribed from the report and are not guaranteed to match every Artix-7 board.
- The available report documents the project's prior simulation and synthesis work; this repository's source files are being organized from that report.

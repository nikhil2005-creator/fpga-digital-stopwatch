# FPGA Digital Stopwatch

A digital stopwatch implemented in SystemVerilog using **Xilinx Vivado** and an **Artix-7 FPGA**. The design supports start, stop, asynchronous reset, seconds counting, and minute rollover.

## Features

- Start and stop controls
- Active-high asynchronous reset
- Clock divider for real-time hardware operation
- Seconds counter from 0 to 59
- Minutes counter from 0 to 9 (10-minute range, then wraps to 00:00)
- Separate fast simulation model so the counter behavior can be inspected without waiting for the hardware clock divider
- XDC constraints transcribed from the supplied project report

## Repository structure

```text
fpga-digital-stopwatch/
├── README.md
├── rtl/
│   ├── stopwatch.sv          # FPGA hardware design with clock divider
│   └── stopwatch_sim.sv      # Fast simulation model without clock divider
├── sim/
│   └── stopwatch_tb.sv       # Vivado simulation testbench
├── constraints/
│   └── stopwatch.xdc         # Pin and I/O-standard constraints from the report
└── docs/
    ├── implementation-notes.md
    └── simulation-waveform.jpg
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

## Simulation waveform

The following is the simulation waveform screenshot preserved from the original project report.

![Original stopwatch simulation waveform from Vivado](docs/simulation-waveform.jpg)

## Run the simulation in Vivado

The fast simulation model intentionally omits the hardware clock divider: each rising edge of `clk` acts like a one-second tick. This allows the controls and counters to be tested quickly. It is a simulation model, **not** the module intended for FPGA programming.

1. Open the project in Xilinx Vivado, or create a new RTL project.
2. Add `rtl/stopwatch_sim.sv` and `sim/stopwatch_tb.sv` as simulation sources.
3. Select `stopwatch_tb` as the simulation top.
4. Run **Run Simulation → Run Behavioral Simulation**.
5. Add `clk`, `reset`, `start`, `stop`, `minutes`, and `seconds` to the waveform window, then run the simulation.

To simulate the actual hardware RTL, instantiate `STOPWATCH` and allow enough simulation time for the divider to count to 50,000,000 cycles. The testbench included here is designed for the fast model so it can be explored quickly.

## Vivado / FPGA implementation

1. Create or open a Vivado RTL project for the exact Artix-7 device on your board.
2. Add `rtl/stopwatch.sv` as a design source and select `STOPWATCH` as the top module.
3. Add `constraints/stopwatch.xdc` as a constraints file.
4. Confirm the board's clock frequency and verify every package pin in the XDC against the exact board's master constraints file before generating a bitstream.
5. Run synthesis and implementation, then program the board.

The divider value in the supplied design assumes a 100 MHz clock. The original report does not specify the exact board model in its text, so the pin mapping must be verified before hardware use. Add a `create_clock` timing constraint that matches the actual board clock.

## Project documentation

The project report includes a problem statement, block/circuit diagrams, truth table, RTL examples, testbench, XDC constraints, simulation waveform, RTL/synthesis schematics, and a utilization report.

## Notes

- The hardware version with the clock divider is intended for FPGA operation; the version without clock division is intended for fast Vivado simulation.
- The XDC pin assignments are transcribed from the report and are not guaranteed to match every Artix-7 board. Verify them against the exact board before programming.
- The screenshot above is included as project evidence from the original report. The current testbench has been organized for fast simulation, but the waveform has not been regenerated from this repository in this environment.

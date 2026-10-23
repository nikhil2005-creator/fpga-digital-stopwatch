# Implementation Notes

The supplied project report describes a stopwatch targeting an Artix-7 FPGA and developed in Xilinx Vivado.

- `rtl/stopwatch.sv` is the hardware design with clock division.
- `rtl/stopwatch_sim.sv` is a faster simulation model without clock division.
- `sim/stopwatch_tb.sv` exercises reset, start, stop, resume, and reset again, and writes a VCD waveform.
- `constraints/stopwatch.xdc` contains the package-pin and LVCMOS33 constraints transcribed from the report.

The clock-divider comparison value (`49_999_999`) assumes a 100 MHz source clock. Confirm the exact board clock and pin assignments before programming an FPGA. The report does not identify the exact board model in its text, so verify the XDC against the board's official master constraints file.

# Pin assignments transcribed from the supplied project report.
# Verify these against the exact Artix-7 board before programming.

set_property IOSTANDARD LVCMOS33 [get_ports {minutes[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {minutes[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {minutes[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {minutes[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seconds[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seconds[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seconds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seconds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seconds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seconds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports start]
set_property IOSTANDARD LVCMOS33 [get_ports stop]

set_property PACKAGE_PIN L1  [get_ports {minutes[3]}]
set_property PACKAGE_PIN P1  [get_ports {minutes[2]}]
set_property PACKAGE_PIN N3  [get_ports {minutes[1]}]
set_property PACKAGE_PIN P3  [get_ports {minutes[0]}]
set_property PACKAGE_PIN W3  [get_ports {seconds[5]}]
set_property PACKAGE_PIN V3  [get_ports {seconds[4]}]
set_property PACKAGE_PIN V13 [get_ports {seconds[3]}]
set_property PACKAGE_PIN V14 [get_ports {seconds[2]}]
set_property PACKAGE_PIN U14 [get_ports {seconds[1]}]
set_property PACKAGE_PIN U15 [get_ports {seconds[0]}]
set_property PACKAGE_PIN W5  [get_ports clk]
set_property PACKAGE_PIN R2  [get_ports reset]
set_property PACKAGE_PIN T1  [get_ports start]
set_property PACKAGE_PIN U1  [get_ports stop]

# Add a create_clock constraint matching the actual board-clock frequency.

`timescale 1ns / 1ps

module stopwatch_tb;
    logic clk = 1'b0;
    logic reset = 1'b1;
    logic start = 1'b0;
    logic stop = 1'b0;
    logic [3:0] minutes;
    logic [5:0] seconds;

    // Use the simulation model so the counters advance quickly.
    STOPWATCH_WITHOUT_CLKDIV dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .stop(stop),
        .minutes(minutes),
        .seconds(seconds)
    );

    // 10 ns clock period.
    always #5 clk = ~clk;

    initial begin
        $dumpfile("stopwatch.vcd");
        $dumpvars(0, stopwatch_tb);
        $monitor("time=%0t reset=%b start=%b stop=%b minutes=%0d seconds=%0d",
                 $time, reset, start, stop, minutes, seconds);

        // Reset, start, pause, resume, then reset again.
        #40 reset = 1'b0;
        #25 start = 1'b1;
        #750;
        start = 1'b0;
        stop  = 1'b1;
        #40 start = 1'b1; stop = 1'b0;
        #40;
        reset = 1'b1;
        #30 reset = 1'b0;
        #10 start = 1'b1;
        #100;
        $finish;
    end
endmodule

// FPGA Digital Stopwatch — hardware implementation
// Based on the supplied STOPWATCH project report.
// The divider assumes a 100 MHz input clock: clk_div toggles every
// 50,000,000 input clock cycles, producing a 1 Hz rising-edge tick.

module STOPWATCH (
    input  logic       clk,
    input  logic       reset,   // Active-high asynchronous reset
    input  logic       start,
    input  logic       stop,
    output logic [3:0] minutes,
    output logic [5:0] seconds
);
    logic clk_div;
    logic [5:0] seconds_count;
    logic [3:0] minutes_count;
    logic running;
    integer count;

    localparam logic [5:0] MAX_SECONDS = 6'd59;
    localparam logic [3:0] MAX_MINUTES = 4'd9;

    // Divide the board clock to produce a 1 Hz stopwatch tick.
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count   <= 0;
            clk_div <= 1'b0;
        end else if (count == 49_999_999) begin
            clk_div <= ~clk_div;
            count   <= 0;
        end else begin
            count <= count + 1;
        end
    end

    // Stopwatch controller and minute/second counters.
    always_ff @(posedge clk_div or posedge reset) begin
        if (reset) begin
            seconds_count <= 0;
            minutes_count <= 0;
            running       <= 1'b0;
        end else begin
            if (start)
                running <= 1'b1;
            else if (stop)
                running <= 1'b0;

            if (running) begin
                if (seconds_count == MAX_SECONDS) begin
                    seconds_count <= 0;
                    if (minutes_count == MAX_MINUTES)
                        minutes_count <= 0;
                    else
                        minutes_count <= minutes_count + 1'b1;
                end else begin
                    seconds_count <= seconds_count + 1'b1;
                end
            end
        end
    end

    assign minutes = minutes_count;
    assign seconds = seconds_count;
endmodule

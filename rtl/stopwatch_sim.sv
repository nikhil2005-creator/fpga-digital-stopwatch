// Fast simulation model — omits the hardware clock divider so each rising
// edge of clk advances the stopwatch by one second. Do not use this module
// as the FPGA hardware top-level design.

module STOPWATCH_WITHOUT_CLKDIV (
    input  logic       clk,
    input  logic       reset,   // Active-high asynchronous reset
    input  logic       start,
    input  logic       stop,
    output logic [3:0] minutes,
    output logic [5:0] seconds
);
    logic [5:0] seconds_count;
    logic [3:0] minutes_count;
    logic running;

    localparam logic [5:0] MAX_SECONDS = 6'd59;
    localparam logic [3:0] MAX_MINUTES = 4'd9;

    always_ff @(posedge clk or posedge reset) begin
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

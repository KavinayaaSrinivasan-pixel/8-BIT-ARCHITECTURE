`timescale 1ns / 1ps

module ProgramCounter (
    input clk,
    input reset,
    input CO,
    input CL,
    input CE,
    input [3:0] bus_in,
    output [3:0] bus_out
);
    reg [3:0] pc;

    always @(posedge clk) begin
        if (reset)
            pc <= 4'b0000;
        else if (CL)
            pc <= bus_in;
        else if (CE)
            pc <= pc + 4'b0001;
    end

    assign bus_out = CO ? pc : 4'bz;
endmodule

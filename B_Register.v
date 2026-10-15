`timescale 1ns / 1ps

module B_Register (
    input        clk,
    input        BI,
    input  [7:0] bus_in,
    output [7:0] b_out
);
    reg [7:0] b_reg;

    always @(posedge clk) begin
        if (BI)
            b_reg <= bus_in;
    end

    assign b_out = b_reg;
endmodule

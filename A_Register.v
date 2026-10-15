`timescale 1ns / 1ps

module A_Register (
    input        clk,
    input        AI,
    input  [7:0] bus_in,
    output [7:0] a_out
);
    reg [7:0] a_reg;

    always @(posedge clk) begin
        if (AI)
            a_reg <= bus_in;
    end

    assign a_out = a_reg;
endmodule

`timescale 1ns / 1ps

module Instruction_Register (
    input        clk,
    input        reset,
    input        II,
    input  [7:0] bus_in,
    output [3:0] opcode,
    output [3:0] operand
);
    reg [7:0] ir_reg;

    always @(posedge clk) begin
        if (reset)
            ir_reg <= 8'b00000000;
        else if (II)
            ir_reg <= bus_in;
    end

    assign opcode  = ir_reg[7:4];
    assign operand = ir_reg[3:0];
endmodule

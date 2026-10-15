`timescale 1ns / 1ps

module RAM (
    input        clk,
    input        RI,
    input        RO,
    input  [3:0] MAR,
    input  [7:0] bus_in,
    output [7:0] bus_out
);
    reg [7:0] memory [0:15];

    initial begin
        // Program
        memory[0] = 8'b0001_1110; // LDA 14
        memory[1] = 8'b0010_1101; // ADD 13
        memory[2] = 8'b0011_1111; // STA 15
        memory[3] = 8'b0100_0000; // OUT
        memory[4] = 8'b1111_0000; // HLT

        // Data
        memory[13] = 8'd10;
        memory[14] = 8'd20;
        memory[15] = 8'd0;
    end

    always @(posedge clk) begin
        if (RI)
            memory[MAR] <= bus_in;
    end

    assign bus_out = RO ? memory[MAR] : 8'bz;
endmodule

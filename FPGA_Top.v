`timescale 1ns / 1ps

module FPGA_Top (
    input clk,
    input reset,
    input sub_switch,
    output [7:0] led
);
    CPU_Top CPU (
        .clk(clk),
        .reset(reset),
        .SUB_SELECT(sub_switch),
        .output_data(led),
        .HLT()
    );
endmodule

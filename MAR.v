`timescale 1ns / 1ps

module MAR (
    input        clk,
    input        MI,
    input  [3:0] bus_in,
    output [3:0] address
);
    reg [3:0] mar;

    always @(posedge clk) begin
        if (MI)
            mar <= bus_in;
    end

    assign address = mar;
endmodule

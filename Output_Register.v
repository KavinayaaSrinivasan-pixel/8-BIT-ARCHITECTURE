`timescale 1ns / 1ps

module Output_Register (
    input        clk,
    input        OI,
    input  [7:0] bus_in,
    output [7:0] out_data
);
    reg [7:0] out_reg;

    always @(posedge clk) begin
        if (OI)
            out_reg <= bus_in;
    end

    assign out_data = out_reg;
endmodule

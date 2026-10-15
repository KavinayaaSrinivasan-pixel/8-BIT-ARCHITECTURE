`timescale 1ns / 1ps

module CPU_BUS (
    input  [7:0] ram_data,
    input  [7:0] a_data,
    input  [7:0] b_data,
    input  [7:0] alu_data,
    input  [7:0] ir_data,
    input  [7:0] out_data,
    input  [3:0] pc_data,
    input  [3:0] mar_data,
    input RO, AO, BO, EO, IO, OO, CO, MO,
    output reg [7:0] bus
);
    always @(*) begin
        bus = 8'b00000000;
        if      (RO) bus = ram_data;
        else if (AO) bus = a_data;
        else if (BO) bus = b_data;
        else if (EO) bus = alu_data;
        else if (IO) bus = ir_data;
        else if (OO) bus = out_data;
        else if (CO) bus = {4'b0000, pc_data};
        else if (MO) bus = {4'b0000, mar_data};
    end
endmodule

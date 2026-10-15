`timescale 1ns / 1ps

module ALU (
    input  [7:0] a_in,
    input  [7:0] b_in,
    input        ALO,
    input        SUB_SELECT,
    input        XRA,
    input        ANA,
    output reg [7:0] result,
    output reg [1:0] flags
);
    reg [8:0] temp;

    always @(*) begin
        result = 8'b00000000;
        flags  = 2'b00;
        temp   = 9'b000000000;

        if (ALO) begin
            if (XRA)
                result = a_in ^ b_in;
            else if (ANA)
                result = a_in & b_in;
            else if (SUB_SELECT)
                result = a_in - b_in;
            else begin
                temp = {1'b0, a_in} + {1'b0, b_in};
                result = temp[7:0];
            end
        end

        if (result == 8'b00000000)
            flags[0] = 1'b1;

        if (ALO && !SUB_SELECT && !XRA && !ANA)
            flags[1] = temp[8];
    end
endmodule

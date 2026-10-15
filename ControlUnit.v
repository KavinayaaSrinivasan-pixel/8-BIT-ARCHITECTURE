`timescale 1ns / 1ps

module ControlUnit (
    input clk,
    input reset,
    input [3:0] opcode,
    output reg CO, CL, CE,
    output reg MI, RI, RO,
    output reg II, IO,
    output reg AI, AO,
    output reg BI, BO,
    output reg ALO, SUB, XRA, ANA, EO,
    output reg OI, OO,
    output reg HLT
);
    parameter LDA    = 4'b0001;
    parameter ADD    = 4'b0010;
    parameter STA    = 4'b0011;
    parameter OUT_OP = 4'b0100;
    parameter SUB_OP = 4'b0101;
    parameter XOR_OP = 4'b0110;
    parameter AND_OP = 4'b0111;
    parameter HLT_OP = 4'b1111;

    parameter T0 = 3'd0, T1 = 3'd1, T2 = 3'd2,
              T3 = 3'd3, T4 = 3'd4, T5 = 3'd5, STOP = 3'd6;
    reg [2:0] T = T0;

    always @(posedge clk or posedge reset) begin
        if (reset)
            T <= T0;
        else begin
            case (T)
                T0: T <= T1;
                T1: T <= T2;
                T2: T <= T3;
                T3: begin
                    case (opcode)
                        LDA, ADD, SUB_OP, STA, XOR_OP, AND_OP, OUT_OP: T <= T4;
                        HLT_OP: T <= STOP;
                        default: T <= T0;
                    endcase
                end
                T4: begin
                    case (opcode)
                        ADD, SUB_OP, XOR_OP, AND_OP: T <= T5;
                        default: T <= T0;
                    endcase
                end
                T5: T <= T0;
                STOP: T <= STOP;
                default: T <= T0;
            endcase
        end
    end

    always @(*) begin
        CO=0; CL=0; CE=0; MI=0; RI=0; RO=0;
        II=0; IO=0; AI=0; AO=0; BI=0; BO=0;
        ALO=0; SUB=0; XRA=0; ANA=0; EO=0;
        OI=0; OO=0; HLT=0;

        case (T)
            T0: begin CO=1; MI=1; end
            T1: begin RO=1; II=1; end
            T2: begin CE=1; end
            T3: begin
                case (opcode)
                    LDA, ADD, SUB_OP, STA, XOR_OP, AND_OP: begin IO=1; MI=1; end
                    HLT_OP: HLT=1;
                    default: begin end
                endcase
            end
            T4: begin
                case (opcode)
                    LDA:    begin RO=1; AI=1; end
                    ADD:    begin RO=1; BI=1; end
                    SUB_OP: begin RO=1; BI=1; end
                    STA:    begin AO=1; RI=1; end
                    OUT_OP: begin AO=1; OI=1; end
                    XOR_OP: begin RO=1; BI=1; end
                    AND_OP: begin RO=1; BI=1; end
                    default: begin end
                endcase
            end
            T5: begin
                case (opcode)
                    ADD:    begin ALO=1; EO=1; AI=1; SUB=0; end
                    SUB_OP: begin ALO=1; EO=1; AI=1; SUB=1; end
                    XOR_OP: begin ALO=1; XRA=1; EO=1; AI=1; end
                    AND_OP: begin ALO=1; ANA=1; EO=1; AI=1; end
                    default: begin end
                endcase
            end
            STOP: HLT=1;
            default: begin end
        endcase
    end
endmodule

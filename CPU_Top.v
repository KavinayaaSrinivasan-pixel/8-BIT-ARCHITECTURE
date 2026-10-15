`timescale 1ns / 1ps

module CPU_Top (
    input        clk,
    input        reset,
    input        SUB_SELECT,
    output [7:0] output_data,
    output       HLT
);
    wire [7:0] bus;
    wire [3:0] pc_bus, mar_address;
    wire CO, CL, CE, MI, RI, RO, II, IO, AI, AO, BI, BO;
    wire ALO, SUB, XRA, ANA, EO, OI, OO;
    wire [3:0] opcode, operand;
    wire [7:0] ram_bus, a_data, b_data, alu_result, out_data;
    wire [1:0] flags;
    wire MO = 1'b0;

    ControlUnit CU (
        .clk(clk), .reset(reset), .opcode(opcode),
        .CO(CO), .CL(CL), .CE(CE), .MI(MI), .RI(RI), .RO(RO),
        .II(II), .IO(IO), .AI(AI), .AO(AO), .BI(BI), .BO(BO),
        .ALO(ALO), .SUB(SUB), .XRA(XRA), .ANA(ANA), .EO(EO),
        .OI(OI), .OO(OO), .HLT(HLT)
    );

    ProgramCounter PC (
        .clk(clk), .reset(reset), .CO(CO), .CL(CL), .CE(CE),
        .bus_in(bus[3:0]), .bus_out(pc_bus)
    );

    MAR MAR_UNIT (.clk(clk), .MI(MI), .bus_in(bus[3:0]), .address(mar_address));

    RAM RAM_UNIT (
        .clk(clk), .RI(RI), .RO(RO), .MAR(mar_address),
        .bus_in(bus), .bus_out(ram_bus)
    );

    Instruction_Register IR (
        .clk(clk), .reset(reset), .II(II), .bus_in(bus),
        .opcode(opcode), .operand(operand)
    );

    A_Register A_REG (.clk(clk), .AI(AI), .bus_in(bus), .a_out(a_data));
    B_Register B_REG (.clk(clk), .BI(BI), .bus_in(bus), .b_out(b_data));

    ALU ALU_UNIT (
        .a_in(a_data), .b_in(b_data), .ALO(ALO),
        .SUB_SELECT(SUB_SELECT), .XRA(XRA), .ANA(ANA),
        .result(alu_result), .flags(flags)
    );

    Output_Register OUT_REG (.clk(clk), .OI(OI), .bus_in(bus), .out_data(out_data));

    CPU_BUS BUS_UNIT (
        .ram_data(ram_bus), .a_data(a_data), .b_data(b_data),
        .alu_data(alu_result), .ir_data({opcode, operand}), .out_data(out_data),
        .pc_data(pc_bus), .mar_data(mar_address),
        .RO(RO), .AO(AO), .BO(BO), .EO(EO), .IO(IO), .OO(OO),
        .CO(CO), .MO(MO), .bus(bus)
    );

    assign output_data = out_data;
endmodule

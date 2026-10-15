# 8-bit CPU / ALU in Verilog

A beginner-friendly 8-bit CPU project built from separate Verilog modules and integrated through a top-level module. The design includes an ALU, control unit, registers, program counter, memory address register, RAM, instruction register, shared CPU bus, output register, and FPGA wrapper.

## Repository structure

```text
8_bit_cpu_alu_github/
├── rtl/
│   ├── ALU.v
│   ├── A_Register.v
│   ├── B_Register.v
│   ├── CPU_BUS.v
│   ├── CPU_Top.v
│   ├── ControlUnit.v
│   ├── FPGA_Top.v
│   ├── Instruction_Register.v
│   ├── MAR.v
│   ├── Output_Register.v
│   ├── ProgramCounter.v
│   └── RAM.v
├── docs/
│   └── ARCHITECTURE.md
└── README.md
```

## Features

- 8-bit datapath and 4-bit address/program counter.
- Modular design using separate Verilog modules.
- ALU operations: addition, subtraction, bitwise XOR, and bitwise AND.
- Control unit with fetch/decode/execute sequencing.
- RAM initialized with a sample program and data.
- FPGA wrapper exposing the output register on 8 LEDs.

## Modules

| Module | Purpose |
|---|---|
| `ALU` | Performs arithmetic and logic operations |
| `ControlUnit` | Generates control signals and sequences CPU states |
| `ProgramCounter` | Holds the address of the next instruction |
| `MAR` | Holds the memory address |
| `RAM` | Stores instructions and data |
| `Instruction_Register` | Holds the current instruction and separates opcode/operand |
| `A_Register`, `B_Register` | Hold ALU operands |
| `CPU_BUS` | Selects a source for the shared datapath bus |
| `Output_Register` | Holds the externally visible output |
| `CPU_Top` | Connects the CPU modules together |
| `FPGA_Top` | Board-facing wrapper; maps output to LEDs |

## Instruction encoding

The instruction format is `[7:4] opcode` and `[3:0] operand`.

| Instruction | Opcode | Meaning |
|---|---:|---|
| LDA | `0001` | Load memory data into A |
| ADD | `0010` | Add memory data to A |
| STA | `0011` | Store A to memory |
| OUT | `0100` | Copy A to output register |
| SUB | `0101` | Subtract memory data from A |
| XOR | `0110` | Bitwise XOR with memory data |
| AND | `0111` | Bitwise AND with memory data |
| HLT | `1111` | Halt the control sequencer |

## How to simulate

1. Create a new RTL project in Vivado (or use another Verilog simulator).
2. Add every `.v` file in `rtl/`.
3. Set `FPGA_Top` as the synthesis top for an FPGA build, or `CPU_Top` as the simulation top.
4. Add a testbench that generates `clk`, pulses `reset`, and observes `output_data` and `HLT`.
5. Run behavioral simulation before programming an FPGA.

## Important notes

This package organizes the supplied design into separate files and preserves its intended module structure. It has **not** been hardware-verified. Review the control/data-path timing before relying on simulation or FPGA results. In particular, the current sample program and control logic may need debugging for the expected instruction behavior. The `SUB_SELECT` input currently controls subtraction in the ALU independently of the control unit's `SUB` signal; consider connecting the control signal to the ALU if you want instruction-driven ADD/SUB behavior. Also check that bus source selection, RAM read/write timing, and the STA/OUT control sequence behave as intended in your simulator.

# Architecture overview

```text
                 +------------------+
                 |   Control Unit   |
                 | fetch/decode/exec|
                 +---------+--------+
                           | control signals
                           v
+------+  +------+  +------+-----+  +-----+
|  PC  |->| MAR  |->|   RAM      |->| IR  |
+------+  +------+  +------------+  +-----+
   |           \          |              |
   +------------\---------+--------------+
                \        shared 8-bit CPU bus
                 v
       +---------+---------+
       | A Register / B Reg|
       +---------+---------+
                 |
                 v
              +-----+
              | ALU |
              +--+--+
                 |
                 v
        +-----------------+
        | Output Register |
        +-----------------+
                 |
                 v
             output_data / LEDs
```

## Datapath components

- **PC:** 4-bit program counter.
- **MAR:** 4-bit memory address register.
- **RAM:** 16 locations, each 8 bits wide.
- **IR:** 8-bit instruction register, split into a 4-bit opcode and 4-bit operand.
- **A/B registers:** 8-bit operand storage for ALU operations.
- **ALU:** 8-bit ADD, SUB, XOR, and AND operations, with zero/carry flags.
- **CPU bus:** Selects a single source using control signals.
- **Output register:** Stores the value exposed by the CPU top module.

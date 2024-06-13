# PipelineCPU
Design a typical 5-stage pipeline MIPS CPU. When the CPU receives a command, it divides the command into five stages: Instruction Fetch (IF), Instruction Decode (ID), Execution (EX), Data Memory Access (MEM), and Write Back (WB). The CPU is composed of an ALU, an adder, data memory, instruction memory, a program counter (PC), and so on. In addition, the instructions in the register include three typical types of MIPS instructions: add, slt, beq, bne, sw, and lw. The CPU will start executing from address 0, then follow the program counter to the specified address to complete these instructions.The architecture is depicted in the following figure.
<p align="center">
  <img src="https://github.com/RexJian/PipelineCPU/blob/main/Image/Architecture.jpg" width="800" height="450" alt="Architecture">
</p> 

## Specification

| Signal Name | I/O | Width | Sample Description |
| :----: | :----: | :----: | :----|
| CLK | I | 1 | Clock Signal |
| EN | I | 1 | Enable signal |
| CLR_N | I | 1 | The register data clean signal|
| Addr | O | 32 | Current instruction address|
| ALU_D1 | O | 32 | One of the ALU input|
| Y | O | 32 | One of the ALU input |
| Ex_Alu_R | O | 32 | The result of ALU|
| stall | O | 1 | When the signal is asserted, the data in the pipline registers will remain.|
| condition_met | O | 1 | When the signal is asserted, the  data in the pipeline register will be clean, then the new adddress will be the input in the next cycle. |
| Rs | O | 5 | The address of source register |
| Rt | O | 5 | The address of targe register |
| Rd | O | 5 | The address of destination register |
| Write_Rd | O | 32 | The value written in the destination register |

## Instructions in the register

| Register Address (Hex) | Instruction (Hex) | Instruction Meaning | Desciption |
| :----: | :----: | :----: | :----: |
| 0 | 20020005 | addi $2, $0, 5 | Initialize $2 = 5 |
| 4 | 2003000c | addi $3, $0, 12 | Initialize $3 = 12 |
| 8 | 20070003 | addi $7, $0, 3 | Initialize $7 = 3 |
| c | 00e22025 | or $4, $7, $2 | $4 = 3 or 5 = 7 |
| 10 | 00642824 | and $5, $3, $4 | $5 = 12 and 7 = 4 |
| 14 | 00a42820 | add $5, $5, $4 | $5 = 4 + 7 = 11 |
| 18 | 10a7000a | beq $5, $7, end | The condition is invalid |
| 1c | 0064202a | slt $4, $3, $4 | $4 = 12 < 7 = 0 |
| 20 | 10800001 | beq $4, $0, around | The condition is valid, so next instruction address is "around" address|
| 24 | 20050000 | addi $5, $0, 0 | CPU will not implement the instruction |
| 28 | 00e2202a | around: slt $4, $7, $2 | $4 = 3 < 5 = 1|
| 2c | 00853820 | add $7, $4, $5 | $7 = 1 + 11 = 12 |
| 30 | 00e23822 | sub $7, $7, $2 | $7 = 12 - 5 = 7 |
| 34 | ac670044 | sw $7, 68($3) | Store $7 value to the address 80 of data memory |
| 38 | 8c020050 | lw $2, 80($0) | Load the value of the address 80 of data memory to $2 |
| 3c | 20020001 | addi $2, $0, 1 | $2 = 1 |
| 40 | ac020054 | sw $2, 84($0) | Store $2 value to the address of 80 of data memory |

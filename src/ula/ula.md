
# Entity: ula 
- **File**: ula.v
- **Title:**  ULA
- **Author:**  taffarel55

## Diagram
![Diagram](ula.svg "Diagram")
## Description

An Arithmetic Logic Unit (ALU) is a fundamental
component of a CPU (Central Processing Unit) that performs
arithmetic and logical operations. In Verilog, an ALU can
be implemented as a module with inputs for operands, operation
selection, and outputs for the result of the module.

## Generics

| Generic name | Type    | Value | Description       |
| ------------ | ------- | ----- | ----------------- |
| DATA_SIZE    | integer | 11    | Data size in bits |

## Ports

| Port name | Direction | Type                 | Description    |
| --------- | --------- | -------------------- | -------------- |
| out       | output    | [DATA_SIZE-1:0]      | Output ULA     |
| operand_a | input     | wire [DATA_SIZE-1:0] | First operand  |
| operand_b | input     | wire [DATA_SIZE-1:0] | Second operand |
| opcode    | input     | wire [3:0]           | Operand code   |

## Constants

| Name | Type | Value | Description          |
| ---- | ---- | ----- | -------------------- |
| ADD  |      | 0     | A+B                  |
| SUB  |      | 1     | A-B                  |
| MUL  |      | 2     | A*B                  |
| DIV  |      | 3     | A/B                  |
| AND  |      | 4     | A AND B              |
| NAND |      | 5     | A NAND B             |
| OR   |      | 6     | A OR B               |
| XOR  |      | 7     | A XOR B              |
| CMP  |      | 8     | 1:A>B, 0:A=B, -1:A<B |
| NOT  |      | 9     | !A                   |

## Processes
- ULA: ( @(*) )
  - **Type:** always

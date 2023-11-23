
# Entity: register 
- **File**: register.v
- **Title:**  Register
- **Author:**  taffarel55

## Diagram
![Diagram](register.svg "Diagram")
## Description

A Register module is a fundamental component in digital
circuits that stores a binary value of a specified data size.
It can be implemented in Verilog as a module with inputs for
data input, clock signal, load signal, reset signal, and an
increment signal. The module has an output for the stored
value. The data size is configurable using the DATA_SIZE
parameter.

## Generics

| Generic name | Type    | Value | Description       |
| ------------ | ------- | ----- | ----------------- |
| DATA_SIZE    | integer | 11    | Data size in bits |

## Ports

| Port name | Direction | Type                 | Description     |
| --------- | --------- | -------------------- | --------------- |
| out       | output    | [DATA_SIZE-1:0]      | Output register |
| in        | input     | wire [DATA_SIZE-1:0] | Input register  |
| clk       | input     | wire                 | Clock pin       |
| load      | input     | wire                 | Load pin        |
| rst       | input     | wire                 | Reset pin       |
| inc       | input     | wire                 | Inc pin         |

## Processes
- REGISTER: ( @(posedge clk, posedge rst) )
  - **Type:** always


# Entity: stack 
- **File**: stack.v
- **Title:**  Register
- **Author:**  taffarel55

## Diagram
![Diagram](stack.svg "Diagram")
## Description

Implementation of a stack with
asynchronous high-active reset,
write(push)/read(pop) synchronous to rising clock.
Ignores write when full and ignores read when empty.
The design is a queue with a LIFO protocol, parameterized for WIDTH and DEPTH.
Asynchronous reset and otherwise synchronized to a clock.

## Generics

| Generic name | Type    | Value | Description                      |
| ------------ | ------- | ----- | -------------------------------- |
| WIDTH        | integer | 8     | Stack width - num of bits        |
| DEPTH        | integer | 2     | Pointer depth - num of positions |

## Ports

| Port name | Direction | Type             | Description      |
| --------- | --------- | ---------------- | ---------------- |
| full      | output    | wire             | Full output pin  |
| empty     | output    | wire             | Empty output pin |
| data_out  | output    | [WIDTH-1:0]      | Data out         |
| data_in   | input     | wire [WIDTH-1:0] | Data in          |
| clk       | input     | wire             | Clock pin        |
| rst       | input     | wire             | Reset pin        |
| pop       | input     | wire             | Pop pin (read)   |
| push      | input     | wire             | Push pin (write) |

## Signals

| Name               | Type              | Description             |
| ------------------ | ----------------- | ----------------------- |
| lifo [0:DEPTH - 1] | reg [WIDTH-1:0]   | Last In First Out queue |
| pointer            | reg [DEPTH - 1:0] | Stack pointer           |

## Processes
- STACK: ( @(posedge clk or posedge rst) )
  - **Type:** always

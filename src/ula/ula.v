//! @title ULA
//! @author taffarel55

//! An Arithmetic Logic Unit (ALU) is a fundamental
//! component of a CPU (Central Processing Unit) that performs
//! arithmetic and logical operations. In Verilog, an ALU can
//! be implemented as a module with inputs for operands, operation
//! selection, and outputs for the result of the module.

module ula #(
    parameter integer DATA_SIZE = 11        //! Data size in bits
  ) (
    output reg [DATA_SIZE-1:0] out,         //! Output ULA
    input wire [DATA_SIZE-1:0] operand_a,   //! First operand
    input wire [DATA_SIZE-1:0] operand_b,   //! Second operand
    input wire [3:0] opcode                 //! Operand code
  );

  localparam  ADD  = 0; //! A+B
  localparam  SUB  = 1; //! A-B
  localparam  MUL  = 2; //! A*B
  localparam  DIV  = 3; //! A/B
  localparam  AND  = 4; //! A AND B
  localparam  NAND = 5; //! A NAND B
  localparam  OR   = 6; //! A OR B
  localparam  XOR  = 7; //! A XOR B
  localparam  CMP  = 8; //! 1:A>B, 0:A=B, -1:A<B
  localparam  NOT  = 9; //! !A

  // TODO: Adicionar suporte a um LSFR

  always @(*)
  begin : ULA
    case (opcode)
      ADD:
        out = operand_a + operand_b;
      SUB:
        out = operand_a - operand_b;
      MUL:
        out = operand_a * operand_b;
      DIV:
        out = operand_a / operand_b;
      AND:
        out = operand_a && operand_b;
      NAND:
        out = !(operand_a && operand_b);
      OR:
        out = operand_a || operand_b;
      XOR:
        out = operand_a ^ operand_b;
      CMP:
        out = operand_a > operand_b ? 1 : operand_a < operand_b ? -1 : 0;
      NOT:
        out = !operand_a;
      default:
        out = {DATA_SIZE{1'bx}};
    endcase
  end

endmodule

// iverilog -g2005-sv -t null *.v

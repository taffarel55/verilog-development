`include "src/ula/ula.v"
`timescale 1ns/1ps

module ula_test;

  // Parameters
  localparam integer DATA_SIZE = 11;

  //Ports
  wire [DATA_SIZE-1:0] out;
  reg  [DATA_SIZE-1:0] operand_a;
  reg  [DATA_SIZE-1:0] operand_b;
  reg  [3:0] opcode;

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

  ula # (
        .DATA_SIZE(DATA_SIZE)
      )
      ula_inst (
        .out(out),
        .operand_a(operand_a),
        .operand_b(operand_b),
        .opcode(opcode)
      );

  task expect(input [DATA_SIZE-1:0] exp_out);
    begin
      $display("At time %0d opcode=%b a=%d b=%d out=%d",
               $time, opcode, operand_a, operand_b, out);
      if (out !== exp_out)
      begin
        $display("TEST FAILED");
        $display("out should be %d", exp_out);
        $finish;
      end
    end
  endtask

  initial
  begin
    $dumpfile("ula_test.vcd");
    $dumpvars(0, ula_test);

    opcode = ADD;
    operand_a = 10;
    operand_b = 20;
    #1;
    expect(30);

    opcode = SUB;
    operand_a = 20;
    operand_b = 10;
    #1;
    expect(10);

    opcode = MUL;
    operand_a = 24;
    operand_b = 25;
    #1;
    expect(600);

    opcode = DIV;
    operand_a = 13;
    operand_b = 5;
    #1;
    expect(2);

    opcode = AND;
    operand_a = 'h55;
    operand_b = 'haa;
    #1;
    expect(1);

    opcode = NAND;
    operand_a = 'h55;
    operand_b = 'haa;
    #1;
    expect(0);

    opcode = OR;
    operand_a = 'h55;
    operand_b = 'haa;
    #1;
    expect(1);

    opcode = XOR;
    operand_a = 'h55;
    operand_b = 'haa;
    #1;
    expect('hff);

    opcode = CMP;
    operand_a = 123;
    operand_b = 122;
    #1;
    expect(1);
    operand_b = 124;
    #1;
    expect(-1);
    operand_b = 123;
    #1;
    expect(0);

    opcode = NOT;
    operand_a = 123;
    #1;
    expect(0);

    $display("TESTS PASSED");
    $finish;
  end

endmodule

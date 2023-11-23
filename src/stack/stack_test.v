`include "src/stack/stack.v"
`timescale 1ns/1ps

module stack_test;

  parameter integer WIDTH = 8;
  parameter integer DEPTH = 3;

  // Inputs
  reg clk;
  reg rst;
  reg pop;
  reg push;
  reg [WIDTH-1:0] data_in;

  // Outputs
  wire empty;
  wire full;
  wire [WIDTH-1:0] data_out;

  // Variables
  integer i;

  // Instantiate the Design Under Test (DUT)
  stack #(
          .WIDTH(WIDTH),
          .DEPTH(DEPTH)
        ) dut (
          .clk(clk),
          .rst(rst),
          .pop(pop),
          .push(push),
          .empty(empty),
          .full(full),
          .data_in(data_in),
          .data_out(data_out)
        );

  task reset;  // reset task
    begin
      rst  = 1'b1;
      pop  = 1'b0;
      push = 1'b0;
      data_in  = {WIDTH{1'b0}};
      @(negedge clk);
      rst = 1'b0;
      @(negedge clk);
    end
  endtask

  task pop_stack;  // read task
    begin
      @(negedge clk);
      pop = 1'b1;
      @(negedge clk);
      pop = 1'b0;
    end
  endtask

  task push_stack(input [WIDTH-1:0] data_in_tb); // write task
    begin
      @(negedge clk);
      push = 1'b1;
      data_in = data_in_tb;
      @(negedge clk);
      push = 1'b0;
      #10;
    end
  endtask

  task expect_out(input [WIDTH-1:0] exp_out);
    begin
      if (data_out !== exp_out)
      begin
        $display("TEST FAILED");
        $display("out should be %h", exp_out);
        $finish;
      end
    end
  endtask

  task expect_full(input isFull);
    begin
      if (full!==isFull)
      begin
        $display("TEST FAILED");
        $display("stack should be full");
        $finish;
      end
    end
  endtask

  task expect_empty(input isEmpty);
    begin
      if (empty!==isEmpty)
      begin
        $display("TEST FAILED");
        $display("stack should be empty");
        $finish;
      end
    end
  endtask

  initial
  begin
    clk  = 1'b0;
    forever
      #5 clk = ~clk;
  end

  // Main code
  initial
  begin
    // Create vcd
    $dumpfile("stack.vcd");
    $dumpvars(0, stack_test);

    // Monitor
    $monitor("At time %0d:  \t pointer=%d, in=0x%h, out=0x%h, full=%b, empty=%b",
             $time, dut.pointer, data_in, data_out, full, empty);

    // Reset
    reset();

    // Push
    expect_full(0);
    push_stack({WIDTH>>2{4'hA}});
    expect_full(0);
    push_stack({WIDTH>>2{4'hB}});
    expect_full(0);
    push_stack({WIDTH>>2{4'hC}});
    expect_full(1);

    // Pop
    expect_empty(0);
    pop_stack();
    expect_out({WIDTH>>2{4'hC}});
    expect_empty(0);
    pop_stack();
    expect_out({WIDTH>>2{4'hB}});
    expect_empty(0);
    pop_stack();
    expect_out({WIDTH>>2{4'hA}});
    expect_empty(1);

    #20;

    $display("TEST PASSED");
    $finish;
  end

endmodule

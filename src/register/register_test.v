`include "src/register/register.v"
`timescale 1ns/1ps

module register_test;

  // Parameters
  parameter integer DATA_SIZE = 11;

  // Signals
  reg [DATA_SIZE-1:0] in_data;
  reg clk, load, rst, inc, dec;
  wire [DATA_SIZE-1:0] out_data;

  // Instantiate the Register module
  register #(DATA_SIZE) dut (
             .out(out_data),
             .in(in_data),
             .clk(clk),
             .load(load),
             .rst(rst),
             .inc(inc),
             .dec(dec)
           );

  task expect(input [DATA_SIZE-1:0] exp_out);
    begin
      $display("At time %0d load=%b rst=%b inc=%b dec=%b in=%d out=%d",
               $time, load, rst, inc, dec, in_data, out_data);
      if (out_data !== exp_out)
      begin
        $display("TEST FAILED");
        $display("out should be %d", exp_out);
        $finish;
      end
    end
  endtask

  // Clock generation
  initial
  begin
    clk = 0;
    forever
      #5 clk = ~clk;
  end

  // Test procedure
  initial
  begin
    // Create vcd
    $dumpfile("register.vcd");
    $dumpvars(0, register_test);

    // Initialize signals
    in_data = 8'h00; // Set initial input data
    load = 0;       // Deactivate load signal
    rst = 0;        // Deactivate reset signal
    inc = 0;        // Deactivate increment signal
    dec = 0;        // Deactivate decrement signal

    // Apply test cases
    #10 in_data = 8'h0A; // Load new data

    #10 load = 1;               // Activate load signal
    repeat(2) @(negedge clk);   // Wait load
    expect(in_data);            // Expect load
    #10 load = 0;               // Deactivate load signal

    #10 inc = 1;                // Activate increment signal
    repeat(2) @(negedge clk);   // Wait increment
    expect(in_data + 1);        // Expect increment
    #10 inc = 0;                // Deactivate increment signal

    #10 dec = 1;                // Activate decrement signal
    repeat(2) @(negedge clk);   // Wait increment
    expect(in_data + 1);         // Expect increment
    #10 inc = 0;                // Deactivate increment signal

    #10 rst = 1;                // Activate reset signal
    #1;                         // Dont wait too much for rst
    expect(0);                  // Expect reset
    #10 rst = 0;                // Deactivate reset signal

    // Simulation termination
    $display("TESTS PASSED");
    $finish;
  end

endmodule

//! @title Register
//! @author taffarel55

//! Implementation of a stack with
//! asynchronous high-active reset,
//! write(push)/read(pop) synchronous to rising clock.
//! Ignores write when full and ignores read when empty.
//! The design is a queue with a LIFO protocol, parameterized for WIDTH and DEPTH.
//! Asynchronous reset and otherwise synchronized to a clock.

module stack #(
    parameter integer WIDTH = 8,      //! Stack width - num of bits
    parameter integer DEPTH = 2       //! Pointer depth - num of positions
  ) (
    output wire full,                 //! Full output pin
    output wire empty,                //! Empty output pin
    output reg [WIDTH-1:0] data_out,  //! Data out
    input wire [WIDTH-1:0] data_in,   //! Data in
    input wire clk,                   //! Clock pin
    input wire rst,                   //! Reset pin
    input wire pop,                   //! Pop pin (read)
    input wire push                   //! Push pin (write)
  );

  reg [WIDTH-1:0] lifo [0:DEPTH - 1]; //! Last In First Out queue
  reg [DEPTH - 1:0] pointer;          //! Stack pointer

  assign empty = !(|pointer);
  assign full = !(|(pointer ^ DEPTH));

  always @(posedge clk or posedge rst)
  begin : STACK
    if(rst)
    begin
      data_out <= {WIDTH{1'b0}};
      pointer <= 0;
    end
    else
    begin
      if(push && !full)
      begin
        lifo[pointer] <= data_in;
        pointer <= pointer + 1;
      end
      else if(pop && !empty)
      begin
        data_out <= lifo[pointer-1];
        pointer <= pointer - 1;
      end
    end
  end

endmodule

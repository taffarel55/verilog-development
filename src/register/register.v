//! @title Register
//! @author taffarel55

//! A Register module is a fundamental component in digital
//! circuits that stores a binary value of a specified data size.
//! It can be implemented in Verilog as a module with inputs for
//! data input, clock signal, load signal, reset signal, and an
//! increment signal. The module has an output for the stored
//! value. The data size is configurable using the DATA_SIZE
//! parameter.

module register #(
    parameter integer DATA_SIZE = 11        //! Data size in bits
  ) (
    output reg [DATA_SIZE-1:0] out,         //! Output register
    input wire [DATA_SIZE-1:0] in,          //! Input register
    input wire clk,                         //! Clock pin
    input wire load,                        //! Load pin
    input wire rst,                         //! Reset pin
    input wire inc,                         //! Inc pin
    input wire dec                          //! Dec pin
  );

  always @(posedge clk, posedge rst)
  begin : REGISTER
    if(rst)
      out <= 0;
    else if(load)
      out <= in;
    else if(inc)
      out <= out + 1;
    else if(dec)
      out <= out - 1;
    else
      out <= out;
  end

endmodule

// iverilog -g2005-sv -t null *.v

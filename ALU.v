`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:29:52 11/16/2020 
// Design Name: 
// Module Name:    ALU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ALU( output zero, output reg [31:0] out, input [31:0] a, b, input [2:0] alu_ctrl
    ); //parameter
	 wire [63:0] result;
	 wire [31:0] andres; //for and 
	 wire [31:0] orres; //for or result
	 wire [31:0] quotient;
	 wire [31:0] sltres; //for slt
	// wire [31:0] hi, lo; //for multiplier

	 wire c_in, c_out; //for adder
	 wire [31:0] sum; //for adder
	// wire [31:0] a,b;
	// assign out = result;
	
	 //instantiate multiplier
	 multiplier ML1 (.product(result), .a(a), .b(b) );
//	 assign lo = result[31:0];
//	 assign hi = result[63:32];
//	 assign out [31:0] = result;
	 
	 //instantiate adder
	 Add_32 AD1 ( .c_out(X), .c_in(1'b0), .sum(sum), .a(a), .b(b) );
	//  assign out[31:0] = sum;
//	 assign lo = sum;

	 
	 //instantiate and
	 and1 AN1 (.owt(andor_res), .a(a), .b(b)); // SN: "andor_res" not defined
//	 assign out [31:0] = andres;
	 
	 //instantiate or
	 or1 OR1 (.owt(andor_res), .a(a), .b(b)); // SN: "andor_res" not defined
//	 assign out [31:0] = orres;
	 
	 //instantiate divider
	 Divider DV1 (.quotient(quotient), .dividend(a), .divisor(b));
//	 assign out [31:0] = quotient;

	//instantiate slt
	slt SL1 (.val(sltres), .a(a), .b(b));

always @(*)
  begin
     case(alu_ctrl)
       3'b010: //add
        out <= sum;
       3'b110: //subtract
        out <= a - b;
       3'b011: //multiply
        out <= result;

       3'b100: //divide
        out  <= quotient;
       3'b000: //AND
        out <= andres;
       3'b001: //OR
         out <= orres;
       3'b010: //SLT
        out <= sltres;
    endcase
  end
endmodule

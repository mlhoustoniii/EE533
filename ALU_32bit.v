`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:48:30 01/23/2026 
// Design Name: 
// Module Name:    ALU_32bit 
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
module ALU_32bit(
    input [31:0] A,
    input [31:0] B,
	 input [3:0] ALU_op,
	 output reg [31:0] Result,
	 output reg Co
    );

	reg [32:0] result_tmp;
	
	always@(*)
	begin
	case(ALU_op)
	
	4'b0000: begin // adder
	result_tmp = A + B;
	Result = result_tmp[31:0];
	Co = result_tmp[32];
	end
	
	4'b0001: begin // subtract
	result_tmp[31:0] = A - B;
	Result = result_tmp[31:0];
	Co = result_tmp[32];
	end
	
	4'b0011: begin // AND
	Result = A & B;
	Co = 0;
	end
	
	4'b0111: begin // OR
	Result = A | B;
	Co = 0;
	end
	
	4'b1111: begin // SHIFT RIGHT
	Result = A >> B[4:0]; // Shift input A by amount of B (limited to 5 bit shift)
	Co = 0;
	end
	endcase
	
	end

endmodule

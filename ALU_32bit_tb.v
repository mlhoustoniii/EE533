`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:31:18 01/23/2026
// Design Name:   ALU_32bit
// Module Name:   C:/Documents and Settings/Melvin/My Documents/8-bitAdder/Adder_8bit_sync/Adder_32bit_sync/ALU_32bit/ALU_32bit_tb.v
// Project Name:  ALU_32bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU_32bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_32bit_tb;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg [3:0] ALU_op;

	// Outputs
	wire [31:0] Result;
	wire Co;

	// Instantiate the Unit Under Test (UUT)
	ALU_32bit uut (
		.A(A), 
		.B(B), 
		.ALU_op(ALU_op), 
		.Result(Result), 
		.Co(Co)
	);

	integer i;
	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		ALU_op = 0;

		// Wait 100 ns for global reset to finish
		for(i=0; i<=5; i=i+1)
		begin
		
		case (i)
		1: begin
		ALU_op = 4'b0000;
		end
		
		2: begin
		ALU_op = 4'b0001;
		end
		
		3: begin
		ALU_op = 4'b0011;
		end
		
		4: begin
		ALU_op = 4'b0111;
		end
		
		5: begin
		ALU_op = 4'b1111;
		end
		endcase
		
		#100;
		A = 32'h00000000;
		B = 32'h00000000;
		
		#100;
		A = 32'hFFFFFFFF;
		B = 32'h00000000;
		
		#100;
		A = 32'h80000000;
		B = 32'h80000000;
		
		#100;
		A = 32'hFFFFFFFF;
		B = 32'hFFFFFFFF;	
		end

		$stop;

	end
      
endmodule


////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 10.1
//  \   \         Application : sch2verilog
//  /   /         Filename : dropfifo.vf
// /___/   /\     Timestamp : 01/27/2026 19:07:22
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2verilog.exe -intstyle ise -family spartan3a -w "C:/Documents and Settings/Melvin/My Documents/8-bitAdder/Adder_8bit_sync/Mini_IDS/dropfifo.sch" dropfifo.vf
//Design Name: dropfifo
//Device: spartan3a
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 100 ps / 10 ps

module FD8CE_HXILINX_dropfifo(Q, C, CE, CLR, D);

   
   output [7:0]       Q;

   input 	      C;	
   input 	      CE;	
   input 	      CLR;	
   input  [7:0]       D;
   
   reg    [7:0]       Q;
   
   always @(posedge C or posedge CLR)
     begin
	if (CLR)
	  Q <= 8'b0000_0000;
	else if (CE)
          Q <= D;
     end
   
   
endmodule
`timescale  100 ps / 10 ps

module COMP8_HXILINX_dropfifo (EQ, A, B);
    

   output EQ;

   input  [7:0] A;
   input  [7:0] B;

   assign EQ = (A==B) ;

endmodule
`timescale 100 ps / 10 ps

module CB8CLE_HXILINX_dropfifo(CEO, Q, TC, C, CE, CLR, D, L);
   
   parameter TERMINAL_COUNT = 8'b1111_1111;
   
   output             CEO;
   output [7:0]       Q;
   output             TC;

   input 	      C;	
   input 	      CE;	
   input 	      CLR;	
   input  [7:0]       D;
   input              L;
   
   reg    [7:0]       Q;
   
   always @(posedge C or posedge CLR)
     begin
	if (CLR)
	  Q <= 8'b0000_0000;
        else if (L)
          Q <= D;
	else if (CE)
	  Q <= Q + 1;
     end
   
   assign CEO = TC & CE;
   assign TC = Q == TERMINAL_COUNT;
   
endmodule
`timescale 100 ps / 10 ps

module CB8CE_HXILINX_dropfifo(CEO, Q, TC, C, CE, CLR);
   
   parameter TERMINAL_COUNT = 8'b1111_1111;
   
   output             CEO;
   output [7:0]       Q;
   output             TC;

   input 	      C;	
   input 	      CE;	
   input 	      CLR;	
   
   reg   [7:0]        Q;
   
   always @(posedge C or posedge CLR)
     begin
	if (CLR)
	  Q <= 8'b0000_0000;
	else if (CE)
	  Q <= Q + 1;
     end
   
   assign CEO = TC & CE;
   assign TC = Q == TERMINAL_COUNT;
   
endmodule
`timescale 1ns / 1ps

module dropfifo(clk, 
                drop_pkt, 
                fiforead, 
                fifowrite, 
                firstword, 
                in_fifo, 
                lastword, 
                rst, 
                out_fifo, 
                valid_data);

    input clk;
    input drop_pkt;
    input fiforead;
    input fifowrite;
    input firstword;
    input [71:0] in_fifo;
    input lastword;
    input rst;
   output [71:0] out_fifo;
   output valid_data;
   
   wire [71:0] in_fifo0;
   wire [7:0] raddr;
   wire [7:0] waddr;
   wire XLXN_36;
   wire XLXN_37;
   wire XLXN_38;
   wire [7:0] XLXN_46;
   wire XLXN_55;
   wire XLXN_56;
   wire XLXN_58;
   wire XLXN_62;
   wire XLXN_70;
   wire XLXN_103;
   wire [0:0] XLXN_105;
   
   FD XLXI_3 (.C(clk), 
              .D(firstword), 
              .Q(XLXN_36));
   defparam XLXI_3.INIT = 1'b0;
   FD XLXI_4 (.C(clk), 
              .D(lastword), 
              .Q(XLXN_37));
   defparam XLXI_4.INIT = 1'b0;
   FD XLXI_5 (.C(clk), 
              .D(drop_pkt), 
              .Q(XLXN_70));
   defparam XLXI_5.INIT = 1'b0;
   FD XLXI_6 (.C(clk), 
              .D(fifowrite), 
              .Q(XLXN_105[0]));
   defparam XLXI_6.INIT = 1'b0;
   CB8CE_HXILINX_dropfifo XLXI_8 (.C(clk), 
                                  .CE(XLXN_62), 
                                  .CLR(rst), 
                                  .CEO(), 
                                  .Q(raddr[7:0]), 
                                  .TC());
   // synthesis attribute HU_SET of XLXI_8 is "XLXI_8_2"
   CB8CLE_HXILINX_dropfifo XLXI_9 (.C(clk), 
                                   .CE(XLXN_105[0]), 
                                   .CLR(rst), 
                                   .D(XLXN_46[7:0]), 
                                   .L(XLXN_70), 
                                   .CEO(), 
                                   .Q(waddr[7:0]), 
                                   .TC());
   // synthesis attribute HU_SET of XLXI_9 is "XLXI_9_4"
   reg9B XLXI_10 (.ce(XLXN_103), 
                  .clk(clk), 
                  .clr(rst), 
                  .d(in_fifo[71:0]), 
                  .q(in_fifo0[71:0]));
   FD8CE_HXILINX_dropfifo XLXI_22 (.C(clk), 
                                   .CE(XLXN_58), 
                                   .CLR(rst), 
                                   .D(waddr[7:0]), 
                                   .Q(XLXN_46[7:0]));
   // synthesis attribute HU_SET of XLXI_22 is "XLXI_22_0"
   COMP8_HXILINX_dropfifo XLXI_23 (.A(waddr[7:0]), 
                                   .B(raddr[7:0]), 
                                   .EQ(XLXN_56));
   // synthesis attribute HU_SET of XLXI_23 is "XLXI_23_1"
   COMP8_HXILINX_dropfifo XLXI_24 (.A(raddr[7:0]), 
                                   .B(XLXN_46[7:0]), 
                                   .EQ(XLXN_55));
   // synthesis attribute HU_SET of XLXI_24 is "XLXI_24_3"
   OR2 XLXI_33 (.I0(XLXN_37), 
                .I1(XLXN_36), 
                .O(XLXN_38));
   AND2B1 XLXI_34 (.I0(XLXN_70), 
                   .I1(XLXN_38), 
                   .O(XLXN_58));
   AND3B2 XLXI_41 (.I0(XLXN_55), 
                   .I1(XLXN_56), 
                   .I2(fiforead), 
                   .O(XLXN_62));
   FDC XLXI_42 (.C(clk), 
                .CLR(rst), 
                .D(XLXN_62), 
                .Q(valid_data));
   defparam XLXI_42.INIT = 1'b0;
   memory72bit XLXI_46 (.addra(waddr[7:0]), 
                      .addrb(raddr[7:0]), 
                      .clka(clk), 
                      .clkb(clk), 
                      .dina(in_fifo0[71:0]), 
                      .wea(XLXN_105[0]), 
                      .doutb(out_fifo[71:0]));
   VCC XLXI_52 (.P(XLXN_103));
endmodule

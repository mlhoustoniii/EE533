////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 10.1
//  \   \         Application : sch2verilog
//  /   /         Filename : detect7B.vf
// /___/   /\     Timestamp : 01/27/2026 19:07:15
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2verilog.exe -intstyle ise -family spartan3a -w "C:/Documents and Settings/Melvin/My Documents/8-bitAdder/Adder_8bit_sync/Mini_IDS/detect7B.sch" detect7B.vf
//Design Name: detect7B
//Device: spartan3a
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 1ns / 1ps

module detect7B(ce, 
                clk, 
                hwregA, 
                match_en, 
                mrst, 
                pipe1, 
                match);

    input ce;
    input clk;
    input [63:0] hwregA;
    input match_en;
    input mrst;
    input [71:0] pipe1;
   output match;
   
   wire clr;
   wire [71:0] pipe0;
   wire [111:0] XLXN_1;
   wire XLXN_10;
   wire XLXN_16;
   wire match_DUMMY;
   
   assign match = match_DUMMY;
   busmerge XLXI_1 (.da(pipe0[47:0]), 
                    .db(pipe1[63:0]), 
                    .q(XLXN_1[111:0]));
   wordmatch XLXI_5 (.datacomp(hwregA[55:0]), 
                     .datain(XLXN_1[111:0]), 
                     .wildcard(hwregA[62:56]), 
                     .match(XLXN_10));
   reg9B XLXI_6 (.ce(ce), 
                 .clk(clk), 
                 .clr(clr), 
                 .d(pipe1[71:0]), 
                 .q(pipe0[71:0]));
   FD XLXI_8 (.C(clk), 
              .D(mrst), 
              .Q(clr));
   defparam XLXI_8.INIT = 1'b0;
   FDCE XLXI_9 (.C(clk), 
                .CE(XLXN_16), 
                .CLR(clr), 
                .D(XLXN_16), 
                .Q(match_DUMMY));
   defparam XLXI_9.INIT = 1'b0;
   AND3B1 XLXI_10 (.I0(match_DUMMY), 
                   .I1(match_en), 
                   .I2(XLXN_10), 
                   .O(XLXN_16));
endmodule

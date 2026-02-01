////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 10.1
//  \   \         Application : sch2verilog
//  /   /         Filename : comparator.vf
// /___/   /\     Timestamp : 01/27/2026 19:07:13
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2verilog.exe -intstyle ise -family spartan3a -w "C:/Documents and Settings/Melvin/My Documents/8-bitAdder/Adder_8bit_sync/Mini_IDS/comparator.sch" comparator.vf
//Design Name: comparator
//Device: spartan3a
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale  100 ps / 10 ps

module COMP8_HXILINX_comparator (EQ, A, B);
    

   output EQ;

   input  [7:0] A;
   input  [7:0] B;

   assign EQ = (A==B) ;

endmodule
`timescale  100 ps / 10 ps

module AND7_HXILINX_comparator (O, I0, I1, I2, I3, I4, I5, I6);
    

   output O;

   input I0;
   input I1;
   input I2;
   input I3;
   input I4;
   input I5;
   input I6;

assign O = I0 && I1 && I2 && I3 && I4 && I5 && I6;

endmodule
`timescale 1ns / 1ps

module comparator(a, 
                  amask, 
                  b, 
                  match);

    input [55:0] a;
    input [6:0] amask;
    input [55:0] b;
   output match;
   
   wire XLXN_16;
   wire XLXN_19;
   wire XLXN_22;
   wire XLXN_25;
   wire XLXN_46;
   wire XLXN_49;
   wire XLXN_65;
   wire XLXN_82;
   wire XLXN_83;
   wire XLXN_84;
   wire XLXN_86;
   wire XLXN_87;
   wire XLXN_88;
   wire XLXN_90;
   
   COMP8_HXILINX_comparator XLXI_1 (.A(a[55:48]), 
                                    .B(b[55:48]), 
                                    .EQ(XLXN_16));
   // synthesis attribute HU_SET of XLXI_1 is "XLXI_1_3"
   COMP8_HXILINX_comparator XLXI_3 (.A(a[47:40]), 
                                    .B(b[47:40]), 
                                    .EQ(XLXN_19));
   // synthesis attribute HU_SET of XLXI_3 is "XLXI_3_4"
   COMP8_HXILINX_comparator XLXI_4 (.A(a[39:32]), 
                                    .B(b[39:32]), 
                                    .EQ(XLXN_22));
   // synthesis attribute HU_SET of XLXI_4 is "XLXI_4_2"
   COMP8_HXILINX_comparator XLXI_5 (.A(a[31:24]), 
                                    .B(b[31:24]), 
                                    .EQ(XLXN_25));
   // synthesis attribute HU_SET of XLXI_5 is "XLXI_5_1"
   COMP8_HXILINX_comparator XLXI_11 (.A(a[7:0]), 
                                     .B(b[7:0]), 
                                     .EQ(XLXN_65));
   // synthesis attribute HU_SET of XLXI_11 is "XLXI_11_6"
   COMP8_HXILINX_comparator XLXI_12 (.A(a[23:16]), 
                                     .B(b[23:16]), 
                                     .EQ(XLXN_46));
   // synthesis attribute HU_SET of XLXI_12 is "XLXI_12_0"
   COMP8_HXILINX_comparator XLXI_13 (.A(a[15:8]), 
                                     .B(b[15:8]), 
                                     .EQ(XLXN_49));
   // synthesis attribute HU_SET of XLXI_13 is "XLXI_13_7"
   OR2B1 XLXI_18 (.I0(amask[6]), 
                  .I1(XLXN_16), 
                  .O(XLXN_90));
   OR2B1 XLXI_19 (.I0(amask[5]), 
                  .I1(XLXN_19), 
                  .O(XLXN_87));
   OR2B1 XLXI_20 (.I0(amask[4]), 
                  .I1(XLXN_22), 
                  .O(XLXN_84));
   OR2B1 XLXI_21 (.I0(amask[3]), 
                  .I1(XLXN_25), 
                  .O(XLXN_83));
   OR2B1 XLXI_22 (.I0(amask[2]), 
                  .I1(XLXN_46), 
                  .O(XLXN_88));
   OR2B1 XLXI_23 (.I0(amask[1]), 
                  .I1(XLXN_49), 
                  .O(XLXN_86));
   OR2B1 XLXI_24 (.I0(amask[0]), 
                  .I1(XLXN_65), 
                  .O(XLXN_82));
   AND7_HXILINX_comparator XLXI_25 (.I0(XLXN_83), 
                                    .I1(XLXN_82), 
                                    .I2(XLXN_84), 
                                    .I3(XLXN_86), 
                                    .I4(XLXN_87), 
                                    .I5(XLXN_88), 
                                    .I6(XLXN_90), 
                                    .O(match));
   // synthesis attribute HU_SET of XLXI_25 is "XLXI_25_5"
endmodule

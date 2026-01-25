`timescale 1 ns / 1 ps

module SyncAdder_32bit_tb;

  reg  [31:0] A_tb, B_tb;
  reg         Ci_tb;
  reg         clk_tb;
  wire [31:0] S_tb;
  wire        Co_tb;

  // Xilinx globals
  reg GSR;
  reg GTS;

  initial begin
    GSR = 1;
    GTS = 0;
    #100;
    GSR = 0;
  end

  assign glbl.GSR = GSR;
  assign glbl.GTS = GTS;

  SyncAdder_32bit DUT (
    .A   (A_tb),
    .B   (B_tb),
    .Ci  (Ci_tb),
    .clk (clk_tb),
    .S   (S_tb),
    .Co  (Co_tb)
  );

  // Clock
  always #10 clk_tb = ~clk_tb;

  initial begin
    clk_tb = 0;
    A_tb   = 0;
    B_tb   = 0;
    Ci_tb  = 0;

    // wait 2 cycles for pipeline to start
    @(posedge clk_tb);
    @(posedge clk_tb);

    // 0 + 0
    A_tb = 32'h00000000;
    B_tb = 32'h00000000;
    Ci_tb = 0;
    @(posedge clk_tb);

    // FFFFFFFF + 0
    A_tb = 32'hFFFFFFFF;
    B_tb = 32'h00000000;
    Ci_tb = 0;
    @(posedge clk_tb);

    // FFFFFFFF + 1
    A_tb = 32'hFFFFFFFF;
    B_tb = 32'h00000001;
    Ci_tb = 0;
    @(posedge clk_tb);

    // 80000000 + 80000000
    A_tb = 32'h80000000;
    B_tb = 32'h80000000;
    Ci_tb = 0;
    @(posedge clk_tb);

    // 7FFFFFFF + 1
    A_tb = 32'h7FFFFFFF;
    B_tb = 32'h00000001;
    Ci_tb = 0;
    @(posedge clk_tb);

    // allow pipeline to drain
    @(posedge clk_tb);
    @(posedge clk_tb);
	 
	  repeat (100000) begin
		 A_tb  = $random;
		 B_tb  = $random;
		 Ci_tb = $random & 1'b1;
		 @(posedge clk_tb);
	  end

	  @(posedge clk_tb);
	  @(posedge clk_tb);
	  $stop;
	end


endmodule

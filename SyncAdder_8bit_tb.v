`timescale 1 ns / 1 ps

module SyncAdder_8bit_tb;

  reg  [7:0] A_tb, B_tb;
  reg        Ci_tb;
  reg        clk_tb;
  wire [7:0] S_tb;
  wire       Co_tb;

  integer i, j;

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

  // DUT
  SyncAdder_8bit DUT (
    .A   (A_tb),
    .B   (B_tb),
    .Ci  (Ci_tb),
    .clk (clk_tb),
    .S   (S_tb),
    .Co  (Co_tb)
  );

  // Clock: 20 ns period
  always #10 clk_tb = ~clk_tb;

  initial begin
    clk_tb = 0;
    A_tb   = 0;
    B_tb   = 0;
    Ci_tb  = 0;

    // wait for reset release
    @(posedge clk_tb);
    @(posedge clk_tb);

    for (i = 0; i < 256; i = i + 1) begin
      for (j = 0; j < 256; j = j + 1) begin

        // set Ci = 0
        A_tb  = i;
        B_tb  = j;
        Ci_tb = 0;
        @(posedge clk_tb);

        // set Ci = 1
        Ci_tb = 1;
        @(posedge clk_tb);

      end
    end

    // Let pipeline drain (2-cycle latency caused a corner case; this now allows for viewing output of A=255 + B=255 + Ci=1)
    @(posedge clk_tb);
    @(posedge clk_tb);

    $stop;   // pause when finished, to inspect waveform
  end

endmodule

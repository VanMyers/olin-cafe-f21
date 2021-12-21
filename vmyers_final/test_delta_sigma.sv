`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_delta_sigma;
parameter IN_BITS = 32;
parameter CLK_HZ = 12_000_000;
parameter CLK_PERIOD_NS = (1_000_000_000/CLK_HZ); // Approximation.
// testing parameters
parameter TARGET_BITS = IN_BITS;
parameter SAMPLE_RATE = CLK_HZ/(2**TARGET_BITS);
parameter TARGET_SAMPLE_RATE = 5_000;
parameter OUT_BITS = $clog2(CLK_HZ/TARGET_SAMPLE_RATE)-1;
parameter NYQUEST = SAMPLE_RATE/2;
parameter SIG_HZ = NYQUEST;
parameter SIG_CLK_HZ = SIG_HZ*(2**IN_BITS);
parameter SIG_CLK_PERIOD_NS = (1_000_000_000/SIG_CLK_HZ); // Approximation.
parameter MAX_CYCLES = 1_000_000;

logic ena;
logic clk;
logic rst;
logic [IN_BITS-1:0] in;
wire out;

logic sig_clk;
logic sig_rst;

always #(CLK_PERIOD_NS/2) clk = ~clk;
always #(SIG_CLK_PERIOD_NS/2) sig_clk = ~sig_clk;

delta_sigma #(.IN_BITS(IN_BITS)) UUT(ena, clk, rst, in, out);

// this could be clocked faster
triangle_generator #(.N(IN_BITS)) signal(.clk(sig_clk),.rst(sig_rst),.ena(1),.out(in));

initial begin
  $dumpfile("delta_sigma.vcd");
  $dumpvars(0, UUT);
  
  $display("Simulating a %0d bit DS DAC",IN_BITS);
  //$display("Resulting signal has effective depth %0d bits",OUT_BITS);
  $display("Resulting precision is %0d bits at %0d Hz.",OUT_BITS,TARGET_SAMPLE_RATE);
  $display("Resulting sampling rate is %0d Hz at %0d bits.",SAMPLE_RATE,TARGET_BITS);
  $display("Nyquest frequency is %0d Hz.",NYQUEST);
  clk = 0;
  sig_clk = 0;
  rst = 1;
  sig_rst = 1;
  ena = 1;

  repeat (2) @(negedge clk);

  sig_rst = 0;
  rst = 0;

  repeat (5000) @(negedge clk);
  ena = 0;
  repeat (100) @(negedge clk);

  $finish;  

end

// Put a timeout to make sure the simulation doesn't run forever.
initial begin
  repeat (MAX_CYCLES) @(posedge clk);
  $display("Test timed out.");
  $finish;
end

endmodule
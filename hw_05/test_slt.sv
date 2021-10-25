`timescale 1ns/1ps
`default_nettype none
module test_adders;

parameter N = 32;

int errors = 0;

logic signed [N-1:0] a, b;
wire comp;

slt #(.N(N)) UUT(.a(a),.b(b),.comp(comp));

logic correct_comp;

always_comb begin : behavioural_solution_logic
  correct_comp = a < b;
end

task print_io;
  $display("%d < %d = %d  (%d)", a, b, comp, correct_comp);
endtask

initial begin
  //$dumpfile("adder_n.vcd");
  //$dumpvars(0, UUT);
  
  $display("Specific interesting tests.");
  
  // Zero < zero 
  a = 0;
  b = 0;
  #1 print_io();

  // -1 < 0
  a = -1;
  b = 0;
  #1 print_io();

  // max < neg
  a = 2**(N-2);
  b = -5;
  #1 print_io();

  // min < pos
  a = (2**(N-1));
  b = 14;
  #1 print_io();

  $display("Random testing.");
  for (int i = 0; i < 10; i = i + 1) begin : random_testing
    a = $random();
    b = $random();
    #1 print_io();
  end
  if (errors !== 0) begin
    $display("---------------------------------------------------------------");
    $display("-- FAILURE                                                   --");
    $display("---------------------------------------------------------------");
    $display(" %d failures found, try again!", errors);
  end else begin
    $display("---------------------------------------------------------------");
    $display("-- SUCCESS                                                   --");
    $display("---------------------------------------------------------------");
  end
  $finish;
end

always @(a,b) begin
  assert(comp === correct_comp) else begin
    $display("  ERROR: answer should be %d, is %d", correct_comp, comp);
    errors = errors + 1;
  end
end

endmodule
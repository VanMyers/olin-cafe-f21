/*
  Outputs a pulse generator with a period of "ticks".
  out should go high for one cycle ever "ticks" clocks.
*/
module pulse_generator(clk, rst, ena, ticks, out);

parameter N = 8;
input wire clk, rst, ena;
input wire [N-1:0] ticks;
output logic out;

logic [N-1:0] counter;
logic counter_comparator;
logic counter_rst;

counter #(.N(N)) count(.clk(clk),.rst(counter_rst),.ena(ena),.out(counter));

always_comb begin : comparator
  counter_comparator = (counter == ticks-1);
  counter_rst = counter_comparator | rst;
  out = counter_comparator & ena;
end


endmodule

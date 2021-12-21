module decimation_filter(ena, in_clk, out_clk, rst, in, out); 
parameter OUT_BITS = 12;

input wire ena;
input wire in_clk;
input wire out_clk;
input wire rst;
input wire in;
output logic [OUT_BITS-1:0] out;

logic rst_ones;
logic [OUT_BITS-1:0] ones_d;
logic [OUT_BITS-1:0] ones_q;
always_comb begin
  rst_ones = rst|out_clk; // reset count at the end of an interval
  ones_d = ones_q+in; // count ones in the bitstream
end

register #(.N(OUT_BITS)) ones(.clk(in_clk),.ena(ena),.rst(rst),.d(ones_d),.q(ones_q));

// output only changes at the end of each interval
register #(.N(OUT_BITS)) ready(.clk(out_clk),.ena(ena),.rst(rst),.d(ones_q),.q(out));

endmodule

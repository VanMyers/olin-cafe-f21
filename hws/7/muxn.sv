module muxn(sel, inputs, out);
parameter N = 32; // number of inputs
parameter W = 32; // width

input wire [N*W-1:0] inputs;
input wire [$clog2(N)-1:0] sel;
output logic [W-1:0] out;
logic [W-1:0] out_left, out_right;

generate
  if (N > 2) begin
    muxn #(.N(N/2), .W(W)) left(sel[$clog2(N)-2:0], inputs[N*W-1:(N*W)/2], out_left[W-1:0]);
    muxn #(.N(N/2), .W(W)) right(sel[$clog2(N)-2:0], inputs[(N*W)/2-1:0], out_right[W-1:0]);
    // the tree part
    muxn #(.N(2), .W(W)) root(sel[$clog2(N)-1], {out_left[W-1:0], out_right[W-1:0]}, out[W-1:0]); // MSB as select
  end else begin
    always_comb begin
      out[W-1:0] = sel ? inputs[W*2-1:W] : inputs[W-1:0];
    end
  end
endgenerate
endmodule
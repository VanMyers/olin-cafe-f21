module muxn(sel, inputs, out)

parameter N = 2;
parameter WIDTH = 1;

input wire [$clog2(N):0] sel;
input wire [N*WIDTH-1:0] inputs;
output wire [WIDTH-1:0] out;

wire [WIDTH-1:0] top_mux,bottom_mux;
generate
  genvar i;
  for(i = 0; i < N; i++) begin : tree_mux
    mux2 

endmodule
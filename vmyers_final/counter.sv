module counter(clk, rst, ena, out);

parameter N = 8;
input wire clk, rst, ena;
output logic [N-1:0] out;

logic [N-1:0] d;
always_comb d = out+1;

register #(.N(N)) value(.clk(clk),.ena(ena),.rst(rst),.d(d),.q(out));

endmodule
module mux2(s,a,b,out);

parameter WIDTH = 1;

input wire s;
input wire [WIDTH-1:0] a,b;
output wire [WIDTH-1:0] out;

assign out = s ? a : b;
endmodule
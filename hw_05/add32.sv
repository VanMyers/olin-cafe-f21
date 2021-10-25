module add32(a, b, c_in, sum, c_out);

input wire [31:0] a,b;
input wire c_in;
output wire sum;
output c_out;

addern #(.N(32)) adder32 (a, b, c_in, sum, c_out);

endmodule
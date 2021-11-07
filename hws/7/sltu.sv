module sltu(a, b, comp);

parameter N = 32;

input wire [N-1:0] a, b;
output logic comp;


logic [N-1:0] sum;
logic c_out;
adder_n #(.N(N)) subtractor(.a(a), .b(~b), .c_in(1), .sum(), .c_out(c_out));

always_comb comp = ~c_out;

endmodule
module slt(a, b, comp);

parameter N = 32;

input wire [N-1:0] a, b;
output logic comp;


logic [N-1:0] sum;
addern #(.N(N)) subtractor(.a(a), .b(~b), .c_in(1), .sum(sum), .c_out());

// we only need to check the difference if signs are the same
logic neg_pos;
logic same_sign;

always_comb begin
same_sign = a[N-1] ~^ b[N-1];
neg_pos = a[N-1]&~b[N-1];
comp = same_sign ? sum[N-1] : neg_pos;
end

endmodule
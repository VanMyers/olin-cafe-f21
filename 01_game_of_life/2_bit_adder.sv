module 2_bit_adder(a, b, Cout, sum);

input wire [1:0] a;
input wire [1:0] b;
output logic Cout;
output logic [1:0] sum;

wire carry0;
full_adder adder0(a[0],b[0],0,carry0,sum[0]);
full_adder adder1(a[1],b[1],carry0,Cout,sum[1]);


endmodule
module 3_bit_adder (a, b, Cout, sum)

input wire [2:0] a;
input wire [2:0] b;
output logic Cout;
output logic [2:0] sum;

logic carry0, carry1;
full_adder adder0(a[0],b[0],0,carry0,sum[0]);
full_adder adder1(a[1],b[1],carry0,carry1,sum[1]);
full_adder adder1(a[2],b[2],carry1,carry2,sum[2]);
full_adder adder2(a[3],b[3],carry2,Cout,sum[3]);



endmodule
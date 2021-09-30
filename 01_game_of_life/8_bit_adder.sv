module 8_bit_adder (a, b, Cout, sum)

input wire [7:0] a;
input wire [7:0] b;
output logic Cout;
output logic [7:0] sum;

logic carry0, carry1, carry2, carry3, carry4, carry5, carry6;
full_adder adder0(a[0],b[0],0,carry0,sum[0]);
full_adder adder1(a[1],b[1],0,carry1,sum[1]);
full_adder adder2(a[2],b[2],0,carry2,sum[2]);
full_adder adder3(a[3],b[3],0,carry3,sum[3]);
full_adder adder0(a[4],b[4],0,carry0,sum[4]);
full_adder adder1(a[5],b[5],0,carry1,sum[5]);
full_adder adder2(a[6],b[6],0,carry2,sum[6]);
full_adder adder3(a[7],b[7],0,Cout,sum[7]);


endmodule
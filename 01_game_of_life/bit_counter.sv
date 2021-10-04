module bit_counter (in, num);

input wire [7:0] in;
output logic [3:0] num;

wire gnd = 0;

// first layer counts pairs of wires
wire [1:0] count0, count1, count2, count3;
full_adder counter0(in[0],in[1],gnd,count0[1],count0[0]);
full_adder counter1(in[2],in[3],gnd,count1[1],count1[0]);
full_adder counter2(in[4],in[5],gnd,count2[1],count2[0]);
full_adder counter3(in[6],in[7],gnd,count3[1],count3[0]);

// second layer adds two bit counts
wire [2:0] sum0, sum1;
two_bit_adder adder0(count0,count1,sum0[2],sum0[1:0]);
two_bit_adder adder1(count2,count3,sum1[2],sum1[1:0]);

// third layer produces final count
three_bit_adder total(sum0,sum1,num[3],num[2:0]);

endmodule
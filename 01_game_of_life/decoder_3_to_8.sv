module decoder_3_to_8(ena, in, out);

input wire ena;
input wire [2:0] in;
output logic [7:0] out;

logic [3:0] ena1;
decoder_1_to_2 switcher(ena,in[2],ena1);
decoder_2_to_4 dec1(ena1[1],in[1:0],out[7:4]);
decoder_2_to_4 dec0(ena1[0],in[1:0],out[3:0]);

endmodule
module decoder_2_to_4(ena, in, out);

  input wire ena;
  input wire [1:0] in;
  output logic [3:0] out;

  logic [1:0] ena1;
  decoder_1_to_2 switcher(ena,in[1],ena1);
  decoder_1_to_2 dec1(ena1[1],in[0],out[3:2]);
  decoder_1_to_2 dec0(ena1[0],in[0],out[1:0]);


endmodule
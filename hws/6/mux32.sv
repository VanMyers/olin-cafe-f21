`timescale 1ns/1ps
`default_nettype none
module mux32(sel, inputs, out);
input wire [4:0] sel;
input wire [32*32-1:0] inputs;
output logic [31:0] out;

muxn #(.N(32),.W(32)) mux(.sel(sel),.inputs(inputs),.out(out));

endmodule
`default_nettype wire

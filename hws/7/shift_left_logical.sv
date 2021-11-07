module shift_left_logical(in, shamt, out);

parameter N = 32; // only used as a constant! Don't feel like you need to a shifter for arbitrary N.

input wire [N-1:0] in;            // the input number that will be shifted left. Fill in the remainder with zeros.
input wire [$clog2(N)-1:0] shamt; // the amount to shift by (think of it as a decimal number from 0 to 31). 
output logic [N-1:0] out;       

logic [N*N-1:0] shift_array;
always_comb shift_array[N-1:0] = in;
// could use modular arithmetic instead of loop but I already wrote this.
generate
  genvar i;
  for(i = 0; i < N; i++) begin : shift_wires
    always_comb shift_array[N*(i+1)-1:N*i] = {in[N-1-i:0], {i{1'b0}}};
  end
endgenerate

muxn #(.N(N),.W(N)) mux(.sel(shamt),.inputs(shift_array),.out(out));

endmodule
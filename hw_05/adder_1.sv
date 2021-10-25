/*
  a 1 bit addder that we can daisy chain for 
  ripple carry adders
*/

module adder_1(a, b, c_in, sum, c_out);

input wire a, b, c_in;
output logic sum, c_out;

logic p, q;

always_comb begin
    p = a ^ b;
    q = a & b;
    sum = c_in ^ p;
    c_out = (c_in & p) | q;
end

endmodule

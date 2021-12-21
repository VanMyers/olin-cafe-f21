module delta_sigma(ena, clk, rst, in, out); // may use another clock, alternatively
                                            // build in divider/multipliers
parameter IN_BITS = 12;

input wire ena;
input wire clk;
input wire rst;
input wire [IN_BITS-1:0] in;
output logic out;

logic [IN_BITS-1:0] error_d;
logic [IN_BITS-1:0] error_q;

register #(.N(IN_BITS)) qe(.clk(clk),.ena(ena),.rst(rst),.d(error_d),.q(error_q));

always_comb begin
  out = in >= error_q;
  error_d = error_q - in + out;
end

endmodule

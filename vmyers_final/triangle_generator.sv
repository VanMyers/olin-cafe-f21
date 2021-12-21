// Generates "triangle" waves (counts from 0 to 2^N-1, then back down again)
// The triangle should increment/decrement only if the ena signal is high, and hold its value otherwise.
module triangle_generator(clk, rst, ena, out);

parameter N = 8;
input wire clk, rst, ena;
output logic [N-1:0] out;

typedef enum logic {COUNTING_UP, COUNTING_DOWN} state_t;
state_t state;
logic carry;

// I really wanted to make using carry as the signal work but it was a cycle too slow
always_ff @(posedge clk) begin
  if (rst) begin
    state <= 0;
  end
  else begin
    if (ena) begin
      if (d == 0) begin
        state <= 1;
      end
      else begin
        if (d == 2**(N)-1) begin
        state <= 0;
        end
      end
    end
  end
end

logic [N-1:0] d;
always_comb d = state ? out+1 : out-1;

register #(.N(N)) value(.clk(clk),.ena(ena),.rst(rst),.d(d),.q(out));

endmodule
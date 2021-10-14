`default_nettype none

module conway_cell(clk, rst, ena, state_0, state_d, state_q, neighbors);
  input wire clk;
  input wire rst;
  input wire ena;

  input wire state_0;
  output logic state_d;
  output logic state_q;

  input wire [7:0] neighbors;
  logic [3:0] living_neighbors;

// Count living neighbors
bit_counter living(neighbors, living_neighbors);

// The Conway's game logic
logic stay_alive;

always_comb begin
  stay_alive = state_q & (living_neighbors == 4'b0010);
  state_d = stay_alive | (living_neighbors == 4'b0011);
end

always_ff @(posedge clk) begin
  state_q <= rst? state_0 : (ena? state_d : state_q);
end

endmodule
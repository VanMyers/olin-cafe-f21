module rgb(rst, button, out);

parameter T = 4;

input wire rst, button;
output logic [2:0] out;


debounce #(.BOUNCE_TICKS(T)) clean(
  .clk(clk), .rst(rst), .bouncy_in(), .debounced_out())

always_comb begin : state_logic
  count_done = &(counter);
end
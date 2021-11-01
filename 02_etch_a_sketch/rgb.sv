module rgb(clk, rst, button, out);
// advance between colors of the LED on button press, reset to red.
parameter T = 10;
input wire clk, rst, button;
output logic [2:0] out;

enum logic [2:0] {
  RED = 3'b100,
  GREEN= 3'b010,
  BLUE = 3'b001
} state;

wire debounced_out;
debouncer #(.BOUNCE_TICKS(T)) clean(
  .clk(clk), .rst(rst), .bouncy_in(button), .debounced_out(debounced_out));


always_ff @(posedge clk) begin : fsm_logic
  if (rst) begin
    state <= RED;
  end else begin
    case(state)
      RED : begin
        state <= GREEN;
      end
      GREEN : begin
        state <= BLUE;
      end
      BLUE : begin
        state <= RED;
      end
      default : state <= RED;
    endcase
  end
end

always_comb out = state;
endmodule
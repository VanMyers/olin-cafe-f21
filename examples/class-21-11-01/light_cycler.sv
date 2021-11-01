module light_sequencer(clk, buttons, rgb);

input wire clk;
input wire [1:0] buttons;
output logic [2:0] rgb;

logic rst; always_comb rst = buttons[0];

wire debounced;
debouncer #(.BOUNCE_TICKS(250)) DEBOUNCE(
  .clk(clk), .rst(rst),
  .bouncy_in(buttons[1]),
  .debounced_out(debounced)
);

wire positive_edge;
edge_detector_moore EDGE_DETECTOR(
  .clk(clk), .rst(rst),
  .in(debounced), 
  .positive_edge(positive_edge)
);

enum logic {
  S_STOP,
  S_GO
} state;

// fsm logic
always_ff @(posedge clk) begin : fsm_logic
  if(rst) begin
    state <= state.first; // picks first thing in the enum
  end else begin
    if(positive_edge) begin
      case (state)
        S_STOP : begin
          state <= S_GO;
        end
        S_GO : begin
          state <= S_STOP;
        end
      endcase
    end
  end
end

always_comb begin : moore_outputs
  case(state)
    S_RED: rgb = 3'b110;
    S_GREEN: rgb = 3'b101;
    S_BLUE: rgb = 3'b011;
    S_ERROR: rgb = 3'b000;
  endcase
end

endmodule
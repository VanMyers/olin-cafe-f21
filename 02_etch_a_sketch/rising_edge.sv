module rising_edge(clk, rst, in, out);
input wire clk, rst, in;
output logic out;

enum logic [1:0] {
  LOW = 2'b00,
  RISING = 2'b01,
  HIGH = 2'b10,
  FALLING = 2'b11
} state;

always_ff @(posedge clk) begin : edge_detector
  if (rst) begin
    state <= LOW;
  end else begin
    case(state)
      LOW : begin
        if(in) begin
          state <= RISING;
        end
      end
      RISING : begin
        if(in) begin
          state <= HIGH;
        end
      end
      HIGH : begin
        if(~in) begin
          state <= FALLING;
        end
      end
      FALLING : begin
        if(~in) begin
          state <= LOW;
        end
      end
    endcase
  end
end

always_comb out = (state == RISING);

endmodule

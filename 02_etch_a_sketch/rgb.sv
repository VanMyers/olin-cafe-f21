module rgb(rst, button, out);

parameter T = 4;

input wire rst, button;
output logic [2:0] out;

logic [T-2:0] counter;

counter #(.N(N)) count(.clk(clk),.rst(rst_cnt),.ena(ena_cnt),.out(counter));

always_comb begin : state_logic
    count_done = &(counter);
end
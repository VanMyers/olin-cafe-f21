`timescale 1ns/1ps
`default_nettype none

`include "alu_types.sv"

module alu(a, b, control, result, overflow, zero, equal);
parameter N = 32; // Don't need to support other numbers, just using this as a constant.

input wire [N-1:0] a, b; // Inputs to the ALU.
input alu_control_t control; // Sets the current operation.
output logic [N-1:0] result; // Result of the selected operation.

output logic overflow; // Is high if the result of an ADD or SUB wraps around the 32 bit boundary.
output logic zero;  // Is high if the result is ever all zeros.
output logic equal; // is high if a == b.

// Use *only* structural logic and previously defined modules to implement an 
// ALU that can do all of operations defined in alu_types.sv's alu_op_code_t!
logic [N-1:0] sll,srl,sra,sum,difference;
logic slt, sltu;
// Make sure everything is the right size
wire [N-2:0] fill = {N-1 {1'b0}};
logic [$clog2(N)-1:0] b_trim;
logic [N-1-$clog2(N):0] b_extra;
logic shift_overflow;
logic [N-1:0] not_overflowed;


always_comb begin : trim
  b_trim = b[$clog2(N)-1:0];
  b_extra = b[N-1:$clog2(N)];
  shift_overflow = |(b_extra);
  not_overflowed = {N{~shift_overflow}};
end

shift_left_logical #(.N(N)) SLL(.in(a),.shamt(b_trim),.out(sll));
shift_right_logical #(.N(N)) SRL(.in(a),.shamt(b_trim),.out(srl));
shift_right_arithmetic #(.N(N)) SRA(.in(a),.shamt(b_trim),.out(sra));
adder_n #(.N(N)) SUM(.a(a),.b(b),.c_in(0),.sum(sum),.c_out());
adder_n #(.N(N)) DIFFERENCE(.a(a),.b(~b),.c_in(1),.sum(difference),.c_out());
slt #(.N(N)) SLT(.a(a),.b(b),.comp(slt));
sltu #(.N(N)) SLTU(.a(a),.b(b),.comp(sltu));

// I feel like this might be behavioral but this is also just a mux
always_comb begin : alu_logic
  case (control) // This is how you make  a MUX.
      ALU_AND: result = a & b;
      ALU_OR : result = a | b;
      ALU_XOR : result = a ^ b;
      ALU_SLL : result = sll&not_overflowed;
      ALU_SRL : result = srl&not_overflowed;
      ALU_SRA : result = sra&not_overflowed;
      ALU_ADD : result = sum;
      ALU_SUB : result = difference;
      ALU_SLT : result = {fill,slt};
      ALU_SLTU : result = {fill,sltu};
      default : result = 0;
  endcase

  zero = &(~result);
  equal = &(a~^b);

  case (control) 
    ALU_SLTU, ALU_SLT, ALU_SUB: begin
      // only overflow when the sign is different
      overflow = (a[N-1] ^ b[N-1]) & (a[N-1] ^ difference[N-1]); 
    end
    ALU_ADD : begin
      // only overflows when the sign is the same
      overflow = (a[N-1] ~^ b[N-1]) & (a[N-1] ^ sum[N-1]);
    end
    default: overflow = 0;
  endcase
end

endmodule
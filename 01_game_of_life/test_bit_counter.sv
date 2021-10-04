`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_bit_counter;
    logic [7:0] in;
    logic [3:0] num;

    bit_counter UUT(in,num);

    initial begin
        $dumpfile("bit_counter.vcd");
        $dumpvars(0, UUT);

        in = 0;
        $display("in | num");
        for (int i = 0; i < 256; i = i + 1) begin
            in = i[7:0];
            #1 $display("%8b | %4b", in, num);
        end

        $finish;
    end
endmodule
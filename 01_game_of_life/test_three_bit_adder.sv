`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_three_bit_adder;
    logic [2:0] a;
    logic [2:0] b;
    logic [3:0] out;

    three_bit_adder UUT(a, b, out[3], out[2:0]);

    initial begin
        // collect waveforms
        $dumpfile("three_bit_adder.vcd");
        $dumpvars(0, UUT);

        $display("a b | out");
        for (int i = 0; i < 8; i = i + 1) begin
            a = i[2:0];
            for (int j = 0; j < 8; j = j +1) begin
                b = j[2:0];
                #1 $display("%3b %3b | %4b", a, b, out);
            end
        end

        $finish;
    end
    
endmodule

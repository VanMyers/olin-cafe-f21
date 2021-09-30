`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_8_bit_adder;
    logic [7:0] a;
    logic [7:0] b;
    logic [8:0] out;

    8_bit_adder UUT(a[0], b[1], out[8], out[7:0]);

    initial begin
        // collect waveforms
        $dumpfile("8_bit_adder.vcd");
        $dumpvars(0, UUT);

        in = 0;
        $display("in | out");
        for (int i = 0; i < 128; i = i + 1) begin
            a = i[7:0];
            for (int j = 0; j < 128; j = j +1) begin
                b = j[7:0];
                #1 $display("%8b %8b | %9b", a, b, out);
            end
        end

        $finish;
    end
    
endmodule

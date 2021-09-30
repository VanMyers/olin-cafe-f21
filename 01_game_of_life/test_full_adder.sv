`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_full_adder;
    logic [2:0] in;
    logic [1:0] out;

    full_adder UUT(in[0], in[1], in[2], out[1], out[0]);

    initial begin
        // collect waveforms
        $dumpfile("full_adder.vcd");
        $dumpvars(0, UUT);

        in = 0;
        $display("in | out");
        for (int i = 0; i < 8; i = i + 1) begin
            in = i[2:0];
            #1 $display("%2b | %2b", in, out);
        end

        $finish;
    end
    
endmodule

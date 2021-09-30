module full_adder(a, b, Cin, Cout, sum);

input wire a;
input wire b;
input wire Cin;
output logic Cout;
output logic sum;

logic p, q;

always_comb begin
    p = a ^ b;
    q = a & b;
    sum = Cin ^ p;
    Cout = (Cin & p) | q;
end
    
endmodule
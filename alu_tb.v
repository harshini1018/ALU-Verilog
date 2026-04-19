// test bench
`timescale 1ns/1ps

module alu_tb;

reg [3:0] A, B;
reg [2:0] sel;
wire [3:0] out;
wire carry_out, zero, overflow , sign, parity ;

// Instantiate ALU
alu_4bit uut (
    .A(A),
    .B(B),
    .sel(sel),
    .out(out),
    .carry_out(carry_out),
    .zero(zero),
    .overflow(overflow),
    .parity(parity),
    .sign(sign)
);

initial begin
    $display("A    B    sel | out carry_out zero overflow parity sign");
    $monitor("%h %h %b | %h %b %b %b %b %b", A, B, sel, out, carry_out, zero, overflow , parity, sign);

    // ADD
    A = 4'b0101; B = 4'b0011; sel = 3'b000; #10;

    // SUB
    A = 4'b0101; B = 4'b0011; sel = 3'b001; #10;

    // AND
    A = 4'b1100; B = 4'b1010; sel = 3'b010; #10;

    // OR
    A = 4'b1100; B = 4'b1010; sel = 3'b011; #10;

    // XOR
    A = 4'b1100; B = 4'b1010; sel = 3'b100; #10;

    // NOT
    A = 4'b1100; B = 4'b0000; sel = 3'b101; #10;

    // SHIFT LEFT
    A = 4'b1011; B = 4'b0000; sel = 3'b110; #10;

    // SHIFT RIGHT
    A = 4'b1011; B = 4'b0000; sel = 3'b111; #10;

    // ADD overflow (positive + positive → negative)
    A = 4'b0111; B = 4'b0001; sel = 3'b000; #10;

    // SUB overflow
    A = 4'b1000; B = 4'b0001; sel = 3'b001; #10;

    // Carry case
    A = 4'b1111; B = 4'b0001; sel = 3'b000; #10;
    
    // Zero case
    A = 4'b0011; B = 4'b0011; sel = 3'b001; #10;

    // left shift MSB
    A = 4'b1000; B = 4'b0000; sel = 3'b110; #10; 

     // right shift LSB
    A = 4'b0001; B = 4'b0000;  sel = 3'b111; #10;


    $finish;
end
initial begin 
     $dumpfile("wave.vcd");
     $dumpvars(0, alu_tb);

end     

endmodule

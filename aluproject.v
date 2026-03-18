 module alu_4bit (
    input [3:0] A, B,
    input [2:0] sel,
    output reg [3:0] out,
    output reg carry_out,
    output zero,
    output reg overflow
);

// Zero flag
assign zero = (out == 4'b0000);

always @(*) begin
    carry_out = 0;
    overflow = 0;

    case(sel)
        3'b000: begin // ADD
            {carry_out, out} = A + B;
            overflow = (A[3] == B[3]) && (out[3] != A[3]);
        end

        3'b001: begin // SUB
            {carry_out, out} = A - B;
            overflow = (A[3] != B[3]) && (out[3] != A[3]);
        end

        3'b010: out = A & B;   // AND
        3'b011: out = A | B;   // OR
        3'b100: out = A ^ B;   // XOR
        3'b101: out = ~A;      // NOT

        3'b110: begin          // SHIFT LEFT
            out = A << 1;
            carry_out = A[3];
        end

        3'b111: begin          // SHIFT RIGHT
            out = A >> 1;
            carry_out = A[0];
        end

        default: out = 4'b0000;
    endcase
end

endmodule
 
`timescale 1ns/1ps

module alu_tb;

reg [3:0] A, B;
reg [2:0] sel;
wire [3:0] out;
wire carry_out, zero, overflow;

// Instantiate ALU
alu_4bit uut (
    .A(A),
    .B(B),
    .sel(sel),
    .out(out),
    .carry_out(carry_out),
    .zero(zero),
    .overflow(overflow)
);

initial begin
    $display("A    B    sel | out carry_out zero overflow");
    $monitor("%h %h %b | %h %b %b %b", A, B, sel, out, carry_out, zero, overflow);

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
    A = 4'b1100; sel = 3'b101; #10;

    // SHIFT LEFT
    A = 4'b1011; sel = 3'b110; #10;

    // SHIFT RIGHT
    A = 4'b1011; sel = 3'b111; #10;

    // ADD overflow (positive + positive → negative)
    A = 4'b0111; B = 4'b0001; sel = 3'b000; #10;

    // SUB overflow
    A = 4'b1000; B = 4'b0001; sel = 3'b001; #10;

    // Carry case
    A = 4'b1111; B = 4'b0001; sel = 3'b000; #10;
    
    // Zero case
    A = 4'b0011; B = 4'b0011; sel = 3'b001; #10;

    // left shift MSB
    A = 4'b1000; sel = 3'b110; #10; 

     // right shift LSB
    A = 4'b0001; sel = 3'b111; #10;


    $finish;
end
initial begin 
     $dumpfile("wave.vcd");
     $dumpvars(0, alu_tb);

end     

endmodule
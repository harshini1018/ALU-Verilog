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
 

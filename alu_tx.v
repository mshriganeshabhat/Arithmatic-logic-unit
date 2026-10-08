module alu_8bit (
    input wire [7:0] A, // 8-bit Input A
    input wire [7:0] B, // 8-bit Input B
    input wire [2:0] ALU_Sel, // 3-bit Operation Select
    output reg [7:0] ALU_Out, // 8-bit ALU Output
    output reg CarryOut, // Carry Flag
    output reg Zero, // Zero Flag
    output reg Overflow // Overflow Flag
);

    reg [8:0] tmp; // 9-bit temporary register to calculate carry/overflow

    always @(*) begin
        CarryOut = 1'b0;
        Overflow = 1'b0;
        case(ALU_Sel)
            3'b000: begin // Addition
                tmp = A + B;
                ALU_Out = tmp[7:0];
                CarryOut = tmp[8];
                // Overflow check for signed addition
                Overflow = ((A[7] == B[7]) && (ALU_Out[7] != A[7]));
            end
            3'b001: begin // Subtraction
                tmp = A - B;
                ALU_Out = tmp[7:0];
                CarryOut = tmp[8];
                // Overflow check for signed subtraction
                Overflow = ((A[7] != B[7]) && (ALU_Out[7] != A[7]));
            end
            3'b010: begin // Logical AND
                ALU_Out = A & B;
            end
            3'b011: begin // Logical OR
                ALU_Out = A | B;
            end
            3'b100: begin // Logical XOR
                ALU_Out = A ^ B;
            end
            default: ALU_Out = 8'h00;
        endcase
        
        // Zero Flag Check
        Zero = (ALU_Out == 8'h00) ? 1'b1 : 1'b0;
    end
endmodule

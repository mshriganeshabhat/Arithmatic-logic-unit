`timescale 1ns / 1ps

module tb_alu;
    reg [7:0] A;
    reg [7:0] B;
    reg [2:0] ALU_Sel;
    wire [7:0] ALU_Out;
    wire CarryOut;
    wire Zero;
    wire Overflow;

    // Connect to the ALU module
    alu_8bit uut (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Out),
        .CarryOut(CarryOut),
        .Zero(Zero),
        .Overflow(Overflow)
    );

    initial begin
        // Initialize Inputs
        A = 8'h00; B = 8'h00; ALU_Sel = 3'b000;
        #20;
        
        // Test Case 1: Addition (10 + 5 = 15)
        A = 8'd10; B = 8'd5; ALU_Sel = 3'b000;
        #20;
        
        // Test Case 2: Subtraction (20 - 8 = 12)
        A = 8'd20; B = 8'd8; ALU_Sel = 3'b001;
        #20;
        
        // Test Case 3: Subtraction resulting in Zero Flag (15 - 15 = 0)
        A = 8'd15; B = 8'd15; ALU_Sel = 3'b001;
        #20;

        // Test Case 4: Logical AND
        A = 8'b10101010; B = 8'b11110000; ALU_Sel = 3'b010;
        #20;
        
        // Test Case 5: Addition resulting in Carry Out (255 + 1)
        A = 8'd255; B = 8'd1; ALU_Sel = 3'b000;
        #20;

        $finish;
    end
endmodule
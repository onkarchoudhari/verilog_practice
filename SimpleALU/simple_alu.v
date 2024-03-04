`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2024 10:47:16 PM
// Design Name: 
// Module Name: simple_alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module simple_alu #(parameter WIDTH = 4)(input [WIDTH-1:0] a, 
                    input [WIDTH-1:0] b, input [2:0] sel, 
                    output reg [WIDTH-1:0] res, output reg carry, 
                    output reg overflow);
    
    always @* begin
        res = 0;
        carry = 0;
        overflow = 0;
        case (sel)
            3'b000:
                {carry, res} = a + b;
            3'b001: begin
                res = a - b;
                if (b > a)  overflow = 1;
            end
            3'b010: res = a + 1;
            3'b011: res = b + 1;
            3'b100: res = a && b;
            3'b101: res = a || b;
            3'b110: ;
            3'b111: ;
        endcase
    end
endmodule

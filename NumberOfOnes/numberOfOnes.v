`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2024 03:31:27 PM
// Design Name: 
// Module Name: numberOfOnes
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
module numberOfOnes(input [15:0] inp, output reg [4:0] count);
    integer i;
    always @* begin
        count = 4'b0;
        for (i = 0; i < 16; i = i+1) begin
            count = count + inp[i];
        end
    end
endmodule

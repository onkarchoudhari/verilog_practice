`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2024 06:55:15 PM
// Design Name: 
// Module Name: sequence_detector_moore
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
module sequence_detector_moore(
    input ip,
    input clk,
    input resetn,   // asynchronous reset
    output reg op
);
    // detect sequence 10101 using binary-encoding
    
    parameter IDLE = 3'b000, S0 = 3'b001, S1 = 3'b010, S2 = 3'b011, S3 = 3'b100, S4 = 3'b101;
    
    reg [2:0] state;
    reg [2:0] nextstate; 
    
    always @* begin
        nextstate = 3'b0;
        op = 1'b0;
        case (state)
        IDLE:   if (ip) nextstate = S0;
                else    nextstate = IDLE;
        S0:     if (ip) nextstate = S0;
                else    nextstate = S1;
        S1:     if (ip) nextstate = S2;
                else    nextstate = IDLE;
        S2:     if (ip) nextstate = S0;
                else    nextstate = S3;
        S3:     if (ip) nextstate = S4;
                else    nextstate = IDLE;
        S4: begin
                op = 1'b1;    
                if (ip) nextstate = S0;
                else    nextstate = S3;
            end
        endcase
    end
    
    always @ (posedge clk or negedge resetn)
        if (!resetn)    state <= 3'b0;
        else            state <= nextstate;

endmodule
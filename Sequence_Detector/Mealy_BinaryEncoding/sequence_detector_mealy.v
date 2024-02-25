`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2024 09:42:22 PM
// Design Name: 
// Module Name: sequence_detector_mealy
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
module sequence_detector_mealy (
    input ip,
    input clk,
    input resetn,
    output reg op
);
    parameter IDLE = 3'b000, S0 = 3'b001, S1 = 3'b010, S2 = 3'b011, S3 = 3'b100;
    
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
        S3:     if (ip) begin
                    nextstate = S2;
                    op = 1'b1;
                end
                else    nextstate = IDLE;
        endcase
    end
        
    always @ (posedge clk or negedge resetn)
        if (!resetn)    state <= 3'b0;
        else            state <= nextstate;
endmodule

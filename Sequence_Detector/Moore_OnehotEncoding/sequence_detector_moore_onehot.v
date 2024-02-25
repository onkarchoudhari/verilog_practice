`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2024 10:06:44 PM
// Design Name: 
// Module Name: sequence_detector_moore_onehot
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
module sequence_detector_moore_onehot (
    input ip,
    input clk,
    input resetn,   // asynchronous reset
    output reg op
);
    // detect sequence 10101 using onehot-encoding
    
    parameter [5:0] IDLE = 0, S0 = 1, S1 = 2, S2 = 3, S3 = 4, S4 = 5;
    
    reg [5:0] state;
    reg [5:0] nextstate; 
    
    always @* begin
        nextstate = 6'b0;
        op = 1'b0;
        case (1'b1)
        state[IDLE]:    if (ip) nextstate[S0]   = 1'b1;
                        else    nextstate[IDLE] = 1'b1;
        state[S0]:      if (ip) nextstate[S0]   = 1'b1;
                        else    nextstate[S1]   = 1'b1;
        state[S1]:      if (ip) nextstate[S2]   = 1'b1;
                        else    nextstate[IDLE] = 1'b1;
        state[S2]:      if (ip) nextstate[S0]   = 1'b1;
                        else    nextstate[S3]   = 1'b1;
        state[S3]:      if (ip) nextstate[S4]   = 1'b1;
                        else    nextstate[IDLE] = 1'b1;
        state[S4]: begin
                        op = 1'b1;    
                        if (ip) nextstate[S0]   = 1'b1;
                        else    nextstate[S3]   = 1'b1;
        end
        endcase
    end
    
    always @ (posedge clk or negedge resetn)
        if (!resetn) begin
            state <= 6'b0;
            state[IDLE] <= 1'b1;
        end
        else state <= nextstate;

endmodule
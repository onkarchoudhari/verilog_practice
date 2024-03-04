`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2024 08:18:56 PM
// Design Name: 
// Module Name: design_from_waveform
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
module design_from_waveform(
    event_ip,
    strch_ip,
    clk,
    reset,
    out1,
    out2
);
    input event_ip;
    input strch_ip;
    input clk;
    input reset;
    output reg out1;
    output out2;
    
    reg state;
    reg nextstate;
    
    reg strch_pos;
    
    // here assumed that event_ip comes only for 1 clock pulse
    always @* begin
        nextstate = 1'b0;
        out1 = 1'b0;
        case (state)
            1'b0:
                if (event_ip)   nextstate = 1'b1;
                else            nextstate = 1'b0;
            1'b1: begin
                out1 = 1'b1;
                if (strch_ip)   nextstate = 1'b1;
                else            nextstate = 1'b0;
            end
        endcase
    end
    
    always @ (negedge clk)
        if (reset)  state <= 1'b0;
        else        state <= nextstate;
        
    always @ (posedge clk)
        if (reset)  strch_pos <= 1'b0;
        else        strch_pos <= ((state == 1'b1) && (strch_ip));
    
    assign out2 = (state == 1'b1) || strch_pos;
        
endmodule

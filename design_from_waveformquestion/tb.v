`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2024 08:52:47 PM
// Design Name: 
// Module Name: tb
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
module tb();
    reg event_ip_tb;
    reg strch_ip_tb;
    reg clk_tb;
    reg reset_tb;
    wire out1_tb;
    wire out2_tb;
    
    design_from_waveform dut (
        .event_ip(event_ip_tb),
        .strch_ip(strch_ip_tb),
        .clk(clk_tb),
        .reset(reset_tb),
        .out1(out1_tb),
        .out2(out2_tb)
        );
    
    initial begin
        clk_tb = 1'b0; reset_tb = 1'b1; 
        event_ip_tb = 1'b0; strch_ip_tb = 1'b0;
        #10;
        reset_tb = 1'b0;
        #10;
        event_ip_tb = 1'b1;
        #10;
        event_ip_tb = 1'b0;
        #10;
        @(negedge clk_tb);
        strch_ip_tb = 1;
        #20;
        event_ip_tb = 1;
        #10;
        event_ip_tb = 0;
        #30;
        strch_ip_tb = 0;
    end
    
    always #5 clk_tb = ~clk_tb;

endmodule

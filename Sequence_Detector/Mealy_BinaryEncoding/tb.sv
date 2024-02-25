`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2024 09:54:35 PM
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
    reg ip_tb;
    reg clk_tb;
    reg resetn_tb;
    wire op_tb;
    
    parameter LOOPCOUNT = 1000;
    
    // Design under test
    sequence_detector_mealy dut (.ip(ip_tb), .clk(clk_tb), .resetn(resetn_tb), .op(op_tb));
    
    // free running clk
    always #5 clk_tb = ~clk_tb;
    
    initial begin
        clk_tb = 1'b0;
        resetn_tb = 1'b0;
        ip_tb = 1'b0;
        #20;
        resetn_tb = 1'b1;
        
        for (int i = 0; i < LOOPCOUNT; i++) begin
            @ (posedge clk_tb);
            #1 ip_tb = $random;
        end
    end

endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2024 01:04:38 PM
// Design Name: 
// Module Name: dff_tb
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


module dff_tb();
    reg tb_d;
    reg tb_reset;
    reg tb_clk;
    reg tb_enable;
    wire tb_q;
    
    initial begin
        tb_clk = 0; tb_enable = 1;
        forever #5 tb_clk = ~tb_clk;
    end
    
    initial begin
        tb_reset = 1;
        repeat (5) @(posedge tb_clk);
        tb_reset = 0;
    end
       
    initial begin
        #50;
        @(posedge tb_clk) 
            #0.1 tb_d = 1;
        @(posedge tb_clk) 
            #0.1 tb_d = 0;
    end 
    
    // DESIGN
    dff dut (.d(tb_d), .reset(tb_reset), .clk(tb_clk), .enable(tb_enable), .q(tb_q));
    
endmodule

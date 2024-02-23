`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2024 07:12:06 PM
// Design Name: 
// Module Name: fifomem_tb
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


module fifomem_tb();

    parameter DATAWIDTH = 32;
    parameter ADDRWIDTH = 3;
    
    parameter LOOPCOUNT = 20;
    parameter SEED = 11;
    
    reg [DATAWIDTH-1:0] wdata;
    reg [ADDRWIDTH-1:0] waddr;
    reg wenable;
    reg wclk;
    wire [DATAWIDTH-1:0] rdata;
    reg [ADDRWIDTH-1:0] raddr;
    
    // DUT
    fifomem #(.DATAWIDTH(DATAWIDTH), .ADDRWIDTH(ADDRWIDTH)) 
        fifomem_dut (.*);
    
    // stimulus
    initial begin
        wclk = 0;
        wenable = 0;
        @(posedge wclk);
        
        for (int i = 0; i < LOOPCOUNT; i++) begin
            @(posedge wclk);
            #0.2 waddr = $urandom;
            #0.2 wdata = $urandom;
            #0.2 wenable = 1;
        end
        
        @(posedge wclk);
        #0.2 wenable = 0;
        for (int i = 0; i < 5; i++) begin
            @(posedge wclk);
            #0.2 raddr = $urandom;
        end
    end
    
    // free running clock
    always #5 wclk = ~wclk;

endmodule

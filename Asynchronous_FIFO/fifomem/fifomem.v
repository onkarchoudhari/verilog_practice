`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Onkar Choudhari
// 
// Create Date: 02/22/2024 06:23:30 PM
// Design Name: 
// Module Name: fifomem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//      This fifomem has synchronous writes but asynchronous reads
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module fifomem #(parameter DATAWIDTH = 32, 
                 parameter ADDRWIDTH = 3)( // n=3 as (n+1)=4bits
    wdata, waddr, wenable, wclk,
    rdata, raddr
);
    // write ports
    input [DATAWIDTH-1:0] wdata;
    input [ADDRWIDTH-1:0] waddr;
    input wenable;              // NOTE: This write-enable assumes that it is generated
                                //       after checking fullflag.
                                //       That is, wenable = write & !full in the topmodule
    input wclk;
    // read ports
    output [DATAWIDTH-1:0] rdata;
    input  [ADDRWIDTH-1:0] raddr;
    
    // FIFO Storage element
    reg [DATAWIDTH-1:0] fifobuf [0:((2**ADDRWIDTH)- 1)];
    
    always @ (posedge wclk)
        if (wenable) fifobuf[waddr] <= wdata;

    //always @ (posedge rclk)
    //    rdata = fifobuf[raddr];
    
    assign rdata = fifobuf[raddr];

endmodule
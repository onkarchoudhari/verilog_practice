`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2024 08:26:50 PM
// Design Name: 
// Module Name: sync_w2r
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
module sync_w2r #(parameter PTRWIDTH = 4) (
    wptr,
    rq2wptr,
    rclk,
    rreset
);
    input      [PTRWIDTH-1:0] wptr;
    output reg [PTRWIDTH-1:0] rq2wptr;
    input rclk;
    input rreset;
    
    reg [PTRWIDTH-1:0] rqwptr;
    
    always @ (posedge rclk)
    if (rreset)     {rq2wptr, rqwptr} = 0;
    else            {rq2wptr, rqwptr} = {rqwptr, wptr};
endmodule
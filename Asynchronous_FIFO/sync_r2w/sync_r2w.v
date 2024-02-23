`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2024 08:17:23 PM
// Design Name: 
// Module Name: sync_r2w
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
module sync_r2w #(parameter PTRWIDTH = 4) (
    rptr,
    wq2rptr,
    wclk,
    wreset
);
    input      [PTRWIDTH-1:0] rptr;
    output reg [PTRWIDTH-1:0] wq2rptr;
    input wclk;
    input wreset;
    
    reg [PTRWIDTH-1:0] wqrptr;
    
    always @ (posedge wclk)
    if (wreset)     {wq2rptr, wqrptr} = 0;
    else            {wq2rptr, wqrptr} = {wqrptr, rptr};
    
endmodule

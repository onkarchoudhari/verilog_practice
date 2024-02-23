`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2024 09:01:32 PM
// Design Name: 
// Module Name: rptr_empty
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//      Generates rptr using binary to gray conversion. binary addr is increamented
//      only if rinc signal is high and fifo is not empty.
//      Generates empty signal based on rptr and double-synchronized-writeptr
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module rptr_empty #(parameter PTRWIDTH = 4) (
    // rptr generation
    rptr,
    rinc,
    rclk,
    rreset,
    raddr,  // to FIFOBuf
    // rempty generation
    rempty,
    rq2wptr    
);
    // signals for rptr generation
    output reg [PTRWIDTH-1:0] rptr;
    input rinc;
    input rclk;
    input rreset;
    output [PTRWIDTH-2:0] raddr;
    // signals for rempty generation
    output reg rempty;
    input [PTRWIDTH-1:0] rq2wptr;

    // Generating rptr
    wire [PTRWIDTH-1:0] bnext;
    wire [PTRWIDTH-1:0] gnext;
    reg  [PTRWIDTH-1:0] bin;
    
    assign bnext = bin + (rinc & ~rempty);
    assign gnext = bnext ^ (bnext >> 1);
    
    always @ (posedge rclk)
        if (rreset) {bin, rptr} <= 0;
        else        {bin, rptr} <= {bnext, gnext};

    assign raddr = bin[PTRWIDTH-2:0];

    // Generating empty flag
    wire rempty_val;
    assign rempty_val = (rptr == rq2wptr);
    
    always @ (posedge rclk)
        if (rreset) rempty <= 1'b1;
        else        rempty <= rempty_val;
    
endmodule
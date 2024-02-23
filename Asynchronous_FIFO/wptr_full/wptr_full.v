`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2024 10:21:02 PM
// Design Name: 
// Module Name: wptr_full
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
module wptr_full #(parameter PTRWIDTH = 4) (
    // wptr generation
    wptr,
    winc,
    wclk,
    wreset,
    waddr,  // to FIFOBuf
    // wfull generation
    wfull,
    wq2rptr
);
    // signals for wptr generation
    output reg [PTRWIDTH-1:0] wptr;
    input winc;
    input wclk;
    input wreset;
    output [PTRWIDTH-2:0] waddr;
    // signals for wfull generation
    output reg wfull;
    input [PTRWIDTH-1:0] wq2rptr;

    // Generating rptr
    wire [PTRWIDTH-1:0] bnext;
    wire [PTRWIDTH-1:0] gnext;
    reg  [PTRWIDTH-1:0] bin;
    
    assign bnext = bin + (winc & ~wfull);
    assign gnext = bnext ^ (bnext >> 1);
    
    always @ (posedge wclk)
        if (wreset) {bin, wptr} <= 0;
        else        {bin, wptr} <= {bnext, gnext};

    assign waddr = bin[PTRWIDTH-2:0];

    // Generating full flag
    /*
        Three necessary tests to generate full flag -
        1. MSBs not equal
        2. 2nd MSBs not equal (note that gray codes are reflective after 1st MSB, 
                               0100 to 1100 is just 1 change)
        3. Rest bits equal
    */
    wire wfull_val;
    // NOTE: The below line might throw an error if PTRWIDTH goes below 3
    //       Having such small ptrwidth makes no sense though.
    assign wfull_val = (wptr[PTRWIDTH-1]   != wq2rptr[PTRWIDTH-1]) && 
                       (wptr[PTRWIDTH-2]   != wq2rptr[PTRWIDTH-2]) && 
                       (wptr[PTRWIDTH-3:0] == wq2rptr[PTRWIDTH-3:0]);
    
    always @ (posedge wclk)
        if (wreset) wfull <= 1'b0;
        else        wfull <= wfull_val;

endmodule
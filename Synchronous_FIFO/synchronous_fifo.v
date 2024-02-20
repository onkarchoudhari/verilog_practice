`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Onkar Choudhari 
// 
// Create Date: 02/19/2024 04:42:34 PM
// Design Name: Synchronous FIFO
// Module Name: synchronous_fifo
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
module synchronous_fifo #(parameter DATAWIDTH = 32, parameter ADDRWIDTH = 7)(
    // write ports
    write_clk,
    write_enable,
    write_data,
    // read ports
    read_clk,
    read_enable,
    read_data,
    // flags
    fifo_full,
    fifo_empty,
    reset
);
    // write port
    input write_clk;
    input write_enable;
    input [DATAWIDTH-1:0] write_data;
    // read port
    input read_clk;
    input read_enable;
    output reg [DATAWIDTH-1:0] read_data;
    // flags
    output fifo_full;
    output fifo_empty;
    input reset;
    
    // FIFO Storage Element
    // NOTE: implemented (n+1) bit FIFO; thus storage space = 2**(ADDRWIDTH-1)
    reg [DATAWIDTH-1:0] fifo_mem [(2**(ADDRWIDTH-1) - 1):0];
    
    // addr pointers
    reg [ADDRWIDTH-1:0] waddr;
    reg [ADDRWIDTH-1:0] raddr;
    
    //wire [ADDRWIDTH-1:0] waddrwithoutmsb;
    //wire [ADDRWIDTH-1:0] raddrwithoutmsb;
    
    //assign waddrwithoutmsb = waddr[ADDRWIDTH-2:0];
    //assign raddrwithoutmsb = raddr[ADDRWIDTH-2:0];
    
    // Flags logic
    assign fifo_full  = (waddr[ADDRWIDTH-2:0] == raddr[ADDRWIDTH-2:0]) && (waddr[ADDRWIDTH-1] != raddr[ADDRWIDTH-1]); 
    assign fifo_empty = (waddr[ADDRWIDTH-2:0] == raddr[ADDRWIDTH-2:0]) && (waddr[ADDRWIDTH-1] == raddr[ADDRWIDTH-1]); 
    
    // Writing into the FIFO
    always @ (posedge write_clk) begin
        if (reset)  waddr = 0;
        else
            if (write_enable && !(fifo_full)) begin
                fifo_mem[waddr[ADDRWIDTH-2:0]] <= write_data;
                waddr <= waddr + 1;
            end 
    end
    
    // Reading from the FIFO
    always @ (posedge read_clk) begin
        if (reset)  raddr = 0;
        else
            if (read_enable && !(fifo_empty)) begin
                read_data <= fifo_mem[raddr[ADDRWIDTH-2:0]];
                raddr <= raddr + 1;
            end 
    end
        
endmodule

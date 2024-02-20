`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2024 07:12:49 PM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This TB is completely taken from chipverify website for testing the design.
//              https://www.chipverify.com/verilog/synchronous-fifo
//              PLEASE NOTE: The design is self creation and NOT taken from chipverify
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module tb;
    parameter DATAWIDTH = 32;
    
    // write port
    reg write_clk_tb;
    reg write_enable_tb;
    reg [DATAWIDTH-1:0] write_data_tb;
    // read port
    //reg read_clk;
    wire read_clk_tb;
    reg read_enable_tb;
    wire [DATAWIDTH-1:0] read_data_tb;
    // flags
    wire fifo_full_tb;
    wire fifo_empty_tb;
    reg reset_tb;
    reg stop_tb;
    reg [DATAWIDTH-1:0] rdata;
    
    synchronous_fifo #(.DATAWIDTH(32), .ADDRWIDTH(7)) dut (.write_clk(write_clk_tb),
       .write_enable(write_enable_tb),
       .write_data(write_data_tb),
       .read_clk(read_clk_tb),
       .read_enable(read_enable_tb),
       .read_data(read_data_tb),
       .fifo_full(fifo_full_tb),
       .fifo_empty(fifo_empty_tb),
       .reset(reset_tb));

    always #10 write_clk_tb = ~write_clk_tb;
    assign read_clk_tb = write_clk_tb;

    initial begin
         write_clk_tb = 0;
        //read_clk_tb = 0;
         reset_tb = 1;
         write_enable_tb = 0;
         read_enable_tb = 0;
         stop_tb = 0;
        #50 reset_tb = 0;
    end
    initial begin
         @(posedge write_clk_tb);
        for (int i = 0; i < 50; i = i+1) begin
            // Wait until there is space in fifo
            while (fifo_full_tb) begin
                @(posedge write_clk_tb);
                $display("[%0t] FIFO is fifo_full_tb, wait for reads to happen", $time);
            end;
            // Drive new values into FIFO
             #0.5 write_enable_tb = $random;
             #0.5 write_data_tb = $random;
            $display("[%0t] write_clk_tb i=%0d write_enable_tb=%0d write_data_tb=0x%0h ", $time, i, write_enable_tb, write_data_tb);
            // Wait for next clock edge
             @(posedge write_clk_tb);
        end
         stop_tb = 1;
    end
    initial begin
         @(posedge read_clk_tb);
        while (!stop_tb) begin
            // Wait until there is data in fifo
            while (fifo_empty_tb) begin
                 read_enable_tb = 0;
                $display("[%0t] FIFO is empty, wait for writes to happen", $time);
                 @(posedge read_clk_tb);
            end;
            // Sample new values from FIFO at random pace
             #0.5 read_enable_tb = $random;
             @(posedge read_clk_tb);
             rdata = read_data_tb;
            $display("[%0t] read_clk_tb read_enable_tb=%0d rdata=0x%0h ", $time, read_enable_tb, read_data_tb);
        end
        #500 $finish;
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2024 04:06:49 PM
// Design Name: 
// Module Name: priority_encoder
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
module priority_encoder(
    ip, enable, op
);

    /*
    // Impelementing 8:3 priority encoder
    input [7:0] ip;
    input enable;
    output reg [2:0] op;
    
    always @* begin
        if (enable) begin
            if (ip[7] == 1'b1)          op = 3'b111;
            else if (ip[6] == 1'b1)     op = 3'b110;
            else if (ip[5] == 1'b1)     op = 3'b101;
            else if (ip[4] == 1'b1)     op = 3'b100;
            else if (ip[3] == 1'b1)     op = 3'b011;
            else if (ip[2] == 1'b1)     op = 3'b010;
            else if (ip[1] == 1'b1)     op = 3'b001;
            else if (ip[0] == 1'b1)     op = 3'b000;
        end
        else 
            op = 3'bZZZ;
    end
    */
    
    // Impelementing 4:2 priority encoder
    input [3:0] ip;
    input enable;
    output reg [1:0] op;
    
    always @* begin
        if (enable) begin
            if (ip[3] == 1'b1)          op = 2'b11;
            else if (ip[2] == 1'b1)     op = 2'b10;
            else if (ip[1] == 1'b1)     op = 2'b01;
            else if (ip[0] == 1'b1)     op = 2'b00;
        end
        else                            op = 2'bzz;
    end

endmodule
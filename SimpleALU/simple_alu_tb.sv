`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2024 11:09:59 PM
// Design Name: 
// Module Name: simple_alu_tb
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

parameter TB_WIDTH = 4;

class inputs;
    rand bit [TB_WIDTH-1:0] a;
    rand bit [TB_WIDTH-1:0] b;
    rand bit [2:0] sel;
endclass 
    
module simple_alu_tb();
    
    wire [TB_WIDTH-1:0] tb_res;
    wire tb_carry;
    wire tb_overflow;
    
    inputs ip1;

    initial begin
        
        for (int i = 0; i < 10; i++) begin
            ip1 = new();
            ip1.randomize();
            #1;
            #10;
            $display ("a = %d, b = %d, res = %d, carry = %d, overflow = %d", ip1.a, ip1.b, tb_res, 
                                                                            tb_carry, tb_overflow);
            
            //$display ("a = %d, b = %d", ip1.a, ip1.b);
        end
    end

    // DESIGN
    simple_alu #(.WIDTH(TB_WIDTH)) DUT (.a(ip1.a), .b(ip1.b), .res(tb_res), .carry(tb_carry), .overflow(tb_overflow));
    
endmodule

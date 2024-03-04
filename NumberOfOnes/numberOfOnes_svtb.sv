`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2024 07:51:13 PM
// Design Name: 
// Module Name: numberOfOnes_svtb
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
module numberOfOnes_svtb();
    reg [15:0] tb_inp;
    wire [4:0] tb_op;
    reg [4:0] tb_op_expected;
    
    initial begin
        tb_inp = 16'h2345;  // answer should be = 6
        tb_op_expected = 6;
        #10;
        check_output();
        
        tb_inp = 16'hffff; // answer should be = 16
        tb_op_expected = 16;
        #10;
        check_output();
        
         tb_inp = 16'hfffe; // answer should be = 15
         tb_op_expected = 12;   // PURPOSEFULLY
         #10;
         check_output();
        
        tb_inp = 16'h1248; // answer should be = 4
        tb_op_expected = 4;
        #10;
        check_output();
    end
    
    function void check_output();
//        if (tb_op != tb_op_expected)    $display("WRONG_OUTPUT_RECEIVED!!");
//        else                            $display("Correct output");
        assert (tb_op === tb_op_expected)   $display("Getting wrong answers!");
    endfunction
    /*
    always begin
        tb_inp = $random();
        #10;
    end
    */

    // Design
    numberOfOnes DUT(.inp(tb_inp), .count(tb_op));
endmodule

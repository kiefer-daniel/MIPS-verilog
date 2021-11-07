`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2020 05:13:25 PM
// Design Name: 
// Module Name: pipe_reg
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

module pipe_reg #(parameter WIDTH = 8) (
    input clk, reset,
    input [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
    );
    
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            q <= 0;
        else 
            q <= d;
    end
endmodule
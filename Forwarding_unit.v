`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2020 05:13:25 PM
// Design Name: 
// Module Name: Forwarding_unit
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

module Forwarding_unit(
    input ex_mem_reg_write,
    input [4:0] ex_mem_write_reg_addr,
    input [4:0] id_ex_instr_rs,
    input [4:0] id_ex_instr_rt,
    input mem_wb_reg_write,
    input [4:0] mem_wb_write_reg_addr,
    output reg[1:0] Forward_A,
    output reg[1:0] Forward_B
    );
    
    
    if(ex_mem_reg_write && 
    (ex_mem_write_reg_addr != 0) &&
    (ex_mem_write_reg_addr == id_ex_instr_rs))
    Forward_A = 2'b10;
    
    if(ex_mem_reg_write && 
    (ex_mem_write_reg_addr != 0) &&
    (ex_mem_write_reg_addr == id_ex_instr_rt))
    Forward_B = 2'b10;
    
    if(mem_wb_reg_write && 
    (ex_mem_write_write_reg_addr == id_ex_instr_rs) &&
    )
    Forward_A = 2'b01;
    
    if(mem_wb_reg_write && 
    (ex_mem_write_write_reg_addr == id_ex_instr_rt))
    Forward_B = 2'b01;
    
    
    
    
    
endmodule
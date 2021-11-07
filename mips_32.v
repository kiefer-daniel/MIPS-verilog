`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2020 02:10:56 PM
// Design Name: 
// Module Name: mips_32
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


module mips_32(
    input clk, reset,  
    output[31:0] result
    );
    
    wire reg_dst, reg_write, alu_src, pc_src, mem_read, mem_write, mem_to_reg;  //name control wires here and input into datapath
    wire [3:0] ALU_Control;
    wire [5:0] inst_31_26, inst_5_0;
    wire [25:0] inst_25_0;
    wire [1:0] alu_op;
    wire branch, jump, branchsel;
    //for pipelining
    wire data_hazard;
    /*
    datapath datapath_unit(
        .clk(clk), 
        .reset(reset), 
        .reg_dst(reg_dst), 
        .reg_write(reg_write),
        .alu_src(alu_src), 
        .pc_src(pc_src), 
        .mem_read(mem_read), 
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg), 
        .branch(branch),      // branch instructions
        .branchsel(branchsel),// branch instructions
        .jump(jump),          // jump instructions
        .ALU_Control(ALU_Control), 
        .datapath_result(result),
        .inst_31_26(inst_31_26), 
        .inst_5_0(inst_5_0),
        .inst_25_0(inst_25_0) // jump instruction
        ); */
        
    //instantiating module by name    
    IF_pipe_stage instruction_fetch(
        .clk(clk),
        .reset(reset),
        .en(Data_Hazard),
        .branch_address(branch_address),
        .jump_address(jump_address),
        .branch_taken(branch_taken),
        .jump(jump),
        .pc_plus4(pc_plus4),
        .instr(instr)
        );
        
    Hazard_detection hazard_detection_unit(
        .id_ex_mem_read(id_ex_mem_read),
        .id_ex_destination_reg(id_ex_destination_reg),
        .if_id_rs(if_id_rs),
        .if_id_rt(if_id_rt),
        .branch_taken(branch_taken),
        .jump(jump),
        .Data_Hazard(Data_Hazard),
        .IF_Flush(IF_Flush)
        );
                           
    //instantiate IF/ID pipeline register here
    
    ID_pipe_stage instruction_decode(
        .clk(clk),
        .reset(reset),
        .pc_plus4(pc_plus4),
        .instr(instr),
        .mem_wb_reg_write(mem_wb_reg_write),
        .mem_wb_write_reg_addr(mem_wb_write_reg_addr),
        .mem_wb_write_back_data(mem_wb_write_back_data),
        .Data_Hazard(Data_Hazard),
        .Control_Hazard(Control_Hazard),
        .reg1(reg1),
        .reg2(reg2),
        .imm_value(imm_value),
        .branch_address(branch_address),
        .jump_address(jump_address),
        .branch_taken(branch_taken),
        .destination_reg(destination_reg),
        .mem_to_reg(mem_to_reg),
        .alu_op(alu_op),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .jump(jump)
        );             
                   
    //instantiate ID/EX pipeline register here    
                       
    EX_pipe_stage execution_stage(
        .id_ex_instr(id_ex_instr),
        .reg1(reg1),
        .reg2(reg2),
        .id_ex_imm_value(id_ex_imm_value),
        .ex_mem_alu_result(ex_mem_alu_result),
        .mem_wb_write_back_result(mem_wb_write_back_result),
        .id_ex_alu_src(id_ex_alu_src),
        .Forward_A(Forward_A),
        .Forward_B(Forward_B),
        .alu_in2_out(alu_in2_out),
        .alu_result(alu_result)
        );
                       
    Forwarding_unit Forwarding_unit(
        .ex_mem_reg_write(ex_mem_reg_write),
        .ex_mem_write_reg_addr(ex_mem_write_reg_addr),
        .id_ex_instr_rs(id_ex_instr_rs),
        .mem_wb_reg_write(mem_wb_reg_write),
        .mem_wb_write_reg_addr(mem_wb_write_reg_addr),
        .Forward_A(Forward_A),
        .Forward_B(Forward_B)
        );                       
        
    //instantiate EX/MEM pipeline register here    
                        
    data_memory data_memory(
        .clk(clk),
        .mem_access_addr(ex_mem_alu_result),
        .mem_write_en(mem_write),
        .mem_write_en(ex_mem_mem_write),
        .mem_read_en(ex_mem_mem_read),
        .mem_read_data(mem_read_data)
        );
                        
    //instantiate MEM/WB pipeline register here
    
     mux2 #(.mux_width(32)) writeback_mux (
        .a(mem_wb_alu_result),
        .b(mem_wb_mem_read_data),
        .sel(mem_wb_mem_to_reg),
        .y(write_back_data)
        );  
    //control unit goe sinside instruction decode                      
                        /*   
    control control_unit(
        .reset(reset),
        .opcode(inst_31_26),
        .reg_dst(reg_dst), 
        .mem_to_reg(mem_to_reg),
        .alu_op(alu_op),
        .mem_read(mem_read),  
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .jump(jump),         // jump instruction
        .branch(branch)    // branch instruction
        );*/
        /*
    ALUControl ALU_Control_unit(
        .ALUOp(alu_op),
        .Function(inst_5_0),
        .ALU_Control(ALU_Control));  
        */
        
        
        
endmodule
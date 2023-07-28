`include "../modules/units/instruction_execute_unit.v"
`include "../modules/units/memory_access_unit.v"
`include "../modules/units/instruction_fetch_unit.v"
`include "../modules/units/instruction_decode_unit.v"


`include "../modules/pipeline/EX.v"
`include "../modules/pipeline/ID.v"
`include "../modules/pipeline/IF.v"
`include "../modules/pipeline/MEM.v"

`include "../modules/32bit-Int-controller/controller.v"
`include "../modules/32bit-regfile/reg_file.v"
`include "../modules/wire-module/Wire_module.v"
`include "../modules/mux/mux5x1.v"

`include "../modules/mux/mux2x1.v"
`include "../modules/i-cache/icache.v"
`include "../modules/i-cache/imem_for_icache.v"

`include "../modules/mux/mux4x1.v"
`include "../modules/32bit-Int-Mul/mul.v"
`include "../modules/32bit-Int-Alu/alu.v"
`include "../modules/branch-jump-controller/Branch_jump_controller.v"
`include "../modules/32bit-complementer/complementer.v"

`include "../modules/data-store-controller/Data_store_controller.v"
`include "../modules/data-load-controller/Data_load_controller.v"
`include "../modules/data-cache/dcache.v"
`include "../modules/data-cache/dmem_for_dcache.v"
`include "../modules/cache-controller/Cache_controller.v"



module cpu(
    input clk,
    input reset,
    // what are the uses for these registers ? 
    output [31:0] reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output,
	  // why program counter as a output ? 
    output reg[31:0]pc,

    // what does this do
    output reg[31:0]debug_ins
  );


wire d_mem_r_id_unit_out, d_mem_w_id_unit_out,branch_id_unit_out,jump_id_unit_out,write_reg_en_id_unit_out,mux_d_mem_id_unit_out,mux_inp_2_id_unit_out,mux_complmnt_id_unit_out,mux_inp_1_id_unit_out, rotate_signal_id_unit_out,switch_cache_w_id_unit_out,switch_cache_w_id_reg_out;
wire branch_or_jump_signal,data_memory_busywait,busywait;
wire [31:0] pc_instruction_fetch_unit_out,pc_4_instruction_fetch_unit_out,branch_jump_addres;
wire [31:0]instruction_instruction_fetch_unit_out,pc_if_reg_out, pc_4_if_reg_out, instration_if_reg_out;
wire [31:0] write_data,data_1_id_unit_out,data_2_id_unit_out,mux_1_out_id_unit_out;
wire [4:0] write_address_for_current_instruction_id_unit_out;
wire [1:0]mux_result_id_unit_out;
wire [2:0] alu_op_id_unit_out,fun_3_id_unit_out,alu_op_id_reg_out,fun_3_id_reg_out,fun_3_ex_reg_out;
wire rotate_signal_id_reg_out,mux_complmnt_id_reg_out,mux_inp_2_id_reg_out,mux_inp_1_id_reg_out,mux_d_mem_id_reg_out,write_reg_en_id_reg_out,d_mem_r_id_reg_out,d_mem_w_id_reg_out,branch_id_reg_out,jump_id_reg_out;
wire [31:0] pc_4_id_reg_out,pc_id_reg_out,data_1_id_reg_out,data_2_id_reg_out,mux_1_out_id_reg_out;
wire [1:0] mux_result_id_reg_out;
wire [4:0] write_address_id_reg_out,write_address_ex_reg_out;
wire [31:0]result_iex_unit_out,data_2_ex_reg_out,result_mux_4_ex_reg_out;
wire mux_d_mem_ex_reg_out,write_reg_en_ex_reg_out,d_mem_r_ex_reg_out,d_mem_w_ex_reg_out;
wire [31:0] Register_value_output_wires [31:0];
  
  


always @(*)
begin
  pc<=pc_instruction_fetch_unit_out;
  debug_ins<=instruction_instruction_fetch_unit_out;
end



instruction_fetch_unit if_unit(
  // inputs
  branch_jump_addres, // 32 bits , branch or jump signal, input for mux before the PC
  branch_or_jump_signal,  // 1 bit , control signal for mux before the PC
  data_memory_busywait,  // 1bit busy wait from memory
  reset, 
  clk, 
  // outputs
  pc_instruction_fetch_unit_out, // PC value
  pc_4_instruction_fetch_unit_out, // PC + 4
  instruction_instruction_fetch_unit_out, // 32bits instruction from instruction memory
  busywait
);
  
IF if_reg(
  // inputs
  pc_instruction_fetch_unit_out, // PC
  pc_4_instruction_fetch_unit_out,  // PC + 4
  instruction_instruction_fetch_unit_out, // instruction from instruction mem
  reset, 
  clk,
  busywait,
  branch_or_jump_signal, // branch or jump signal, input for mux before the PC
  // outputs
  pc_if_reg_out, // PC
  pc_4_if_reg_out,  // PC + 4
  instration_if_reg_out // instruction 
  );

instruction_decode_unit id_unit(
  // outputs
  switch_cache_w_id_unit_out,
  reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output,
  write_address_for_current_instruction_id_unit_out,
  rotate_signal_id_unit_out,
  d_mem_r_id_unit_out, 
  d_mem_w_id_unit_out,
  branch_id_unit_out,
  jump_id_unit_out,
  write_reg_en_id_unit_out, 
  mux_d_mem_id_unit_out,
  mux_result_id_unit_out,
  mux_inp_2_id_unit_out, 
  mux_complmnt_id_unit_out,
  mux_inp_1_id_unit_out,
  alu_op_id_unit_out,
  fun_3_id_unit_out,
  data_1_id_unit_out, // read data 1
  data_2_id_unit_out, // read data 2
  mux_1_out_id_unit_out,
  // inputs
  instration_if_reg_out, // instruction
  write_data,
  write_reg_en_ex_reg_out,
  write_address_ex_reg_out,
  clk, 
  reset
);

  
ID id_reg(
  // inputs
  switch_cache_w_id_unit_out,
  rotate_signal_id_unit_out,
  d_mem_r_id_unit_out, 
	d_mem_w_id_unit_out,
  branch_id_unit_out,
  jump_id_unit_out,
  write_reg_en_id_unit_out,
  mux_d_mem_id_unit_out,
	mux_result_id_unit_out,
	mux_inp_2_id_unit_out, 
  mux_complmnt_id_unit_out,
	mux_inp_1_id_unit_out,
  alu_op_id_unit_out,
  fun_3_id_unit_out,
  write_address_for_current_instruction_id_unit_out,
  data_1_id_unit_out,
  data_2_id_unit_out,
  mux_1_out_id_unit_out,
  pc_if_reg_out,
  pc_4_if_reg_out,
  reset,
  clk,
  busywait,
  branch_or_jump_signal,
  // outputs
  rotate_signal_id_reg_out, 
  mux_complmnt_id_reg_out, 
  mux_inp_2_id_reg_out, 
  mux_inp_1_id_reg_out, 
  mux_d_mem_id_reg_out, 
  write_reg_en_id_reg_out,
  d_mem_r_id_reg_out, 
  d_mem_w_id_reg_out, 
  branch_id_reg_out, 
  jump_id_reg_out,
  pc_4_id_reg_out, 
  pc_id_reg_out, 
  data_1_id_reg_out, 
  data_2_id_reg_out, 
  mux_1_out_id_reg_out,
  mux_result_id_reg_out,
  write_address_id_reg_out,
  alu_op_id_reg_out, 
  fun_3_id_reg_out,
  switch_cache_w_id_reg_out
);

  

instruction_execute_unit iex_unit(
  // inputs
  data_1_id_reg_out,
  data_2_id_reg_out,
  pc_id_reg_out,
  pc_4_id_reg_out,
  mux_1_out_id_reg_out,
  mux_result_id_reg_out,
  mux_inp_1_id_reg_out,
  mux_inp_2_id_reg_out,
  mux_complmnt_id_reg_out,
  rotate_signal_id_reg_out,
  branch_id_reg_out,
  jump_id_reg_out,
  fun_3_id_reg_out,
  alu_op_id_reg_out,
  // outputs
  branch_jump_addres,
  result_iex_unit_out,
  branch_or_jump_signal
);

EX ex_reg(
  // inputs
  d_mem_r_id_reg_out, 
  d_mem_w_id_reg_out,
  mux_d_mem_id_reg_out,
  write_reg_en_id_reg_out,
  write_address_id_reg_out,
  fun_3_id_reg_out,
  data_2_id_reg_out,
  result_iex_unit_out,
  reset,
  clk,
  busywait,
  // outputs
  data_2_ex_reg_out, 
  result_mux_4_ex_reg_out,
  mux_d_mem_ex_reg_out, 
  write_reg_en_ex_reg_out, 
  d_mem_r_ex_reg_out, 
  d_mem_w_ex_reg_out,
  fun_3_ex_reg_out,
  write_address_ex_reg_out
    
);


memory_access_unit mem_access_unit(
  // inputs
  clk,
  reset,
  d_mem_r_ex_reg_out,
  d_mem_w_ex_reg_out,
  mux_d_mem_ex_reg_out,
  result_mux_4_ex_reg_out,
  data_2_ex_reg_out,
  fun_3_ex_reg_out,
  // outputs
  data_memory_busywait,
  write_data,
  // inputs
  fun_3_id_reg_out,
  switch_cache_w_id_reg_out
);

endmodule

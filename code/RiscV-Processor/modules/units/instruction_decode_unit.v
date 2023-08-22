

module instruction_decode_unit (
  // outputs
  switch_cache_w,
  reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output,
  write_address_for_current_instruction, // write back addres of reg file 
  rotate_signal,
  d_mem_r, // data mem read signal from control unit
	d_mem_w, // data mem write signal from control unit
  branch, // branch signal from control unit
  jump, // jump signal from control unit
  write_reg_en, // write enable signal for reg file from control unit
  mux_d_mem, // from control unit to  (load data or alu result) selection mux 
	mux_result,
	mux_inp_2, 
  mux_complmnt,
	mux_inp_1,
  alu_op,
  fun_3,
  data_1,
  data_2,
  mux_1_out, // wire module output
  reg_read_address_2, // register read address
  reg_read_address_1,
  reset_ID_reg,
  reset_IF_reg,
  hold_IF_reg,
  hazard_detect_signal,

  // inputs
  instruction,
  data_in,
  write_reg_enable_signal_from_pre,
  write_address_from_pre,
  clk, 
  reset,
  mem_read_ex,
  reg_write_address_ex,
  branch_jump_signal
  );

  output [4:0] write_address_for_current_instruction, reg_read_address_2, reg_read_address_1;
  output [31:0] data_1, data_2, mux_1_out;
  output mux_complmnt, mux_d_mem, write_reg_en,d_mem_r, d_mem_w, branch, jump,switch_cache_w;
  output rotate_signal;
  output mux_inp_2, mux_inp_1;
  output [2:0] alu_op;
  output [2:0] fun_3;
  output [1:0] mux_result;
  input [31:0] instruction, data_in;
  input write_reg_enable_signal_from_pre, clk, reset;
  input [4:0] write_address_from_pre;
  wire [2:0] mux_wire_module;
  wire [31:0] B_imm, J_imm, S_imm, U_imm, I_imm;
  output [31:0] reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output;
  input mem_read_ex;
  input [4:0] reg_write_address_ex;
  input branch_jump_signal;

  output hazard_detect_signal;
  output reset_ID_reg, reset_IF_reg, hold_IF_reg;

  assign write_address_for_current_instruction=instruction[11:7];
  assign fun_3=instruction[14:12];
  assign rotate_signal=instruction[30];
  assign reg_read_address_2 = instruction[24:20];
  assign reg_read_address_1 = instruction[19:15];

  // always @(posedge clk) begin
  //   write_address_for_current_instruction=instruction[11:7];
  //   fun_3=instruction[14:12];
  //   rotate_signal=instruction[30];
  //   reg_read_address_2 = instruction[24:20];
  //   reg_read_address_1 = instruction[19:15];
  // end

  control control_unit(switch_cache_w,d_mem_r, d_mem_w, jump, branch, write_reg_en, mux_d_mem, mux_result, mux_inp_2, mux_complmnt, mux_inp_1, mux_wire_module, alu_op, instruction[6:0], instruction[14:12], instruction[31:25]); 
  reg_file register_file(data_1, data_2, data_in, write_address_from_pre, instruction[19:15], instruction[24:20], write_reg_enable_signal_from_pre, clk, reset,reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output);
  Wire_module wire_module(instruction,B_imm, J_imm, S_imm, U_imm, I_imm);
  mux5x1 mux_1(B_imm, J_imm, S_imm, U_imm, I_imm, mux_wire_module, mux_1_out);
  Hazard_detection_unit hazard_detection_unit(mux_inp_1, mux_inp_2, mem_read_ex, reg_write_address_ex, instruction[19:15], instruction[24:20], hazard_detect_signal);
  Flush_unit flus_unit(hazard_detect_signal, branch_jump_signal, reset_ID_reg, reset_IF_reg, hold_IF_reg);

endmodule
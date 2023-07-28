

module instruction_decode_unit (
  // outputs
  switch_cache_w,
  reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output,
  write_address_for_current_instruction, // write back addres of reg file 
  rotate_signal,
  d_mem_r, // data mem read signal from control unit
	d_mem_w, // data mem read signal from control unit
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
  mux_1_out,
  // inputs
  instration,
  data_in,
  write_reg_enable_signal_from_pre,
  write_address_from_pre,
  clk, 
  reset
  );

  output [4:0] write_address_for_current_instruction;
  output [31:0] data_1, data_2, mux_1_out;
  output mux_complmnt, mux_inp_2, mux_inp_1, mux_d_mem, write_reg_en,d_mem_r, d_mem_w, branch, jump,rotate_signal,switch_cache_w;
  output [2:0] alu_op, fun_3;
  output [1:0] mux_result;
  input [31:0] instration, data_in;
  input write_reg_enable_signal_from_pre, clk, reset;
  input [4:0] write_address_from_pre;
  wire [2:0] mux_wire_module;
  wire [31:0] B_imm, J_imm, S_imm, U_imm, I_imm;
  output [31:0] reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output;


  // goes to reg file
  assign write_address_for_current_instruction=instration[11:7]; // write back address for reg file
  
  // goes to ALU control unit
  assign fun_3=instration[14:12];  // fun_3 value
  assign rotate_signal=instration[30];
  

  control control_unit(
    // outputs
    switch_cache_w, 
    d_mem_r, // data memory read signal
    d_mem_w, // date memory write signal
    jump, // jump  signal
    branch, // brach signal
    write_reg_en, // write enable for reg file
    mux_d_mem, 
    mux_result, 
    mux_inp_2, 
    mux_complmnt, 
    mux_inp_1, 
    mux_wire_module, // immidiate value selection signal for mux1
    alu_op, 
    // inputs
    instration[6:0],  // opcode
    instration[14:12],  // funct 3 
    instration[31:25] // funct 7
    );

  reg_file register_file(
    data_1, // Read data 1 from reg file 
    data_2, // Read data 2 from reg file
    data_in, // write data for reg file 
    write_address_from_pre, // write address for regfile
    instration[19:15], // read address  for data 1
    instration[24:20], // read address for data 2
    write_reg_enable_signal_from_pre, // write enable signal for reg file 
    clk, 
    reset,
    reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output
  );

  Wire_module wire_module( // sign extented extend the immediate value for each type
    // inputs
    instration,
    // outputs
    B_imm, //  B-Type instruction's immidiate value
    J_imm, //  J-Type instruction's immidiate value
    S_imm, //  S-Type instruction's immidiate value
    U_imm, //  U-Type instruction's immidiate value
    I_imm  //  I-Type instruction's immidiate value
  );

  // seletct the relavant imm valu for relevant instrunction type (B,J,S,U,I)
  mux5x1 mux_1(B_imm, J_imm, S_imm, U_imm, I_imm, mux_wire_module, mux_1_out);

endmodule
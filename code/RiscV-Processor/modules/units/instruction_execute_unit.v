

module instruction_execute_unit (
    // inputs
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] PC,
    input [31:0] INCREMENTED_PC_by_four,
    input [31:0] muxIout,
    input [1:0] mux4signal,
    input mux1signal,
    input mux2signal,
    input muxComplentsignal,
    input rotate_signal,
    input branch_signal,
    input jump_signal,
    input [2:0] func3,
    input [2:0] aluop,
    input [4:0] wb_address_MEM,
    input wb_write_en_MEM,
    input [4:0] wb_address_WB,
    input wb_write_en_WB,
    input [4:0] reg2_read_address_in,
    input [4:0] reg1_read_address_in,
    input [31:0] alu_out,
    input [31:0] mux5_out,
    input mem_read_en_in,
    input [4:0] reg_write_address_in,
    // outputs
    output [31:0] branch_jump_addres,
    output [31:0] result,
    output branch_or_jump_signal,
    output mem_read_en_out,
    output [4:0] reg_write_address_out,
    output [31:0] fwd_mux2_out
);

wire [31:0]input1,input2,alu_result,mul_div_result,input2Complement,complemtMuxOut;
wire zero_signal,sign_bit_signal,sltu_bit_signal;
reg [31:0] branch_adress;
wire [1:0] data1_forward_select, data2_forward_select;
wire [31:0] fwd_mux1_out;

assign mem_read_en_out = mem_read_en_in;
assign reg_write_address_out = reg_write_address_in;

mux2x1 mux1(fwd_mux1_out,PC,mux1signal,input1);
mux2x1 mux2(fwd_mux2_out,muxIout,mux2signal,input2);
complementer cmpl(input2,input2Complement);
mux2x1 muxComplent(input2,input2Complement,muxComplentsignal,complemtMuxOut);
mul mul_unit(mul_div_result,input1,input2,func3);
alu alu_unit(alu_result,input1,complemtMuxOut,aluop,rotate_signal,zero_signal,sign_bit_signal,sltu_bit_signal);
mux4x1 mux4(mul_div_result,muxIout,alu_result,INCREMENTED_PC_by_four,mux4signal,result);
Branch_jump_controller bjunit(branch_adress,alu_result,func3,branch_signal,jump_signal,zero_signal,sign_bit_signal,sltu_bit_signal,branch_jump_addres,branch_or_jump_signal);
Ex_forward_unit ex_forward_unit(wb_address_MEM, wb_write_en_MEM, wb_address_WB, wb_write_en_WB, reg1_read_address_in, reg2_read_address_in, data1_forward_select, data2_forward_select);
mux3x1 fwd_mux1(data1, alu_out, mux5_out, data1_forward_select, fwd_mux1_out);
mux3x1 fwd_mux2(data2, alu_out, mux5_out, data2_forward_select, fwd_mux2_out);

always @(*) begin
    branch_adress<=PC+muxIout; // add immediate value to the pc and get the branch address
end




    
endmodule
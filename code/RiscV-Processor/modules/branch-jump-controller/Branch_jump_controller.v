module Branch_jump_controller (
    // inputs
    Branch_address,
    Alu_Jump_imm,
    func_3,
    branch_signal, // branch signal from control unit
    jump_signal, // jump signal from control unit
    zero_signal, // zero signal from ALU
    sign_bit_signal,
    sltu_bit_signal,
    // outputs
    Branch_jump_PC_OUT,
    branch_jump_mux_signal // goes to the mux befor the PC 
);

input [31:0] Branch_address,Alu_Jump_imm;
input [2:0] func_3;
input branch_signal,jump_signal,zero_signal,sign_bit_signal,sltu_bit_signal;

output reg branch_jump_mux_signal;
output reg [31:0] Branch_jump_PC_OUT;

wire beq,bge,bne,blt,bltu,bgeu;

/*
    B-Type
     | imm[12]   | imm[10:5]         | rs2 (5)         | rs1 (5)   | funct3 (3) | imm[4:1]   | imm[11] | opcode (7) |

    | imm[12|10:5] | rs2 | rs1 | 000 | imm[4:1|11] | 1100011 |	BEQ
    | imm[12|10:5] | rs2 | rs1 | 001 | imm[4:1|11] | 1100011 |	BNE
    | imm[12|10:5] | rs2 | rs1 | 100 | imm[4:1|11] | 1100011 |	BLT
    | imm[12|10:5] | rs2 | rs1 | 101 | imm[4:1|11] | 1100011 |	BGE
    | imm[12|10:5] | rs2 | rs1 | 110 | imm[4:1|11] | 1100011 | 	BLTU
    | imm[12|10:5] | rs2 | rs1 | 111 | imm[4:1|11] | 1100011 | 	BGEU


    J-Type
    | imm[20] (1)      | imm[10:1] (10)   | imm[11] (1)   | imm[19:12] (8) | rd (5) | opcode (7) |

    | imm[20|10:1|11|19:12]   | rd  |  1101111 | JAL
*/

// branch if equal
assign  beq= (~func_3[2]) & (~func_3[1]) &  (~func_3[0]) & zero_signal;
// branch if not equal
assign  bne= (~func_3[2]) & (~func_3[1]) &  (func_3[0]) & (~zero_signal);
// branch if greater than
assign  bge= (func_3[2]) & (~func_3[1]) &  (func_3[0]) & (~sign_bit_signal);
// branch if less than
assign  blt= (func_3[2]) & (~func_3[1]) &  (~func_3[0]) & (~zero_signal) & sign_bit_signal;
// branch less than for unsign
assign  bltu= (func_3[2]) & (func_3[1]) &  (~func_3[0]) & (~zero_signal) & sltu_bit_signal;
// branch greater than for unsign
assign  bgeu= (func_3[2]) & (func_3[1]) &  (func_3[0]) & (~sltu_bit_signal);

always @(*)begin
    branch_jump_mux_signal<=(branch_signal &(beq|bge|bne|blt|bltu|bgeu)) | (jump_signal) | 1'b0;
end

always @(*) begin
                            
    if (jump_signal==1'b1) begin
        Branch_jump_PC_OUT<=Alu_Jump_imm;
    end
    else begin
        Branch_jump_PC_OUT<=Branch_address;
    end
end
    
endmodule
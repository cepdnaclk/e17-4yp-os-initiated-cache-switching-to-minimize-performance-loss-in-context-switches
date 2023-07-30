/*
    Type of Insturctions 

                R-type	Register-register instructions
                I-type	Immediate instructions
                S-type	Store instructions
                B-type	Conditional branch instructions
                U-type	Upper immediate instructions
                J-type	Jump instructions

        - R-Type
            airthmetic and logical operations, that operate register values
            add , sub , bitwise And, OR, etc
                Example: add rd, rs1, rs2

                
                | imm[11:5] (7)   | rs2 (5) | rs1 (5) | funct3 (3) | imm[4:0] (5) | opcode (7) |




        - I-Type
            instructions involve an immediate value (constant) in the instruction itself, 
            typically used for arithmetic operations, sign extension, and loading/storing data from/to memory        
                Example: addi rd, rs1, imm (rd = rs1 + imm)

                
                | imm[11:0] (12) | rs1 (5) | funct3 (3) | rd (5)   | opcode (7) |


        - S-Type
            used for storing data from a register into memory. 
            They have an immediate offset to compute the memory address and use one source register (rs1) for data to be stored
                Example: sw rs2, offset(rs1)

                | imm[11:5] (7)   |   rs2 (5)         |   rs1 (5)   | funct3 (3) | imm[4:0] (5) | opcode (7) |
        
        - B-Type
            B-Type instructions are used for conditional branching, 
            enabling the program to jump to a different location in the code based on a specified condition. 
            They involve two source registers (rs1 and rs2) and an immediate offset.
                Example: beq rs1, rs2, offset (Branch to the instruction at offset if rs1 and rs2 are equal)

                | imm[12]   | imm[10:5]         | rs2 (5)         | rs1 (5)   | funct3 (3) | imm[4:1]   | imm[11] | opcode (7) |
        
        - U-Type
            U-Type instructions are used for loading immediate values into a register
                Example: lui rd, imm

                
                | imm[31:12] (20)   | rd (5) | opcode (7) |
                


        
        - J-Type
            J-Type instructions are used for unconditional jumping to a specified target address. 
            They involve an immediate offset.
                Example: jal offset (Jump to the instruction at offset and store the return address in the rd register)

                | imm[20] (1)      | imm[10:1] (10)   | imm[11] (1)   | imm[19:12] (8) | rd (5) | opcode (7) |
*/

module Wire_module (
    // inputs
    Instruction,
    // outputs
    B_imm,
    J_imm,
    S_imm,
    U_imm,
    I_imm

);

input  [31:0] Instruction;
output [31:0] B_imm,J_imm,S_imm,U_imm,I_imm;

// sign extention imidiate value for B type 
// | imm[12]   | imm[10:5]         | rs2 (5)         | rs1 (5)   | funct3 (3) | imm[4:1]   | imm[11] | opcode (7) |
assign B_imm={{20{Instruction[31]}},Instruction[7],Instruction[30:25],Instruction[11:8],1'b0};

// sign extention imidiate value for J type 
// | imm[20] (1)      | imm[10:1] (10)   | imm[11] (1)   | imm[19:12] (8) | rd (5) | opcode (7) |
assign J_imm={{12{Instruction[31]}},Instruction[19:12],Instruction[20],Instruction[30:21],1'b0};

// sign extention imidiate value for S type 
// | imm[11:5] (7)   |   rs2 (5)         |   rs1 (5)   | funct3 (3) | imm[4:0] (5) | opcode (7) |
assign S_imm={{21{Instruction[31]}},Instruction[30:25],Instruction[11:7]};

// sign extention imidiate value for U type 
// | imm[31:12] (20)   | rd (5) | opcode (7) |
assign U_imm={Instruction[31:12],{12{1'b0}}};

// sign extention imidiate value for I type
//  | imm[11:0] (12) | rs1 (5) | funct3 (3) | rd (5)   | opcode (7) |
assign I_imm={{21{Instruction[31]}},Instruction[30:20]};
    
endmodule
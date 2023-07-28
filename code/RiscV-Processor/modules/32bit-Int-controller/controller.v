module control(
	// outputs
	switch_cache_w,
	d_mem_r, // data memory read signal
	d_mem_w, // data memory write signal
	jump, 	// jumping signal (goes to brach and Jump controller)
	branch, // branching signal (goes to brach and Jump controller)
	wrten_reg, // write enable for register file
	mux_d_mem,
	mux_result,
	mux_inp_2,
	mux_complmnt, 
	mux_inp_1,
	mux_wire_module, // 3bits , imm value selection signal for relavant instruction type (B,J,S,U,I)
	alu_op,  // 3bits ALU Operation 
	// inputs
	opcode,  
	fun_3, 
	fun_7
	);
	
	//input opcode part of the instration
	input [6:0] opcode;
	input [2:0] fun_3;
	input [6:0] fun_7;
	
	//alu_op is the output which select for the alu
	output reg [2:0] alu_op;

	output reg mux_complmnt, mux_inp_1, mux_inp_2, mux_d_mem, wrten_reg, branch, jump, d_mem_r, d_mem_w,switch_cache_w;
	output reg [2:0] mux_wire_module;
	output reg [1:0] mux_result;
	
	always @ (*)
	begin

		case(opcode)
		
			/*
			rd <- imm << 12
			*/
			7'b0110111: begin	//LUI
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd0;
				branch <= 1'd0;
				wrten_reg <= 1'd1; // Write enable signal for register file
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd1; // Select the load data or alu value
				mux_result <= 1'd1; // Load unsign immediate and take the output of imeediate value
				mux_inp_2 <= 1'd1; // Immediate value
				mux_inp_1 <= 1'd0; // data value
				mux_wire_module <= 3'd3; // Select unsigned U_imm value from wire module
				alu_op <= 3'd0; // Just pass the alu value opcode
				switch_cache_w <= 1'd0;
			end

			/*
			rd <- pc + imm << 12
			*/
			7'b0010111: begin	//AUIPC
				d_mem_r <= 1'd0; 
				d_mem_w <= 1'd0;
				jump <= 1'd0;
				branch <= 1'd0;
				wrten_reg <= 1'd1;
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd1;
				mux_result <= 2'd2; // Value pc + imm << 12
				mux_inp_2 <= 1'd1; // Immediate value
				mux_inp_1 <= 1'd1; // PC value
				mux_wire_module <= 3'd3;
				alu_op <= 3'd0;
				switch_cache_w <= 1'd0;
			end

			/*
			rd <- pc + 4
			pc <- pc + imm
			*/
			7'b1101111: begin	//JAL
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd1; // Jump signl to the 
				branch <= 1'd0;
				wrten_reg <= 1'd1;
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd1; // Data load or alu value
				mux_result <= 2'd3; // Select the pc + 4
				mux_inp_2 <= 1'd1; // Immediate value
				mux_inp_1 <= 1'd1; // PC value
				mux_wire_module <= 3'd1; // J type
				alu_op <= 3'd0;
				switch_cache_w <= 1'd0;
			end

			/*
			pc <- (rsl + imm) & '1
			re <- pc + 4
			*/
			7'b1100111: begin	//JALR
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd1;
				branch <= 1'd0;
				wrten_reg <= 1'd1;
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd1;
				mux_result <= 2'd3; // Select the pc + 4
				mux_inp_2 <= 1'd1; // Immediate value
				mux_inp_1 <= 1'd0; // rs1
				mux_wire_module <= 3'd4; // I type
				alu_op <= 3'd0; // Just pass why
				switch_cache_w <= 1'd0;
			end

			7'b1100011: begin	//BEQ, BNE......
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd0;
				branch <= 1'd1;
				wrten_reg <= 1'd0;
				mux_complmnt <= 1'd1;
				mux_d_mem <= 1'd0;
				mux_result <= 1'd0;
				mux_inp_2 <= 1'd0;
				mux_inp_1 <= 1'd0;
				mux_wire_module <= 3'd0;
				alu_op <= 3'd0;
				switch_cache_w <= 1'd0;
			end

			7'b0000011: begin	//lb,lh,lw
				d_mem_r <= 1'd1;
				d_mem_w <= 1'd0;
				jump <= 1'd0;
				branch <= 1'd0;
				wrten_reg <= 1'd1;
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd0;
				mux_result <= 2'd2;
				mux_inp_2 <= 1'd1;
				mux_inp_1 <= 1'd0;
				mux_wire_module <= 3'd4;
				alu_op <= 3'd0;
				switch_cache_w <= 1'd0;
			end

			7'b0100011: begin //sb,sh,sw,..
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd1;
				jump <= 1'd0;
				branch <= 1'd0;
				wrten_reg <= 1'd0;
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd0;
				mux_result <= 2'd2;
				mux_inp_2 <= 1'd1;
				mux_inp_1 <= 1'd0;
				mux_wire_module <= 3'd2;
				alu_op <= 3'd0;
				switch_cache_w <= 1'd0;
			end

			7'b0010011: begin // ADDI/slti/xori/ori/andi/....
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd0;
				branch <= 1'd0;
				wrten_reg <= 1'd1;
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd1;
				mux_result <= 2'd2;
				mux_inp_2 <= 1'd1;
				mux_inp_1 <= 1'd0;
				mux_wire_module <= 3'd4;
				alu_op <= fun_3;
				switch_cache_w <= 1'd0;
			end

			7'b0110011: begin  // add/sub/and/or
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd0;
				branch <= 1'd0;
				wrten_reg <= 1'd1;
				mux_complmnt <= fun_7[5] ? 1'd1 : 1'd0;
				mux_d_mem <= 1'd1;
				mux_result <= 2'd2;
				mux_inp_2 <= 1'd0;
				mux_inp_1 <= 1'd0;
				mux_wire_module <= 3'd0;
				alu_op <= fun_3;
				switch_cache_w <= 1'd0;
			end

			7'b1111111: begin
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd0;
				branch <= 1'd0;
				wrten_reg <= 1'd0;
				switch_cache_w <= 1'd1;
				// mux_complmnt <= 1'd0;
				// mux_d_mem <= 1'd0;
				// mux_result <= 1'd0;
				// mux_inp_2 <= 1'd0;
				// mux_inp_1 <= 1'd0;
				// mux_wire_module <= 3'd0;
				// alu_op <= fun_3;
			end
					  
			//default
			default: begin
				d_mem_r <= 1'd0;
				d_mem_w <= 1'd0;
				jump <= 1'd0;
				branch <= 1'd0;
				wrten_reg <= 1'd0;
				mux_complmnt <= 1'd0;
				mux_d_mem <= 1'd0;
				mux_result <= 1'd0;
				mux_inp_2 <= 1'd0;
				mux_inp_1 <= 1'd0;
				mux_wire_module <= 3'd0;
				alu_op <= fun_3;
				switch_cache_w <= 1'd0;
			end
			
		endcase
	end
			
			
endmodule
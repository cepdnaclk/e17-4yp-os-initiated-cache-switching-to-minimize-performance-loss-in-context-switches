//`include "../mux/mux2x1.v"


module instruction_fetch_unit (
    // inputs
    input [31:0] branch_jump_addres,
    input branch_or_jump_signal,
    input data_memory_busywait,
    input reset,
    input clock,
    input hazard_detect_signal,
    // outputs 
    output reg [31:0] PC,INCREMENTED_PC_by_four,
    output [31:0]instruction,
    output busywait
);

wire [31:0] mux6out;
wire instruction_mem_busywait;
wire [31:0] hazard_mux_pc_out;

/*
mux6 is there to select the pc + 4 value or select the branch value from the branch or jump controller unit
so the pc is increasing while executing
*/

or(busywait,instruction_mem_busywait,data_memory_busywait);
mux2x1 mux6(hazard_mux_pc_out, branch_jump_addres,branch_or_jump_signal, mux6out); // mux before the PC
icache myicache(clock,reset,PC,instruction,instruction_mem_busywait);
mux2x1 hazard_mux(INCREMENTED_PC_by_four, PC, hazard_detect_signal, hazard_mux_pc_out);
/*
always @(posedge reset) begin //set the pc value depend on the RESET to start the programme
    PC= -4;
end
*/

always @(*) begin
    INCREMENTED_PC_by_four <=PC+4;
end

always @(posedge clock,posedge reset) begin //update the pc value depend on the positive clock edge
    // #2
	 if(reset)begin
		PC <= -4;  // set the PC = -4, the pervious always block increase it to 0
	 end
    else if(busywait == 1'b0)begin //update the pc when only busywait is zero 
        PC <= mux6out; 
    end
end  
    
endmodule
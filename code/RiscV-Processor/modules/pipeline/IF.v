module IF(
    // inputs
    pc_in, // PC
    pc_4_in, // PC + 4
    instration_in, // instruction 32 bits
    reset,
    hazard_rest,
    clk,
    busywait,
    branch_jump_signal, // branch jump signal for mux6 (mux befor PC)
    hold,
    busywait_imem,
    // outputs
    pc_out,
    pc_4_out,
    instration_out
    );

  input [31:0] pc_in, pc_4_in, instration_in;
  output reg [31:0] pc_out, pc_4_out, instration_out;
  input busywait,branch_jump_signal,busywait_imem;
  input  reset, clk;
  input hold, hazard_rest;
  
  
  always @(posedge clk,posedge reset)
  begin
    // #1
    if(reset)begin  // clear the reg on reset
      pc_out <=32'd0;
      pc_4_out <=32'd0;
      instration_out <=32'd0;
    end else if(hazard_rest) begin
      pc_out <=32'd0;
      pc_4_out <=32'd0;
      instration_out <=32'd0;
    end else if (branch_jump_signal)begin // Why why why clear IF reg on a branch jump signal 
      pc_out <=32'd0;
      pc_4_out <=32'd0;
      instration_out <=32'd0;
    end else if (!busywait && hold == 1'b0 && !busywait_imem) begin // store all the related value in IF reg if  the previous stage isn't busy
      pc_out <=pc_in;
      pc_4_out <=pc_4_in;
      instration_out <=instration_in;
    end else if (busywait_imem) begin
      instration_out <=32'd0;
    end

  end

endmodule
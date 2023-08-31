module MEM(
    // inputs
    clk,
    reset,
    write_address_in,
    write_en_in,
    mux5_sel_in,
    alu_result_in,
    d_mem_result_in,
    mem_read_in,
    reg1_read_address_in,
    busywait,
    // outputs
    write_address_out,
    write_en_out,
    mux5_sel_out,
    alu_result_out,
    d_mem_result_out,
    mem_read_out,
    reg1_read_address_out
  );

    input [4:0] write_address_in, reg1_read_address_in;
    input write_en_in, mux5_sel_in, mem_read_in, reset, clk;
    input [31:0] alu_result_in, d_mem_result_in;
    input busywait;

    output reg [4:0] write_address_out, reg1_read_address_out;
    output reg write_en_out, mux5_sel_out, mem_read_out;
    output reg [31:0] alu_result_out, d_mem_result_out;

    always @(posedge clk, posedge reset)
    begin

        if(reset)begin
            write_address_out <= 4'b0;
            write_en_out <= 1'b0;
            mux5_sel_out <= 1'b0;
            alu_result_out <= 32'b0;
            d_mem_result_out <= 32'b0;
        end
        else if(!busywait)
        begin
            write_address_out <= write_address_in;
            write_en_out <= write_en_in;
            mux5_sel_out <= mux5_sel_in;
            alu_result_out <= alu_result_in;
            d_mem_result_out <= d_mem_result_in;
            mem_read_out <= mem_read_in;
            reg1_read_address_out <= reg1_read_address_in;
        end

  end

endmodule
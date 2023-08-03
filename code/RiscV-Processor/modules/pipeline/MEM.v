module MEM(
    // inputs
    clk,
    reset,
    write_address_in,
    write_en_in,
    mux5_sel_in,
    alu_result_in,
    d_mem_result_in,

    // outputs
    write_address_out,
    write_en_out,
    mux5_sel_out,
    alu_result_out,
    d_mem_result_out
  );

    input [4:0] write_address_in;
    input write_en_in, mux5_sel_in, reset, clk;
    input [31:0] alu_result_in, d_mem_result_in;

    output reg [4:0] write_address_out;
    output reg write_en_out, mux5_sel_out;
    output reg [31:0] alu_result_out, d_mem_result_out;

    always @(posedge clk)
    begin

        if(reset)begin
            write_address_out <= 4'b0;
            write_en_out <= 1'b0;
            mux5_sel_out <= 1'b0;
            alu_result_out <= 32'b0;
            d_mem_result_out <= 32'b0;
        end
        else
        begin
            write_address_out <= write_address_in;
            write_en_out <= write_en_in;
            mux5_sel_out <= mux5_sel_in;
            alu_result_out <= alu_result_in;
            d_mem_result_out <= d_mem_result_in;
        end

  end

endmodule

module memory_access_unit (
    // inputs
    input clock,
    input reset,
    input mem_read_signal,
    input mem_write_signal,
    input [31:0] mux4_out_result,
    input [31:0] data2,
    input [2:0] func3, // funct 3
    // outputs
    output data_memory_busywait,
    // output [31:0] mux5_out_write_data,
    output [31:0] load_data,    //dmem data out
    output [31:0] alu_out_mem,
    // inputs
    input [2:0] func3_cache_select_reg_value, // funct 3 from previous pipline reg (ID reg)
    input write_cache_select_reg, // cache switch enable signal
    input [4:0] reg_read_address_in,
    input mem_read_en_WB,
    input [4:0] mem_address_WB,
    input [31:0] data_wb,
    input reg_write_en_in,
    input [4:0] reg_write_address_in,
    output reg_write_en_out,
    output [4:0] reg_write_address_out
);
    wire [31:0] store_data,from_data_cache_out, write_data_forward;
    wire mem_forward_select;

    assign alu_out_mem = mux4_out_result;
    assign reg_write_en_out = reg_write_en_in;
    assign reg_write_address_out = reg_write_address_in;

    Data_store_controller dsc(func3,store_data, write_data_forward);
    Data_load_controller dlc(func3,from_data_cache_out,load_data);

    // dcache mydcache(clock,reset,mem_read_signal,mem_write_signal,mux4_out_result,store_data,from_data_cache_out,data_memory_busywait);
    Cache_controller myCache_controller(clock,reset,mem_read_signal,mem_write_signal,mux4_out_result,store_data,from_data_cache_out,data_memory_busywait,func3_cache_select_reg_value,write_cache_select_reg);
    // mux2x1 mux5(load_data,mux4_out_result,mux5signal,mux5_out_write_data);
    Mem_forward_unit mem_forward(mem_write_signal, reg_read_address_in,mem_read_en_WB, mem_address_WB,mem_forward_select);
    mux2x1 write_Data_forward_mux(data2, data_wb, mem_forward_select, write_data_forward);

endmodule

module memory_access_unit (
    // inputs
    input clock,reset,
    input mem_read_signal,mem_write_signal,
    input [31:0] mux4_out_result,data2,
    input [2:0] func3, // funct 3
    // outputs
    output data_memory_busywait,
    // output [31:0] mux5_out_write_data,
    output [31:0] load_data,
    // inputs
    input [2:0] func3_cache_select_reg_value, // funct 3 from previous pipline reg (ID reg)
    input write_cache_select_reg
);
    wire [31:0] store_data,from_data_cache_out;

    Data_store_controller dsc(func3,store_data,data2);
    Data_load_controller dlc(func3,from_data_cache_out,load_data);

    // dcache mydcache(clock,reset,mem_read_signal,mem_write_signal,mux4_out_result,store_data,from_data_cache_out,data_memory_busywait);
    Cache_controller myCache_controller(clock,reset,mem_read_signal,mem_write_signal,mux4_out_result,store_data,from_data_cache_out,data_memory_busywait,func3_cache_select_reg_value,write_cache_select_reg);
    // mux2x1 mux5(load_data,mux4_out_result,mux5signal,mux5_out_write_data);

endmodule
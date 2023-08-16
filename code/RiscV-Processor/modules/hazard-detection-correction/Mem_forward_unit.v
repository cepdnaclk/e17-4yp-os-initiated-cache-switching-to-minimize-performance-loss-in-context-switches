module Mem_forward_unit(
    // inputs
    mem_write_en_MEM,
    mem_address_MEM,
    mem_read_en_WB,
    mem_address_WB,
    // outputs
    mem_forward_select
);

input mem_write_en_MEM, mem_read_en_WB;
input [4:0] mem_address_MEM, mem_address_WB;

output reg mem_forward_select;

always @ (*)
begin
    if (mem_write_en_MEM && mem_read_en_WB && (mem_address_MEM === mem_address_WB))
        mem_forward_select = 1'b1;
    else
        mem_forward_select = 1'b0;
end
    

endmodule
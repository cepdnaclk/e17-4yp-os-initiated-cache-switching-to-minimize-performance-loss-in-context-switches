module Ex_forward_unit(
    // inputs
    wb_address_MEM,
    wb_write_en_MEM,
    wb_address_WB,
    wb_write_en_WB,
    address1_EX,
    address2_EX,
    hazard_detect_signal,
    // outputs
    data1_forward_select,
    data2_forward_select
);

input wb_write_en_MEM, wb_write_en_WB, hazard_detect_signal;
input [4:0] wb_address_MEM, wb_address_WB, address1_EX, address2_EX;

output reg [1:0] data1_forward_select, data2_forward_select;
     
    always @ (*)
    begin
        
        // Forwarding for Operand 1
        if (wb_write_en_MEM && wb_address_MEM === address1_EX && !hazard_detect_signal)
            data1_forward_select = 2'b01;    // Activate forwarding from MEM stage
        else if (wb_write_en_WB && wb_address_WB === address1_EX)
            data1_forward_select = 2'b10;    // Activate forwarding from WB stage
        else
            data1_forward_select = 2'b00;    // No forwarding

        // Forwarding for Operand 2
        if (wb_write_en_MEM && wb_address_MEM === address2_EX && !hazard_detect_signal)
            data2_forward_select = 2'b01;    // Activate forwarding from MEM stage
        else if (wb_write_en_WB && wb_address_WB === address2_EX)
            data2_forward_select = 2'b10;    // Activate forwarding from WB stage
        else
            data2_forward_select = 2'b00;    // No forwarding
    end

endmodule
module Hazard_detection_unit(
    // inputs
    mux1_sel_signal,
    mux2_sel_signal,
    mem_read_EX,
    wb_address_EX,
    data_address1,
    data_address2,
    // output
    hazard_detect_signal
);

input mux1_sel_signal, mux2_sel_signal, mem_read;
input [4:0] wb_address_EX;
input [4:0] data_address1, data_address2;

output reg hazard_detect_signal;

always @ (*)
    begin
        if (mem_read_EX && (       // Instruction in EX stage must be a memory read
            (!mux1_sel_signal && (data_address1 === wb_address_EX)) ||    // Check if instruction in ID uses loaded value as OP1
            (!mux2_sel_signal && (data_address2 === wb_address_EX))       // Check if instruction in ID uses loaded value as OP2
        ))
            hazard_detect_signal = 1'b1;
        else
            hazard_detect_signal = 1'b0;
    end

endmodule

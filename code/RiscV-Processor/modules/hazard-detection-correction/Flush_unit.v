module Flush_unit(
    // inputs
    hazard_detect,
    bj_mux_select,
    // outputs
    reset_ID_reg,
    reset_IF_reg,
    hold_IF_reg
);

input hazard_detect, bj_mux_select;
output reset_ID_reg, reset_IF_reg, hold_IF_reg;

// In case of a branch/jump, IF/ID PR must be reset
// In case of a load-use hazard, IF/ID PR must hold its value
assign reset_IF_reg = bj_mux_select;
assign hold_IF_reg = !bj_mux_select && hazard_detect;

// In case either a branch/jump or load-use hazard occurs,
// ID/EX PR must be reset
assign reset_Id_reg = bj_mux_select || hazard_detect ;

endmodule
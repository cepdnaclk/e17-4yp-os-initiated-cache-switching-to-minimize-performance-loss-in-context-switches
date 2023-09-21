module counter (
    input wire clk,     // Clock input
    input wire reset,   // Reset input
    input wire button,  // Button input
    output reg [3:0] count // 4-bit counter output
);


reg button_pressed;        // Flag to detect button press

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 4'b0000; // Reset the counter to 0 when reset is active
        button_pressed <= 1'b0;
    end else if (button && !button_pressed) begin
        if (count == 4'b1111) begin
            count <= 4'b0000; // Reset to 0 when the maximum value is reached
        end else begin
            count <= count + 1; // Increment the counter on button press
        end
        button_pressed <= 1'b1;
    end else if (!button) begin
        button_pressed <= 1'b0;
    end
end

endmodule

module counter (
    input reset,   // Reset input
    input button,  // Button input
    output reg [3:0] count // 4-bit counter output
);

initial begin
	count = 4'b0000;
end

always @(posedge button or posedge reset) begin
    if (reset) begin
        count <= 4'b0000; // Reset the counter to 0 when reset is active
    end else if (button) begin
        if (count == 4'b1111) begin
            count <= 4'b0000; // Reset to 0 when the maximum value is reached
        end else begin
            count <= count + 1; // Increment the counter on button press
        end
	 end
end

endmodule
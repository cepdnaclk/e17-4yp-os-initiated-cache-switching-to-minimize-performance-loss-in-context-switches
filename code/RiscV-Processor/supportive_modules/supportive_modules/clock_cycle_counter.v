module ClockCycleCounter (
  input wire clk,          // Clock signal
  input wire reset,        // Reset signal (optional)
  input wire [31:0] trigger,      // Trigger signal (32 bits)
  output reg [31:0] counter  // 32-bit counter output
);

  // Registers
  reg [1:0] state;  // 2-bit state: 00 (IDLE), 01 (COUNTING), 10 (STOPPED)

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      //state <= 2'b00;    // Reset the state to IDLE
      counter <= 32'b0;   // Reset the counter
    end else begin
      if (trigger == 32'd1) begin
        //state <= 2'b01;  // Transition to COUNTING state when trigger is 1
        counter <= counter + 1;
      end 
    //   else if (trigger == 32'd2) begin
    //     state <= 2'b10;  // Transition to STOPPED state when trigger is 2
    //   end
    end
  end

//   always @(posedge clk) begin
//     if (state == 2'b01) begin
//         // Increment the counter in the COUNTING state
//     end
//   end



endmodule

module MemoryExample;

  reg [7:0] memory_array [1023:0]; // 1024 bytes memory array
  reg [3:0] counter;
  reg [127:0] readdata;

  initial begin
    // Initialize memory array with some values
    for (integer i = 0; i < 16; i = i + 1) begin
      memory_array[i] = $random;
      $display("%h" , memory_array[i]);
    end

    // Simulate reading 128 bits from the memory array based on the counter
    for (integer counter_value = 0; counter_value < 8; counter_value = counter_value + 1) begin
      // Set the counter value
      counter = counter_value;

      // Read 128 bits from the memory array based on the counter
      for (integer i = 0; i < 128; i = i + 1) begin
        readdata[i * 8 +: 8] = memory_array[counter * 128 + i];
      end

      // Display the results
      $display("Counter = %0d, ReadData = %h", counter, readdata);
    end

    // End simulation
    $finish;
  end

endmodule

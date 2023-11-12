`include "./dmem_for_dcache.v"
//`include "./dmem_1.v"

module data_memory_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Signals
  reg clock;
  reg reset;
  reg read;
  reg write;
  reg [27:0] address;
  reg [127:0] writedata;
  wire [127:0] readdata;
  wire busywait;

  // Instantiate the data_memory module
  data_memory dut (
    .clock(clock),
    .reset(reset),
    .read(read),
    .write(write),
    .address(address),
    .writedata(writedata),
    .readdata(readdata),
    .busywait(busywait)
  );

  // Clock generation
  always #((CLK_PERIOD)/2) clock = ~clock;

  // Initial values
  initial begin
    clock = 0;
    reset = 1;
    read = 0;
    write = 0;
    address = 0;
    writedata = 0;

    // Apply reset
    #10 reset = 0;

    // Write operation
    #10 address = 32'd1;
    #10 writedata = 128'h0123456789ABCDEF0123456789ABCDEF;
    #10 write = 1;
    #100 write = 0; 

    // Read operation
    #10 address = 32'd1;
    #10 read = 1;
    #100 read = 0;

    // Write operation
    #10 address = 32'd2;
    #10 writedata = 128'h01020304050607080910111213141516;
    #10 write = 1;
    #100 write = 0; 

    // Read after write
    #10 address = 32'd2;
    #10 read = 1;
    #100 read = 0;

    // Write to a different address
    #10 writedata = 128'hFEDCBA9876543210FEDCBA9876543210;
    #10 address = 32'h00000003;
    #10 write = 1;
    #100 write = 0;

    // Add more test scenarios as needed

    // End simulation
    #10 $finish;
  end

  // Display simulation information
  always @ (busywait) begin
    if (write) begin
      $display("Time = %3t, Write: Address = %3d, WriteData = %h, BusyWait = %b", $time, address, writedata, busywait);
    end else if (read) begin
      $display("Time = %3t,  Read: Address = %3d, ReadData  = %h, BusyWait = %b", $time, address, readdata, busywait);
    end else if (reset) begin
      $display("Time = %3t, Reset: Address = %3d, BusyWait  = %b", $time, address, busywait);

    end
  end

endmodule

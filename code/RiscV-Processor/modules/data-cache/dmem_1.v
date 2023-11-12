module data_memory(
    input clock,
    input reset,
    input read,
    input write,
    input [27:0] address,
    input [127:0] writedata,
    output reg [127:0] readdata,
    output reg busywait
);

    // Declare memory array 128x8-bits (1024 bytes)
    reg [7:0] memory_array [4095:0];

    // Detecting an incoming memory access
    reg [3:0] counter;
    reg readaccess, writeaccess;

    // Internal signals for loop-based read and write
    reg [127:0] temp_readdata;
    reg [127:0] temp_writedata;

    always @(*) begin
        busywait <= ((read || write) && counter != 4'b1111) ? 1 : 0;
        readaccess <= (read && !write) ? 1'b1 : 1'b0;
        writeaccess <= (!read && write) ? 1'b1 : 1'b0;
    end

    always @(posedge clock, posedge reset) begin
        if (reset) begin
            counter <= 4'b0000;
        end else if (readaccess || writeaccess) begin
            counter <= counter + 4'b0001;
        end
    end

    // Reading & writing
    always @(counter ,posedge clock, posedge reset) begin
        if(reset)
        if (readaccess) begin
            // Read 128 bits (16 bytes) from the memory array
            temp_readdata[counter+: 8] = memory_array[{address[27:0], counter}];
            
            readdata <= temp_readdata;
            $display("read %h", readdata);
        end

        if (writeaccess) begin
            // Write 128 bits (16 bytes) to the memory array
            temp_writedata = writedata; // Copy the input data
            memory_array[{address[27:0], counter}] = temp_writedata[counter+: 8];
            $display("write %h",{address[27:0], counter});
        end
    end

endmodule

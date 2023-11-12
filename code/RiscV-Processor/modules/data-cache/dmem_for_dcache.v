//`timescale 1ns/100ps

module data_memory(
	clock,
    reset,
    read,
    write,
    address,
    writedata,
    readdata,
	busywait
);
input				clock;
input           	reset;
input           	read;
input           	write;
input[27:0]      	address;
input[127:0]     	writedata;
output reg [127:0]	readdata;
output reg      	busywait;



//Declare memory array 1024x8-bits 
reg [7:0] memory_array [1023:0];

//Detecting an incoming memory access
reg [3:0]counter;
reg readaccess, writeaccess;

always @(*)
begin
	busywait <= ((read || write)&& counter!=4'b1111)? 1 : 0;
	readaccess <= (read && !write)? 1'b1 : 1'b0;
	writeaccess <= (!read && write)? 1'b1 : 1'b0;
end

always @(posedge clock,posedge reset) begin
    if (reset) begin
        counter <= 4'b0000;
    end
    else if(readaccess || writeaccess)
    begin
        counter <= counter+4'b0001;
    end
end

//Reading & writing
always @(posedge clock,posedge reset)
begin

        readdata[counter*8 +:8] = memory_array[{address[27:0], counter}];
        memory_array[{address[27:0],counter}]=writedata[counter*8 +:8];

end

//Reset memory
/*
integer i;
always @(posedge reset)
begin
    if (reset)
    begin
        for (i=0;i<256; i=i+1)
            memory_array[i] = 0;
        
        busywait = 0;
		readaccess = 0;
		writeaccess = 0;
    end
end
*/
endmodule

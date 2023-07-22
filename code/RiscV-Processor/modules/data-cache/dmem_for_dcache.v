`timescale 1ns/100ps

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
    // if(reset)begin
    //     counter <= 4'b0000;
    // end
	// else if(readaccess )
	// begin
        
        case (counter)
            4'b0000:begin
                readdata[7:0]=memory_array[{address[27:0],counter}];
            end
            4'b0001:begin
                readdata[15:8]=memory_array[{address[27:0],counter}];
            end
            4'b0010:begin
                readdata[23:16]=memory_array[{address[27:0],counter}];
            end
            4'b0011:begin
                readdata[31:24]=memory_array[{address[27:0],counter}];
            end
            4'b0100:begin
                readdata[39:32]=memory_array[{address[27:0],counter}];
            end
            4'b0101:begin
                readdata[47:40]=memory_array[{address[27:0],counter}];
            end
            4'b0110:begin
                readdata[55:48]=memory_array[{address[27:0],counter}];
            end
            4'b0111:begin
                readdata[63:56]=memory_array[{address[27:0],counter}];
            end
            4'b1000:begin
                readdata[71:64]=memory_array[{address[27:0],counter}];
            end
            4'b1001:begin
                readdata[79:72]=memory_array[{address[27:0],counter}];
            end
            4'b1010:begin
                readdata[87:80]=memory_array[{address[27:0],counter}];
            end
            4'b1011:begin
                readdata[95:88]=memory_array[{address[27:0],counter}];
            end
            4'b1100:begin
                readdata[103:96]=memory_array[{address[27:0],counter}];
            end
            4'b1101:begin
                readdata[111:104]=memory_array[{address[27:0],counter}];
            end
            4'b1110:begin
                readdata[119:112]=memory_array[{address[27:0],counter}];
            end
            4'b1111:begin
                readdata[127:120]=memory_array[{address[27:0],counter}];
            end 
        endcase
        // counter = counter+4'b0001;
        //busywait =1 ;
		// readdata[7:0]     = #40 memory_array[{address,4'b0000}];
        // readdata[15:8]    = #40 memory_array[{address,4'b0001}];
        // readdata[23:16]   = #40 memory_array[{address,4'b0010}];
        // readdata[31:24]   = #40 memory_array[{address,4'b0011}];
        // readdata[39:32]   = #40 memory_array[{address,4'b0100}];
        // readdata[47:40]   = #40 memory_array[{address,4'b0101}];
        // readdata[55:48]   = #40 memory_array[{address,4'b0110}];
        // readdata[63:56]   = #40 memory_array[{address,4'b0111}];
        // readdata[71:64]   = #40 memory_array[{address,4'b1000}];
        // readdata[79:72]   = #40 memory_array[{address,4'b1001}];
        // readdata[87:80]   = #40 memory_array[{address,4'b1010}];
        // readdata[95:88]   = #40 memory_array[{address,4'b1011}];
        // readdata[103:96]  = #40 memory_array[{address,4'b1100}];
        // readdata[111:104] = #40 memory_array[{address,4'b1101}];
        // readdata[119:112] = #40 memory_array[{address,4'b1110}];
        // readdata[127:120] = #40 memory_array[{address,4'b1111}];
		//busywait = 0;

	// end
	// else if(writeaccess)
	// begin
        case (counter)
            4'b0000:begin
                memory_array[{address[27:0],counter}]=writedata[7:0];
            end
            4'b0001:begin
                memory_array[{address[27:0],counter}]=writedata[15:8];
            end
            4'b0010:begin
                memory_array[{address[27:0],counter}]=writedata[23:16];
            end
            4'b0011:begin
                memory_array[{address[27:0],counter}]=writedata[31:24];
            end
            4'b0100:begin
                memory_array[{address[27:0],counter}]=writedata[39:32];
            end
            4'b0101:begin
                memory_array[{address[27:0],counter}]=writedata[47:40];
            end
            4'b0110:begin
                memory_array[{address[27:0],counter}]=writedata[55:48];
            end
            4'b0111:begin
                memory_array[{address[27:0],counter}]=writedata[63:56];
            end
            4'b1000:begin
                memory_array[{address[27:0],counter}]=writedata[71:64];
            end
            4'b1001:begin
                memory_array[{address[27:0],counter}]=writedata[79:72];
            end
            4'b1010:begin
                memory_array[{address[27:0],counter}]=writedata[87:80];
            end
            4'b1011:begin
                memory_array[{address[27:0],counter}]=writedata[95:88];
            end
            4'b1100:begin
                memory_array[{address[27:0],counter}]=writedata[103:96];
            end
            4'b1101:begin
                memory_array[{address[27:0],counter}]=writedata[111:104];
            end
            4'b1110:begin
                memory_array[{address[27:0],counter}]=writedata[119:112];
            end
            4'b1111:begin
                memory_array[{address[27:0],counter}]=writedata[127:120];
            end
        endcase
        // counter = counter+4'b0001;

        //busywait = 1;
		// memory_array[{address,4'b0000}] = #40 writedata[7:0]    ;
        // memory_array[{address,4'b0001}] = #40 writedata[15:8]   ;
        // memory_array[{address,4'b0010}] = #40 writedata[23:16]  ;
        // memory_array[{address,4'b0011}] = #40 writedata[31:24]  ;
        // memory_array[{address,4'b0100}] = #40 writedata[39:32]  ;
        // memory_array[{address,4'b0101}] = #40 writedata[47:40]  ;
        // memory_array[{address,4'b0110}] = #40 writedata[55:48]  ;
        // memory_array[{address,4'b0111}] = #40 writedata[63:56]  ;
        // memory_array[{address,4'b1000}] = #40 writedata[71:64]  ;
        // memory_array[{address,4'b1001}] = #40 writedata[79:72]  ;
        // memory_array[{address,4'b1010}] = #40 writedata[87:80]  ;
        // memory_array[{address,4'b1011}] = #40 writedata[95:88]  ;
        // memory_array[{address,4'b1100}] = #40 writedata[103:96] ;
        // memory_array[{address,4'b1101}] = #40 writedata[111:104];
        // memory_array[{address,4'b1110}] = #40 writedata[119:112];
        // memory_array[{address,4'b1111}] = #40 writedata[127:120];
		//busywait = 0;

	// end

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

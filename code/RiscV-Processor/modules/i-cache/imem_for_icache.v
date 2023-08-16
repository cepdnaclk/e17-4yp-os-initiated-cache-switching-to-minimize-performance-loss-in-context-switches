`timescale  1ns/100ps
module Instruction_memory(
    // inputs
    reset,
    clock,
    read,
    address,
    // output
    readdata,
    
    busywait
);

// Inputs
input reset;
input               clock;
input               read;
input[27:0]          address;

// Outputs
output reg [127:0]  readdata;
output reg          busywait;

reg [3:0]counter; // Track the current byte of the instruction that is being read
reg readaccess; // Indicate the status of the instruction


//Declare memory array 1024x8-bits
reg [7:0] memory_array [0:1023];

//Initialize instruction memory
initial
begin

    // $readmemh("memfile.mem", memory_array);
    // // r0 <- $0 + 1000
    // memory_array[0] = 8'h13;
    // memory_array[1] = 8'h00;
    // memory_array[2] = 8'h80;
    // memory_array[3] = 8'hc1;
    
  
    // // 2. r1 <- $0 + 2
    // memory_array[4] = 8'h93;
    // memory_array[5] = 8'h80;
    // memory_array[6] = 8'h20;
    // memory_array[7] = 8'h00;

    // // Nope
    // memory_array[8] = 8'h00;
    // memory_array[9] = 8'h00;
    // memory_array[10] = 8'h00;
    // memory_array[11] = 8'h00;

    // // Nope
    // memory_array[12] = 8'h00;
    // memory_array[13] = 8'h00;
    // memory_array[14] = 8'h00;
    // memory_array[15] = 8'h00;


    // //  r3 <- 9 or 4 
    // memory_array[16] = 8'ha3;
    // memory_array[17] = 8'ha2;
    // memory_array[18] = 8'h00;
    // memory_array[19] = 8'h00;

    // // Nope
    // memory_array[20] = 8'h00;
    // memory_array[21] = 8'h00;
    // memory_array[22] = 8'h00;
    // memory_array[23] = 8'h00;

    // // Nope
    // memory_array[24] = 8'h00;
    // memory_array[25] = 8'h00;
    // memory_array[26] = 8'h00;
    // memory_array[27] = 8'h00;

    // //  r3 <- 9 or 4 
    // memory_array[28] = 8'h03;
    // memory_array[29] = 8'ha1;
    // memory_array[30] = 8'h50;
    // memory_array[31] = 8'h00;

    // r0 <- $0 + -1000
    memory_array[0] = 8'h13;
    memory_array[1] = 8'h00;
    memory_array[2] = 8'h80;
    memory_array[3] = 8'hc1;
    
  
    // 2. r1 <- $0 + 2
    memory_array[4] = 8'h93;
    memory_array[5] = 8'h80;
    memory_array[6] = 8'h20;
    memory_array[7] = 8'h00;

    // // Nope
    // memory_array[8] = 8'h00;
    // memory_array[9] = 8'h00;
    // memory_array[10] = 8'h00;
    // memory_array[11] = 8'h00;

    // // Nope
    // memory_array[12] = 8'h00;
    // memory_array[13] = 8'h00;
    // memory_array[14] = 8'h00;
    // memory_array[15] = 8'h00;


    // // 5. Nope
    // memory_array[16] = 8'h00;
    // memory_array[17] = 8'h00;
    // memory_array[18] = 8'h00;
    // memory_array[19] = 8'h00;

    // // Nope
    // memory_array[20] = 8'h00;
    // memory_array[21] = 8'h00;
    // memory_array[22] = 8'h00;
    // memory_array[23] = 8'h00;

    // // Cache selection   cache =2
    // memory_array[24] = 8'h7f;
    // memory_array[25] = 8'h20;
    // memory_array[26] = 8'h00;
    // memory_array[27] = 8'h00;

    // // 8. sw x0, 5(x1)  add=7, store -1000
    // // 0x0000a2a3
    // memory_array[28] = 8'ha3;
    // memory_array[29] = 8'ha2;
    // memory_array[30] = 8'h00;
    // memory_array[31] = 8'h00;

end

//Detecting an incoming memory access
always @(*)
begin
    busywait <= (read && counter!=4'b1111)? 1 : 0; // if cpu want to read and counter is not at the end of the instruction
    readaccess <= (read)? 1'b1 : 1'b0; // cpu reading the instruction
end

always @(posedge clock,posedge reset) begin
    if (reset) begin
        counter <= 4'b0000;
    end
    else if(readaccess)
    begin
        counter <= counter+4'b0001;
    end
end
//Reading
always @(posedge clock,posedge reset)
begin
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

end
 
endmodule

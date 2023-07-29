module Data_load_controller (
    func3,
    data_mem_in,
    data_out
);

input [2:0] func3;
input [31:0] data_mem_in;
output reg [31:0] data_out;
wire [31:0] lb,lbu,lh,lhu;

assign lb ={{24{data_mem_in[7]}},data_mem_in[7:0]}; // take last 8 bits and 24 of sign bit
assign lbu ={{24{1'b0}},data_mem_in[7:0]}; // take last 8 bits and 24 of zero values and extend
assign lh ={{16{data_mem_in[15]}},data_mem_in[15:0]}; // take last 16 bits and 16 of sign bit
assign lhu ={{16{1'b0}},data_mem_in[15:0]}; // take last 16 bits and 16 of zero values end extend


always @(*) begin
    case(func3)
        3'b000:begin
            data_out<=lb;
        end
        3'b001:begin
            data_out<=lh;
        end
        3'b010:begin
            data_out<=data_mem_in; // load the word 32 bit
        end
        3'b100:begin
            data_out<=lbu;
        end
        default:begin
            data_out<=lhu;
        end
    endcase
end
    
endmodule
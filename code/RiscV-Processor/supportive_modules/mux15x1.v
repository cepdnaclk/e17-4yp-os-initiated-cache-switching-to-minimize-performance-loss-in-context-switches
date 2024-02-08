module mux15x1 (
    input [31:0]indata1,
    input [31:0]indata2,
    input [31:0]indata3,
    input [31:0]indata4,
    input [31:0]indata5,
	input [31:0]indata6,
	input [31:0]indata7,
    input [31:0]indata8,
    input [31:0]indata9,
    input [31:0]ind10,
    input [31:0]ind11,
    input [31:0]ind12,
    input [31:0]ind13,
    input [31:0]ind14,
    input [31:0]ind15,
    input [3:0]select,
    output reg [31:0] out
);

always @(*) begin
    case (select)
        4'b0000:begin
            out<=indata1;
        end
        4'b0001:begin
            out<=indata2;
        end
        4'b0010:begin
            out<=indata3;
        end
        4'b0011:begin
            out<=indata4;
        end
        4'b0100:begin
            out<=indata5;
        end
		4'b0101:begin
            out<=indata6;
        end
		4'b0110:begin
            out<=indata7;
        end
		4'b0111:begin
            out<=indata8;
        end
        4'b1000:begin
            out<=indata9;
        end
        4'b1001:begin
            out<=ind10;
        end
        4'b1010:begin
            out<=ind11;
        end
        4'b1011:begin
            out<=ind12;
        end
        4'b1100:begin
            out<=ind13;
        end
        4'b1101:begin
            out<=ind14;
        end
		default:begin
            out<=ind15;
        end
    endcase
end
    
endmodule
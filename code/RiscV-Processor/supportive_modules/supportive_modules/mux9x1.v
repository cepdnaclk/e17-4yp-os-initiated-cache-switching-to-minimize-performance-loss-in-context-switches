module mux9x1 (
    input [31:0]in1,
    input [31:0]in2,
    input [31:0]in3,
    input [31:0]in4,
    input [31:0]in5,
	input [31:0]in6,
	input [31:0]in7,
    input [31:0]in8,
    input [31:0]in9,
    input [3:0]select,
    output reg [31:0] out
);

always @(*) begin
    case (select)
        4'b0000:begin
            out<=in1;
        end
        4'b0001:begin
            out<=in2;
        end
        4'b0010:begin
            out<=in3;
        end
        4'b0011:begin
            out<=in4;
        end
        4'b0100:begin
            out<=in5;
        end
		  4'b0101:begin
            out<=in6;
        end
		  4'b0110:begin
            out<=in7;
        end
		  4'b0111:begin
            out<=in8;
        end
		  default:begin
            out<=in9;
        end
    endcase
end
    
endmodule
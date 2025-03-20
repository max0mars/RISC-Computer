module Encoder32(
	input wire unsigned [31:0] in,
	output wire [4:0] out
);
reg [4:0] q = 0;
assign out = q;
always @(*) begin
	case (in)
		1'b1 << 0: q = 5'd0;
		1'b1 << 1: q = 5'd1;
		1'b1 << 2: q = 5'd2;
		1'b1 << 3: q = 5'd3;
		1'b1 << 4: q = 5'd4;
		1'b1 << 5: q = 5'd5;
		1'b1 << 6: q = 5'd6;
		1'b1 << 7: q = 5'd7;
		1'b1 << 8: q = 5'd8;
		1'b1 << 9: q = 5'd9;
		1'b1 << 10: q = 5'd10;
		1'b1 << 11: q = 5'd11;
		1'b1 << 12: q = 5'd12;
		1'b1 << 13: q = 5'd13;
		1'b1 << 14: q = 5'd14;
		1'b1 << 15: q = 5'd15;
		1'b1 << 16: q = 5'd16;
		1'b1 << 17: q = 5'd17;
		1'b1 << 18: q = 5'd18;
		1'b1 << 19: q = 5'd19;
		1'b1 << 20: q = 5'd20;
		1'b1 << 21: q = 5'd21;
		1'b1 << 22: q = 5'd22;
		1'b1 << 23: q = 5'd23;
		1'b1 << 24: q = 5'd24;
		1'b1 << 25: q = 5'd25;
		1'b1 << 26: q = 5'd26;
		1'b1 << 27: q = 5'd27;
		1'b1 << 28: q = 5'd28;
		1'b1 << 29: q = 5'd29;
		1'b1 << 30: q = 5'd30;
		1'b1 << 31: q = 5'd31;
		default: q = 5'dx;
	endcase
end 

endmodule 
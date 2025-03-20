module rotate_left_bits(
	input [31:0] RA, RB,
	output reg[31:0] RC
	);
	

integer i;

always @(*) begin
	// MSB gets shifted, filled with 0
	RC <= (RA << RB) | (RA >> (32 - RB));
end
endmodule

module logical_shift_left_bits(

	input [31:0] RA, RB,
	output reg[31:0] RC

);
integer i;
always @(*) begin
	RC <= RA << RB;

end
endmodule
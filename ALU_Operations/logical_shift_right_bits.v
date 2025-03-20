module logical_shift_right_bits(
	input [31:0] RA,
	input [31:0] RB,
	output reg[31:0] RC
);
integer i;
always @(*) begin
	RC <= RA >> RB;
end
endmodule


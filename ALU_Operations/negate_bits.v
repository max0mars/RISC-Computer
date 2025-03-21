module negate_bits(
	input [31:0] RB,
	output [31:0] RC
	);
	

// invert the value and add one to get two's complement
assign RC = ~RB + 1;
endmodule

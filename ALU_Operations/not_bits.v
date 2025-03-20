module not_bits(
	input [31:0] RB,
	output [31:0] RC
	);
	

// invert the value
assign RC = ~RB;
endmodule

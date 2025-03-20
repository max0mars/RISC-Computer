module or_bits(
	input [31:0] RA, RB,
	output [31:0] RC
);
	

assign RC = RA | RB;
endmodule

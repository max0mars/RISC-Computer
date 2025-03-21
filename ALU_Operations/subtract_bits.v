module subtract_bits (
	
	// two input values
	input [31:0] RA, RB,
	
	// subtracted output value
	output reg[31:0] RC
);

// 33 bit register for carry, extra bit for sign
reg[32:0] local_carry = 33'b0;

//integer i to access each bit within the registers
integer i;

// temporary register to hold the 2's complement number for subtraction
reg [31:0] twos_complement;

always @(*) begin
	// LSB is a 1 for two's complement
	twos_complement = ~RB + 1;
	
//	for(i = 0; i < 32; i = i + 1) begin
//	// compute two's complement 
//		twos_complement = RB[i] ^ 1'b1;
//	end
	
	for(i = 0; i < 32; i = i + 1) begin
	// use carry out and carry in formulas from class
		RC[i] = RA[i] ^ twos_complement[i] ^ local_carry[i];
		local_carry[i+1] = (RA[i] & twos_complement[i]) | (local_carry[i] & RA[i]) | (local_carry[i] & twos_complement[i]);
	end
end
endmodule

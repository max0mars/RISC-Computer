module add_bits (
	
	// two input values
	input [31:0] RA, RB,
	
	// added output value
	output reg[31:0] RC
);

// 33 bit register for carry, one for sign one for overflow
reg[32:0] local_carry = 33'b0;

//integer i to access each bit within the registers
integer i;

always @(*) begin
	for(i = 0; i < 32; i = i + 1) begin
	// use carry out and carry in formulas from class
		RC[i] <= RA[i] ^ RB[i] ^ local_carry[i];
		local_carry[i+1] = (RA[i] & RB[i]) | (local_carry[i] & RA[i]) | (local_carry[i] & RB[i]); //might need to change this last part
	end
end
endmodule

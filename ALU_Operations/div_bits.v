 module div_bits(
   
  input signed [31:0] RA, RB, 
  output [63:0] RZ
);
	
reg[32:0] A;
reg[31:0] Q, M;
reg negative;

integer i;
always @ (*) begin
	if(RA[31] == 1) begin
		negative = 1;
		Q = -RA;
	end else begin
		negative = 0;
		Q = RA;
	end
	
	A = 33'b0;
	M = RB;
	
	for (i=0;i<32;i=i+1) begin
		A = A << 1;
		A[0] = Q[31];
		Q = Q << 1;
		
		A = A - M;
		if(A[32] == 1) begin
			A = A + M;//restore
			//Q[0] is already 0
		end else begin
			Q[0] = 1'b1;
		end
	end
	if(negative == 1) begin
		Q = -Q;
	end
end
assign RZ = {A[31:0], Q};

endmodule

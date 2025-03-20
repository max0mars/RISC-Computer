module Zregister(
	input clear, clock, ZEn,
	
	input[63:0] result,
	
	output[31:0] ZHiVal, ZLoVal
);
reg[63:0] q;
initial q = 0;
assign ZHiVal = q[63:32];
assign ZLoVal = q[31:0];
always @ (posedge clock) begin 
	if (clear) begin
		q <= 64'd0;
	end else if (ZEn) begin
		q <= result;
	end
end
endmodule 
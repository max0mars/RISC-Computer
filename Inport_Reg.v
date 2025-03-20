module Inport_Reg (
	input clear, 
	input [31:0]Input,
	output wire [31:0]Output
);

reg [31:0]q = 31'b0;
always @ (*)
		begin
			if (clear) begin
				q <= 32'b0;
			end
			else begin
				q <= Input;
			end
		end

assign Output = q;
endmodule

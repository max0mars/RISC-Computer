module r0_Register #(parameter DATA_WIDTH = 32, INIT = 32'h0)(
	input clear, clock, enable, 
	input [DATA_WIDTH-1:0]Input,
	input BAOut,
	output wire [DATA_WIDTH-1:0]Output
);
reg [DATA_WIDTH-1:0]q;
initial q = INIT;
always @ (posedge clock)
		begin 
			if (clear) begin
				q <= {DATA_WIDTH{1'b0}};
			end
			else if (enable) begin
				q <= Input;
			end
		end
		assign Output = (BAOut) ? {DATA_WIDTH{1'b0}} : q;
endmodule
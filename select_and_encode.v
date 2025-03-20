module select_and_encode(
	input wire Gra, Grb, Grc,
	input wire [31:0] IR,
	input wire RIn, ROut, BAOut,

	output reg [15:0] R_In,
	output reg [15:0] R_Out
);


wire [3:0] Ra, Rb, Rc;
reg [3:0] selected_reg;

assign Ra = IR[26:23];
assign Rb = IR[22:19];
assign Rc = IR[18:15];


always @(*) begin
	selected_reg = 4'b0000;
	if (Gra) selected_reg = Ra;
	else if (Grb) selected_reg = Rb;
	else if (Grc) selected_reg = Rc;
	
	R_In <= 16'b0;
	R_Out <= 16'b0;
	
	if (RIn)
		R_In[selected_reg] <= 1'b1;
	if (ROut || BAOut)
		R_Out[selected_reg] <= 1'b1; // one-hot encoded bit goes in corresponded index, determined by correct IR
end
endmodule
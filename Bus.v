module Bus (
	//Mux
	input wire [31:0] R0In, R1In, R2In, R3In, R4In, R5In, R6In, R7In, R8In, R9In, R10In, R11In, R12In, R13In, R14In, R15In,
	input wire [31:0] HiIn, LoIn, ZHiIn, ZLoIn, PCIn, MDRIn, IPortIn, 
	input wire [31:0] CIn,
	
	input wire [15:0] regOut,
	
	input wire HiOut, LoOut, ZHiOut, ZLoOut, PCOut, MDROut, IPortOut, COut,// added IPORTOUT
	
	//removed temp
	output [31:0]BusMuxOut
);

reg [31:0]q;

wire [31:0] EncoderIn;
wire [4:0] EncoderOut;

assign EncoderIn = {8'b0, COut, IPortOut, MDROut, PCOut, ZLoOut, ZHiOut, LoOut, HiOut, regOut};//changed for phase 2
Encoder32 e32 (EncoderIn, EncoderOut);

always @ (*) begin
	casex (EncoderOut)//removed temp
		0: q = R0In;
		1: q = R1In;
		2: q = R2In;
		3: q = R3In;
		4: q = R4In;
		5: q = R5In;
		6: q = R6In;
		7: q = R7In;
		8: q = R8In;
		9: q = R9In;
		10: q = R10In;
		11: q = R11In;
		12: q = R12In;
		13: q = R13In;
		14: q = R14In;
		15: q = R15In;
		16: q = HiIn;
		17: q = LoIn;
		18: q = ZHiIn;
		19: q = ZLoIn;
		20: q = PCIn;
		21: q = MDRIn;
		22: q = IPortIn;
		//23: q = {{13{CIn[18]}}, CIn};
		23: q = CIn;
		default: q = {32{1'b0}};
	endcase
end

assign BusMuxOut = q;
endmodule

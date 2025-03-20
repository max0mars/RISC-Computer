`timescale 1ns/10ps

module Demo_NEG_tb();


reg clock, clear;
reg [3:0] present_state;


reg [15:0] regOut = 0;
reg HiOut = 0, LoOut = 0, ZHiOut = 0, ZLoOut = 0, PCOut = 0, MDROut = 0, YOut = 0;
reg [15:0] regIn = 0;
reg HiIn = 0, LoIn = 0, ZIn = 0, PCIn = 0, MDRIn = 0, YIn = 0;
reg [31:0] temp = 0;
reg tempEnable = 0;

reg [31:0] Mdata = 0;
reg MDRread = 0;

reg [4:0] ALUcode;

//setup top-level module here:
DataPath dp(
	clock, clear, 
	
	regIn, 
	HiIn, LoIn, ZIn, PCIn, MDRIn, YIn, 
	
	regOut, 
	HiOut, LoOut, ZHiOut, ZLoOut, PCOut, MDROut,
	
	Mdata, MDRread, 
	ALUcode, 
	temp, tempEnable
	);
	
//states and clock control:
parameter init = 4'd1, T0 = 4'd2, T1 = 4'd3, T2 = 4'd4, T3 = 4'd5, T4 = 4'd6, T5 = 4'd7, T6 = 4'd8, T7 = 4'd9, T8 = 4'd10;//can add more states here
initial begin clock = 0; present_state = 4'd0; end
always #10 clock = ~clock;
always @ (negedge clock) present_state = present_state + 1;



always @(present_state) begin
	case(present_state)
		init: begin //put b1010 into R3
			temp <= 32'b1010;
			tempEnable <= 1;
			regIn[0] <= 1;
			#15 tempEnable <= 0; regIn <= 16'd0;
		end
		T0: begin //put b1111 into R7

		end
		T1: begin
			Mdata <= 'b1000101010000xxxxxxxxxxxxxxxxxxx;//PC ins for: neg R5, R0
			MDRread <= 1;
			MDRIn <= 1;
			#15 MDRIn <= 0;
		end
		T2: begin

		end
		T3: begin
			regOut[0] <= 1;
			ZIn <= 1;
			ALUcode <= 5'b10001;
			#15 regOut[0] <= 0; ZIn <= 0;
		end
		T4: begin
			ZLoOut <= 1;
			regIn[5] <= 1;
			#15 ZLoOut <= 0; regIn[5] <= 0;
		end
	endcase
end
endmodule 
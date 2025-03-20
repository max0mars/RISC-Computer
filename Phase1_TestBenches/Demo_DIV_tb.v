`timescale 1ns/10ps

module Demo_DIV_tb();


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
		init: begin //put first test value into R2
			temp <= 32'd6;
			tempEnable <= 1;
			regIn[2] <= 1;
			#15 tempEnable <= 0; regIn <= 16'd0;
		end
		T0: begin //put second test value into R6
			temp <= -32'd15;
			tempEnable <= 1;
			regIn[6] <= 1;
			#15 tempEnable <= 0; regIn <= 16'd0;
		end
		T1: begin
			Mdata <= 'b01111_0010_0110_xxxxxxxxxxxxxxxxxxx;//PC ins for: mul R2, R6
			MDRread <= 1;
			MDRIn <= 1;
			#15 MDRIn <= 0;
		end
		T2: begin
			YIn <= 1;
			regOut[2] <= 1;
			#15 YIn <= 0; regOut[2] <= 0;
		end
		T3: begin
			regOut[6] <= 1;
			ZIn <= 1;
			ALUcode <= 5'b01111;
			#15 regOut[6] <= 0; ZIn <= 0;
		end
		T4: begin
			ZLoOut <= 1;
			LoIn <= 1;
			#15 ZLoOut <= 0; LoIn <= 0;
		end
		T5: begin
			ZHiOut <= 1;
			HiIn <= 1;
			#15 ZHiOut <= 0; HiIn <= 0;
		end
	endcase
end
endmodule 
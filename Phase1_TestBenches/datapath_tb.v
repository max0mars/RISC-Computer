`timescale 1ns/10ps

//testbench name with ();
module datapath_tb();


reg clock, clear;
reg [3:0] present_state;


//anything with a 'reg' is being changed by you
reg [15:0] regSelect = 0;
reg HiSel = 0, LoSel = 0, ZHiSel = 0, ZLoSel = 0, PCSel = 0, MDRSel = 0, YSel = 0;

reg [15:0] regEnable = 16'b0;
reg HiEn = 0, LoEn = 0, ZEn = 0, PCEn = 0, MDREn = 0, InPortEn = 0, YEn = 0;
reg [31:0] temp = 0;
reg tempEnable = 0;

reg [31:0] Mdata = 0;
reg MDRread = 0;

reg [4:0] ALUcode = 5'b111;

//setup top-level module here:
DataPath dp(
	clock, clear, 
	
	regEnable, 
	HiEn, LoEn, ZEn, PCEn, MDREn, YEn, 
	
	regSelect, 
	HiSel, LoSel, ZHiSel, ZLoSel, PCSel, MDRSel,
	
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
		init: begin
			clear <= 1;
			#15 clear <= 0;
		end
		T0: begin
			temp <= 32'b1010;
			tempEnable <= 1;
			regEnable[0] <= 1;
			#15 tempEnable <= 0; regEnable <= 16'd0;
		end
		T1: begin
			temp <= 32'b1111;
			tempEnable <= 1;
			regEnable[8] <= 1;
			#15 tempEnable <= 0; regEnable <= 16'd0;
		end
		T2: begin
			YEn <= 1;
			regSelect[0] <= 1;
			#15 YEn <= 0; regSelect[0] <= 0;
		end
		T3: begin
			regSelect[8] <= 1;
			ZEn <= 1;
			ALUcode <= 4'd0;
			#15 regSelect[8] <= 0; ZEn <= 0;
		end
		T4: begin
			regSelect[8] <= 1;
			ZEn <= 1;
			ALUcode <= 4'd1;
			#15 regSelect[8] <= 0; ZEn <= 0;
		end
		T5: begin
			regSelect[8] <= 1;
			ZEn <= 1;
			ALUcode <= 4'd2;
			#15 regSelect[8] <= 0; ZEn <= 0;
		end
		T6: begin
			regSelect[8] <= 1;
			ZEn <= 1;
			ALUcode <= 4'd3;
			#15 regSelect[8] <= 0; ZEn <= 0;
		end
		T7: begin
			regSelect[8] <= 1;
			ZEn <= 1;
			ALUcode <= 4'd6;
			#15 regSelect[8] <= 0; ZEn <= 0;
		end
		T8: begin
			regSelect[8] <= 1;
			ZEn <= 1;
			ALUcode <= 4'd8;
			#15 regSelect[8] <= 0; ZEn <= 0;
		end
	endcase
end
endmodule 
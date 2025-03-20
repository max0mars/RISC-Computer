`timescale 1ns/10ps
module DEMO_mfhi();

reg clock, clear;
reg [3:0] present_state;

reg HiIn, LoIn, ZIn, PCIn, MDRIn, MARIn, YIn, OPortIn, IRIn;
initial {HiIn, LoIn, ZIn, PCIn, MDRIn, MARIn, YIn, OPortIn, IRIn} = 0;
reg HiOut, LoOut, ZHiOut, ZLoOut, PCOut, MDROut, IPortOut, COut;
initial {HiOut, LoOut, ZHiOut, ZLoOut, PCOut, MDROut, IPortOut, COut} = 0;

reg [31:0] IPortInput = 0;

reg Gra, Grb, Grc, RIn, ROut, BAOut;
initial {Gra, Grb, Grc, RIn, ROut, BAOut} = 0;

reg Conin = 0;
wire ConOut;

reg memread = 0, memwrite = 0;
reg [4:0] ALUCode = 0;
reg initMem = 0;

DataPath dp(
	clock, clear, 
	HiIn, LoIn, ZIn, PCIn, MDRIn, MARIn, YIn, OPortIn, IRIn,
	HiOut, LoOut, ZHiOut, ZLoOut, PCOut, MDROut, IPortOut, COut,
	IPortInput,
	Gra, Grb, Grc, RIn, ROut, BAOut,
	Conin, ConOut,
	memread, memwrite, 
	ALUCode,
	initMem
);


//states and clock control:
parameter init1 = 4'd1, init2 = 4'd2, init3 = 4'd3, T0 = 4'd4, T1 = 4'd5, T2 = 4'd6, T3 = 4'd7, T4 = 4'd8, T5 = 4'd9, T6 = 4'd10, T7 = 4'd11;//can add more states here
initial begin clock = 0; present_state = 4'd0; end
always #10 clock = ~clock;
always @ (negedge clock) present_state = present_state + 1;



always @(present_state) begin
	case(present_state)
		init1: begin //Preload Hi reg with value
			initMem = 1;
			IPortInput = 32'd888;
			IPortOut = 1;
			HiIn = 1;
			#15 HiIn = 0; IPortOut = 0; initMem = 0;
		end
		init2: begin
			//nothing happens
		end
		init3: begin
			PCIn = 1;
			IPortInput = 32'd361;//preload PC with instruction memory location
			IPortOut = 1;
			#15 PCIn = 0; IPortOut = 0;
		end
		T0: begin
			PCOut = 1; MARIn = 1; ALUCode = 5'b11111; ZIn = 1;
			#15 PCOut = 0; MARIn = 0; ALUCode = 5'b0; ZIn = 0;
		end
		T1: begin
			ZLoOut = 1; PCIn = 1; memread = 1; MDRIn = 1;
			#15 ZLoOut = 0; PCIn = 0; memread = 0; MDRIn = 0;
		end
		T2: begin
			MDROut = 1; IRIn = 1;
			#15 MDROut = 0; IRIn = 0;
		end
		T3: begin
			Gra = 1; RIn = 1; HiOut = 1;
			#15 Gra = 0; RIn = 0; HiOut = 0;
		end
		T4: begin

		end
		T5: begin

		end
		T6: begin

		end
		T7: begin

		end
	endcase
end
endmodule 
`timescale 1ns/10ps
module bus_tb();
reg clock, clear;
reg [3:0] present_state;

reg [23:0] dataSelect; //R0Out, R1Out, R2Out, R3Out, R4Out, R5Out, R6Out, R7Out, R8Out, R9Out, R10Out, R11Out, R12Out, R13Out, R14Out, R15Out;
//reg HiOut, LoOut, ZHiOut, ZLowOut, PCOut, MDROut, InPortOut, YOut;


reg [31:0] R0In, R1In, R2In, R3In, R4In, R5In, R6In, R7In, R8In, R9In, R10In, R11In, R12In, R13In, R14In, R15In;
reg [31:0] HiIn, LoIn, ZHiIn, ZLoIn, PCIn, MDRIn, InPortIn, CIn;


wire [31:0] BusOut;

Bus bus(
	R0In, R1In, R2In, R3In, R4In, R5In, R6In, R7In, R8In, R9In, R10In, R11In, R12In, 
	R13In, R14In, R15In, HiIn, LoIn, ZHiIn, ZLoIn, PCIn, MDRIn, InPortIn, CIn, 
	dataSelect, BusOut
);
parameter init = 4'd1, T0 = 4'd2, T1 = 4'd3, T2 = 4'd4;
			 
initial begin clock = 0; present_state = 4'd0; end
always #10 clock = ~clock;
always @ (negedge clock) present_state = present_state + 1;
	
always @(present_state) begin
	case(present_state)
		init: begin
			clear <= 1;
			dataSelect = 23'b0;
			R0In = 32'd732;
			R1In = 32'd57;
			R2In = 32'd12586;
			R3In = 32'd428;
			R4In = 32'd97;
			R5In = 32'd23;
			R6In = 32'd8888;
			InPortIn = 32'd9999;
			CIn = 32'b0;
			#15 clear <= 0;
		end
		T0: begin
			dataSelect[0] = 1;
			#15 dataSelect[0] <= 0;
		end
		T1: begin
			dataSelect[6] = 1;
			#15 dataSelect[6] <= 0;
		end
		T2: begin
			dataSelect[23] = 1;
			#15 dataSelect[23] <= 0;
		end

	endcase
end
endmodule
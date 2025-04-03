`timescale 1ns/10ps

module DEMO_phase3();

reg clock, initmem;
reg [3:0] present_state;
reg [31:0] in;
reg clear, reset, stop;
reg start;

DataPath dp(.clock(clock), .IPortInput(in), .initMem(initmem), .reset(reset), .stop(stop));

initial begin 
	clock = 0; start = 0; 
	clear = 0;
	reset = 0;
	stop = 0;
end

always #10 clock = ~clock;



always @ (negedge clock) begin
	if(start == 0)begin
		start = 1;
		initmem = 1;
	end else initmem = 0;
end





endmodule 
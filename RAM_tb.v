`timescale 1ns/10ps

module RAM_tb();

reg clock, r, w;
reg [3:0] present_state;
reg [8:0] addr;
reg [31:0] din;
wire [31:0] dout;


RAM dp(r, w, addr, din, dout);


parameter T1 = 4'd1, T2 = 4'd2, T3 = 4'd3, T4 = 4'd4, T5 = 4'd5; //can add more states here
initial begin clock = 0; present_state = 4'd0; end
always #10 clock = ~clock;
always @ (negedge clock) present_state = present_state + 1;





always @(present_state) begin
	case(present_state)
		T1: begin
			addr = 10'd100;
			din = 32'd145;
			w = 1;
			#15 w = 0;
		end
		T2: begin
			addr = 10'd200;
			din = 32'd245;
			w = 1;
			#15 w = 0;
		end
		T3: begin
			addr = 10'd300;
			din = 32'd345;
			w = 1;
			#15 w = 0;
		end
		T4: begin
			addr = 10'd100;
			r = 1;
			#15 r = 0;
		end
		T5: begin
			addr = 10'd300;
			r = 1;
			#15 r = 0;
		end
	endcase
end
endmodule 
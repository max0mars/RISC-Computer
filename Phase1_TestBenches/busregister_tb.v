`timescale 1ns/10ps
module busregister_tb();
reg clock, clear;
reg [3:0] present_state;

reg [31:0] temp;
reg tempEnable;

reg RE1, RE2;
reg Out1, Out2;

DataPath dp(clock, clear, RE1, RE2, Out1, Out2, temp, tempEnable);


parameter init = 4'd1, T0 = 4'd2, T1 = 4'd3, T2 = 4'd4;
			 
initial begin clock = 0; present_state = 4'd0; end
always #10 clock = ~clock;
always @ (negedge clock) present_state = present_state + 1;

always @(present_state) begin
	case(present_state)
		init: begin //reset everything
			clear <= 1;
			RE1 <= 0; RE2 <= 0; Out1 <= 0; Out2 <= 0; tempEnable<= 0;
			#15 clear <= 0;
		end
		T0: begin //send 186 to the bus via temp. then send 186 to Register1 from the busout
			temp <= 32'd186;
			tempEnable <= 1;
			RE1 <= 1;
			#15 tempEnable <= 0; RE1 <= 0;
		end
		T1: begin //send 0 to the bus via temp
			temp <= 32'b0;
			tempEnable <= 1;
			#15 tempEnable <= 0;
		end
		T2: begin // send 186 to the bus from register 1. then send 186 to register2 from the busout
			Out1 <= 1;
			RE2 <= 1;
			#15 RE2 <= 0; Out1 <= 0;
		end

	endcase
end
endmodule 
module MDR (
	input clear, clock, enable, 
	input[31:0] Bus, Mdatain,
	input read,
	
	output reg [31:0] MDRout
);

always @ (posedge clock)
		begin
			if (clear) begin
				MDRout <= 0;
			end
			else if (enable) begin
				if(read) begin
					MDRout <= Mdatain;
				end else begin
					MDRout <= Bus;
				end
			end
		end

endmodule 
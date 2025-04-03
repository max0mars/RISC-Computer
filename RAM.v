module RAM (
	input wire r, w, //active high
	input wire [8:0] addr,
	input wire [31:0] din,
	output reg [31:0] dout,
	input wire START
);


reg [31:0] mem [0:511];

always @(*) begin
	dout <= 32'b0;
	if(r == 1) begin
		dout <= mem[addr];
	end else if(w == 1) begin
		mem[addr] <= din;
	end
	if(START == 1) begin
		mem['h0] <= 32'h09800065;
		mem['h1] <= 32'h09980003;
		mem['h2] <= 32'h01000054;
		mem['h3] <= 32'h09100001;
		mem['h4] <= 32'h0017FFFA;
		mem['h5] <= 32'h08800003;
		mem['h6] <= 32'h09800057;
		mem['h7] <= 32'h99980003;
		mem['h8] <= 32'h09980003;
		mem['h9] <= 32'h021FFFFA;
		mem['ha] <= 32'hD0000000;
		mem['hb] <= 32'h9A100002;
		mem['hc] <= 32'h0B180007;
		mem['hd] <= 32'h0AB7FFFC;
		mem['he] <= 32'h19988000;
		mem['hf] <= 32'h62200002;
		
		mem['h10] <= 32'h8A200000;
		mem['h11] <= 32'h92200000;
		mem['h12] <= 32'h6A20000F;
		mem['h13] <= 32'h39008000;
		mem['h14] <= 32'h72100007;
		mem['h15] <= 32'h51208000;
		mem['h16] <= 32'h49988000;
		mem['h17] <= 32'h11800092;
		mem['h18] <= 32'h41808000;
		mem['h19] <= 32'h32880000;
		mem['h1a] <= 32'h29180000;
		mem['h1b] <= 32'h12900054;
		mem['h1c] <= 32'h201A8000;
		mem['h1d] <= 32'h59188000;
		mem['h1e] <= 32'h0A800008;
		mem['h1f] <= 32'h0B000017;
		

		
		mem['h20] <= 32'h83280000;
		mem['h21] <= 32'hCA000000;
		mem['h22] <= 32'hC3800000;
		mem['h23] <= 32'h7B280000;
		mem['h24] <= 32'h0D280001;
		mem['h25] <= 32'h0DB7FFFD;
		mem['h26] <= 32'h0E380001;
		mem['h27] <= 32'h0EA00004;
		mem['h28] <= 32'hA6000000;
		mem['h29] <= 32'hD8000000;
		
		mem['h54] <= 32'h00000097;
		
		mem['h92] <= 32'h00000046;
		
		mem['hB9] <= 32'h1FD60000;
		mem['hBA] <= 32'h275E8000;
		mem['hBB] <= 32'h27FF0000;
		mem['hBC] <= 32'hAC000000;
	end
end

endmodule
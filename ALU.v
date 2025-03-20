module ALU(
input[31:0] A, B,

//control signals (1 bit per operation)
input[4:0] controlSig,

output [63:0] out
);

reg[63:0] q = 0;
assign out = q;

wire [31:0] andOut;
wire [31:0] orOut;
wire [31:0] addOut;
wire [31:0] subOut;
wire [63:0] mulOut;
wire [63:0] divOut;
wire [31:0] shrOut;
wire [31:0] shraOut;
wire [31:0] shlOut;
wire [31:0] rorOut;
wire [31:0] rolOut;
wire [31:0] negOut;
wire [31:0] notOut;


Andbits andd (A, B, andOut);
or_bits orr (A, B, orOut);
add_bits add (A, B, addOut);
subtract_bits sub (A, B, subOut);
mul_bits mul (A, B, mulOut);
div_bits div (A, B, divOut);
logical_shift_right_bits shr (A, B, shrOut);
arithmetic_shift_right_bits shra (A, B, shraOut);
logical_shift_left_bits shl (A, B, shlOut);
rotate_right_bits ror (A, B, rorOut);
rotate_left_bits rol (A, B, rolOut);
negate_bits neg (B, negOut);
not_bits nott (B, notOut);


always @ (*) begin
	case(controlSig)
		5'b00101: q <= andOut;
		5'b00110: q <= orOut;
		5'b00011: q <= addOut;
		5'b00100: q <= subOut;
		5'b10000: q <= mulOut;
		5'b01111: q <= divOut;
		5'b01001: q <= shrOut;
		5'b01010: q <= shraOut;
		5'b01011: q <= shlOut;
		5'b00111: q <= rorOut;
		5'b01000: q <= rolOut;
		5'b10001: q <= negOut;
		5'b10010: q <= notOut;
		5'b11111: q <= B + 1'b1;//increment PC
		default: q <= 'bx;
	endcase
end


endmodule 
module control_unit(
output reg	Gra, Grb, Grc, Rin, Rout, BAout, CONin,
				HIin, LOin, Zin, PCin, MDRin, MARin, Yin, OutPortin, IRin,
				HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout,
				Read, Write, Clear, Run,
output reg[4:0] ALUCode,
input[31:0] IR,
input			Clock, Reset, Stop, CON_FF

);

parameter OP_ld = 5'd0, OP_ldi = 5'd1, OP_st = 5'd2, OP_add = 5'd3, OP_sub = 5'd4, OP_and = 5'd5, OP_or = 5'd6, OP_ror = 5'd7, OP_rol = 5'd8, OP_shr = 5'd9,
			OP_shra = 5'd10, OP_shl = 5'd11, OP_addi = 5'd12, OP_andi = 5'd13, OP_ori = 5'd14, OP_div = 5'd15, OP_mul = 5'd16, OP_neg = 5'd17, OP_not = 5'd18,
			OP_br = 5'd19, OP_jal = 5'd20, OP_jr = 5'd21, OP_in = 5'd22, OP_out = 5'd23, OP_mflo = 5'd24, OP_mfhi = 5'd25, OP_nop = 5'd26, OP_halt = 5'd27;

parameter reset_state = 7'd1, T0 = 7'd2, T1 = 7'd3, T2 = 7'd4, 
ld3 = 7'd5, ld4 = 7'd6, ld5 = 7'd7, ld6 = 7'd8, ld7 = 7'd9,//got it
ldi3 = 7'd10, ldi4 = 7'd11, ldi5 = 7'd12,//got it
st3 = 7'd13, st4 = 7'd14, st5 = 7'd15, st6 = 7'd16,//got it
add3 = 7'd17, add4 = 7'd18, add5 = 7'd19,
sub3 = 7'd20, sub4 = 7'd21, sub5 = 7'd22,
and3 = 7'd23, and4 = 7'd24, and5 = 7'd25,
or3 = 7'd26, or4 = 7'd27, or5 = 7'd28,
ror3 = 7'd29, ror4 = 7'd30, ror5 = 7'd31,
rol3 = 7'd32, rol4 = 7'd33, rol5 = 7'd34,
shr3 = 7'd35, shr4 = 7'd36, shr5 = 7'd37,
shra3 = 7'd38, shra4 = 7'd39, shra5 = 7'd40,
shl3 = 7'd41, shl4 = 7'd42, shl5 = 7'd43,
addi3 = 7'd44, addi4 = 7'd45, addi5 = 7'd46,//got it
andi3 = 7'd47, andi4 = 7'd48, andi5 = 7'd49,//got it
ori3 = 7'd50, ori4 = 7'd51, ori5 = 7'd52,//got it
div3 = 7'd53, div4 = 7'd54, div5 = 7'd55,
mul3 = 7'd56, mul4 = 7'd57, mul5 = 7'd58,
neg3 = 7'd59, neg4 = 7'd60, neg5 = 7'd61,
not3 = 7'd62, not4 = 7'd63, not5 = 7'd64,
br3 = 7'd65, br4 = 7'd66, br5 = 7'd67, br6 = 7'd68,//got it
jal3 = 7'd69, jal4 = 7'd70,//got it
jr3 = 7'd71,//got it
in3 = 7'd72,//got it
out3 = 7'd73,//got it
mflo3 = 7'd74,//got it
mfhi3 = 7'd75,//got it
nop = 7'd76,//got it
halt = 7'd77;//got it

reg[6:0] present_state = 0;
reg stoped = 0;

always @(negedge Clock) begin
	if(Reset == 1) begin 
		present_state = reset_state;
		stoped = 0;
	end else begin
		case (present_state)
			reset_state: begin
				present_state = T0;
			end
			T0: present_state = T1;
			T1: present_state = T2;
			T2: begin
				//read OPCODE
				case (IR[31:27])
					OP_ld: present_state = ld3;
					OP_ldi: present_state = ldi3;
					OP_st: present_state = st3;
					OP_add: present_state = add3;
					OP_sub: present_state = sub3;
					OP_and: present_state = and3;
					OP_or: present_state = or3;
					OP_ror: present_state = ror3;
					OP_rol: present_state = rol3;
					OP_shr: present_state = shr3;
					OP_shra: present_state = shra3;
					OP_shl: present_state = shl3;
					OP_addi: present_state = addi3;
					OP_andi: present_state = andi3;
					OP_ori: present_state = ori3;
					OP_div: present_state = div3;
					OP_mul: present_state = mul3;
					OP_neg: present_state = neg3;
					OP_not: present_state = not3;
					OP_br: present_state = br3;
					OP_jal: present_state = jal3;
					OP_jr: present_state = jr3;
					OP_in: present_state = in3;
					OP_out: present_state = out3;
					OP_mflo: present_state = mflo3;
					OP_mfhi: present_state = mfhi3;
					OP_nop: present_state = nop;
					OP_halt: present_state = halt;
					default: present_state = reset_state;
				endcase
			end
			ld3: present_state = ld4;
			ld4: present_state = ld5;
			ld5: present_state = ld6;
			ld6: present_state = ld7;
			ld7: present_state = T0;
			//TODO: add transitions for all states
		endcase
	end
end



always @(present_state) begin
	case(present_state)
		reset_state: begin
			InPortout = 0; Read = 0; Write = 0;
			HIin = 0; LOin = 0; CONin = 0; PCin = 0; IRin = 0; Yin = 0; Zin = 0;
			MARin = 0; MDRin = 0; OutPortin = 0; Cout = 0; BAout = 0;
			Grc = 0; Grb = 0; Gra = 0; Rout = 0; Rin = 0;
			LOout = 0; HIout = 0; Zlowout = 0; Zhighout = 0; MDRout = 0; PCout = 0;
			ALUCode = 0;
			Clear = 0;
			Run = 0;
			#10 Run = 1;
		end
		
		T0: begin
			PCout = 1; MARin = 1; ALUCode = 5'b11111; Zin = 1;
			#15 PCout = 0; MARin = 0; ALUCode = 5'b0; Zin = 0;
		end
		T1: begin
			Zlowout = 1; PCin = 1; Read = 1; MDRin = 1;
			#15 Zlowout = 0; PCin = 0; Read = 0; MDRin = 0;
		end
		T2: begin
			MDRout = 1; IRin = 1;
			#15 MDRout = 0; IRin = 0;
		end
		
		// ld States
		ld3: begin
			Grb = 1; BAout = 1; Yin = 1;
			#15 Grb = 0; BAout = 0; Yin = 0;
		end
		ld4: begin
			Cout = 1; ALUCode = 5'b00011; Zin = 1;
			#15 Cout = 0; Zin = 0;
		end
		ld5: begin
			Zlowout = 1; MARin = 1;
			#15 Zlowout = 0; MARin = 0;
		end
		ld6: begin
			Read = 1; MDRin = 1;
			#15 Read = 0; MDRin = 0;
		end
		ld7: begin
			MDRout = 1; Gra = 1; Rin = 1;
			#15 MDRout = 0; Gra = 0; Rin = 0; 
		end
		
		// ldi States
		ldi3: begin
			Grb = 1; BAout = 1; Yin = 1;
			#15 Grb = 0; BAout = 0; Yin = 0;
		end
		ldi4: begin
			Cout = 1; ALUCode = 5'b00011; Zin = 1;
			#15 Cout = 0; Zin = 0;
		end
		ldi5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		
		// st states
		st3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		st4: begin
			Cout = 1; ALUCode = 5'b00011; Zin = 1;
			#15 Cout = 0; Zin = 0;
		end
		st5: begin
			Zlowout = 1; MARin = 1;
			#15 Zlowout = 0; MARin = 0;
		end
		st6: begin
			Write = 1; Gra = 1; Rout = 1;
			#15 Write = 0; Gra = 0; Rout = 0;
		end
		//add
		add3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		add4: begin
			Grc = 1; Rout = 1; ALUCode = 5'b00011; Zin = 1; //change code?
			#15 Grc = 0; Rout = 0; Zin = 0;
		end
		add5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		//sub
		sub3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		sub4: begin
			Grc = 1; Rout = 1; ALUCode = 5'b00011; Zin = 1; //change code
			#15 Grc = 0; Rout = 0; Zin = 0;
		end
		sub5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		//and
		and3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		and4: begin
			Grc = 1; Rout = 1; ALUCode = 5'b00011; Zin = 1; //change code
			#15 Grc = 0; Rout = 0; Zin = 0;
		end
		and5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		//or
		or3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		or4: begin
			Grc = 1; Rout = 1; ALUCode = 5'b00011; Zin = 1; //change code
			#15 Grc = 0; Rout = 0; Zin = 0;
		end
		or5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		//ror
		ror3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		ror4: begin
			Grc = 1; Rout = 1; ALUCode = 5'b00011; Zin = 1; //change code
			#15 Grc = 0; Rout = 0; Zin = 0;
		end
		ror5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		//rol
		rol3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		rol4: begin
			Grc = 1; Rout = 1; ALUCode = 5'b00011; Zin = 1; //change code
			#15 Grc = 0; Rout = 0; Zin = 0;
		end
		rol5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		//shr
		shr3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		shr4: begin
			Grc = 1; Rout = 1; ALUCode = 5'b00011; Zin = 1; //change code
			#15 Grc = 0; Rout = 0; Zin = 0;
		end
		shr5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		//shra
		shra3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		shra4: begin
			Grc = 1; Rout = 1; ALUCode = 5'b00011; Zin = 1; //change code
			#15 Grc = 0; Rout = 0; Zin = 0;
		end
		shra5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		//shl
		shl3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		shl4: begin
			Grc = 1; Rout = 1; ALUCode = 5'b00011; Zin = 1; //change code
			#15 Grc = 0; Rout = 0; Zin = 0;
		end
		shl5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		
		// addi States
		addi3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		addi4: begin
			Cout = 1; ALUCode = 5'b00011; Zin = 1;
			#15 Cout = 0; Zin = 0;
		end
		addi5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		// andi States
		andi3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		andi4: begin
			Cout = 1; ALUCode = 5'b00101; Zin = 1;
			#15 Cout = 0; Zin = 0;
		end
		andi5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		// ori States
		ori3: begin
			Grb = 1; Rout = 1; Rin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		ori4: begin
			Cout = 1; ALUCode = 5'b00110; Zin = 1;
			#15 Cout = 0; Zin = 0;
		end
		ori5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end

		//div
		div3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		div4: begin
			Grc = 1; Rout = 1; ALUCode = 5'b00011; Zin = 1; //change code
			#15 Grc = 0; Rout = 0; Zin = 0;
		end
		div5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		//mul
		mul3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		mul4: begin
			Grc = 1; Rout = 1; ALUCode = 5'b00011; Zin = 1; //change code
			#15 Grc = 0; Rout = 0; Zin = 0;
		end
		mul5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		//neg
		neg3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		neg4: begin
			Grc = 1; Rout = 1; ALUCode = 5'b00011; Zin = 1; //change code
			#15 Grc = 0; Rout = 0; Zin = 0;
		end
		neg5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		//not
		not3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		not4: begin
			Grc = 1; Rout = 1; ALUCode = 5'b00011; Zin = 1; //change code
			#15 Grc = 0; Rout = 0; Zin = 0;
		end
		not5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end

		// br States
		br3: begin
			Gra = 1; Rout = 1; CONin = 1;
			#15 Gra = 0; Rout = 0; CONin = 0;
		end
		br4: begin
			PCout = 1; Yin = 1;
			#15 PCout = 0; Yin = 0;
		end
		br5: begin
			Cout = 1; Zin = 1; ALUCode = 5'b00011;
			#15 Cout = 0; Zin = 0;
		end
		br6: begin
			Zlowout = CON_FF;
			PCin = CON_FF;
			#13 Zlowout = 0; PCin = 0;
		end
		
		// JAL states
		jal3: begin
			Grb = 1; Rin = 1; PCout = 1;
			#15 Grb = 0; Rin = 0; PCout = 0;
		end
		jal4: begin
			Gra = 1; Rout = 1; PCin = 1;
			#15 Gra = 0; Rout = 0; PCin = 0;
		end
		
		// JR State
		jr3: begin
			Gra = 1; Rout = 1; PCin = 1;
			#15 Gra = 0; Rout = 0; PCin = 0;
		end
		
		// IN State
		in3: begin
			InPortout = 1;
			Gra = 1; Rin = 1;
			#15 Gra = 0; Rin = 0; InPortout = 0;
		end
		
		out3: begin
			Gra = 1; Rout = 1; OutPortin = 1;
			#15 Gra = 0; Rout = 0; OutPortin = 0;
		end
		
		// MFLO State
		mflo3: begin
			Gra = 1; Rin = 1; LOout = 1;
			#15 Gra = 0; Rin = 0; LOout = 0;
		end
		
		// MFHI State
		mfhi3: begin
			Gra = 1; Rin = 1; HIout = 1;
			#15 Gra = 0; Rin = 0; HIout = 0;
		end
	endcase
end

endmodule
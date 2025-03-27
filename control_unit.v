module control_unit(
output reg	Gra, Grb, Grc, Rin, Rout, BAout, CONin,
				HIin, LOin, Zin, PCin, MDRin, MARin, Yin, OutPortin, IRin,
				HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout,
				Read, Write, Clear, Run,
output reg[4:0] ALUCode,
input[31:0] IR,
input			Clock, Reset, Stop, CON_FF

);


parameter reset_state = 6'd1, T0 = 6'd2, T1 = 6'd3, T2 = 6'd4, 
ADDIT3 = 6'd5, ADDIT4 = 6'd6, ADDIT5 = 6'd7,
ANDIT3 = 6'd8, ANDIT4 = 6'd9, ANDIT5 = 6'd10,
BRMIT3 = 6'd11, BRMIT4 = 6'd12, BRMIT5 = 6'd13,
BRNZT3 = 6'd14, BRNZT4 = 6'd15, BRNZT5 = 6'd16,
BRPLT3 = 6'd17, BRPLT4 = 6'd18, BRPLT5 = 6'd19,
BRZRT3 = 6'd20, BRZRT4 = 6'd21, BRZRT5 = 6'd22,
Branching_End = 6'd23,
INT3 = 6'd24,
JALT3 = 6'd25, JALT4 = 6'd26,
JRT3 = 6'd27,
LD1T3 = 6'd28, LD1T4 = 6'd29, LD1T5 = 6'd30, LD1T6 = 6'd31, LD1T7 = 6'd32,
LD2T3 = 6'd33, LD2T4 = 6'd34, LD2T5 = 6'd35, 
MFHIT3 = 6'd36,
MFLOT3 = 6'd37, MFLOT4 = 6'd38,
ORIT3 = 6'd39, ORIT4 = 6'd40, ORIT5 = 6'd41,
OUTT3 = 6'd42,
ST1T3 = 6'd43, ST1T4 = 6'd44, ST1T5 = 6'd45, ST1T6 = 6'd46,
ST2T3 = 6'd47, ST2T4 = 6'd48, ST2T5 = 6'd49, ST2T6 = 6'd50;

reg[6:0] present_state = 0;

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
		
		
		// ADDI States
		ADDIT3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		ADDIT4: begin
			Cout = 1; ALUCode = 5'b00011; Zin = 1;
			#15 Cout = 0; Zin = 0;
		end
		ADDIT5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		
		// ANDI States
		ANDIT3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		ANDIT4: begin
			Cout = 1; ALUCode = 5'b00101; Zin = 1;
			#15 Cout = 0; Zin = 0;
		end
		ANDIT5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		
		// BRMI States
		BRMIT3: begin
			Gra = 1; Rout = 1; CONin = 1;
			#15 Gra = 0; Rout = 0; CONin = 0;
		end
		BRMIT4: begin
			PCout = 1; Yin = 1;
			#15 PCout = 0; Yin = 0;
		end
		BRMIT5: begin
			Cout = 1; Zin = 1; ALUCode = 5'b00011;
			#15 Cout = 0; Zin = 0;
		end
		
		// BRNZ States
		BRNZT3: begin
			Gra = 1; Rout = 1; CONin = 1;
			#15 Gra = 0; Rout = 0; CONin = 0;
		end
		BRNZT4: begin
			PCout = 1; Yin = 1;
			#15 PCout = 0; Yin = 0;
		end
		BRNZT5: begin
			Cout = 1; Zin = 1; ALUCode = 5'b00011;
			#15 Cout = 0; Zin = 0;
		end
		
		// BRPL States
		BRPLT3: begin
			Gra = 1; Rout = 1; CONin = 1;
			#15 Gra = 0; Rout = 0; CONin = 0;
		end
		BRPLT4: begin
			PCout = 1; Yin = 1;
			#15 PCout = 0; Yin = 0;
		end
		BRPLT5: begin
			Cout = 1; Zin = 1; ALUCode = 5'b00011;
			#15 Cout = 0; Zin = 0;
		end
		
		// BRZR States
		BRZRT3: begin
			Gra = 1; Rout = 1; CONin = 1;
			#15 Gra = 0; Rout = 0; CONin = 0;
		end
		BRZRT4: begin
			PCout = 1; Yin = 1;
			#15 PCout = 0; Yin = 0;
		end
		BRZRT5: begin
			Cout = 1; Zin = 1; ALUCode = 5'b00011;
			#15 Cout = 0; Zin = 0;
		end
		
		// end state for all branching calls
		Branching_End: begin
			Zlowout = CON_FF;
			PCin = CON_FF;
			#13 Zlowout = 0; PCin = 0;
		end
		
		// IN State
		INT3: begin
			InPortout = 1;
			Gra = 1; Rin = 1;
			#15 Gra = 0; Rin = 0; InPortout = 0;
		end
		
		// JAL states
		JALT3: begin
			Grb = 1; Rin = 1; PCout = 1;
			#15 Grb = 0; Rin = 0; PCout = 0;
		end
		JALT4: begin
			Gra = 1; Rout = 1; PCin = 1;
			#15 Gra = 0; Rout = 0; PCin = 0;
		end
		
		// JR State
		JRT3: begin
			Gra = 1; Rout = 1; PCin = 1;
			#15 Gra = 0; Rout = 0; PCin = 0;
		end
		
		// LD1 States
		LD1T3: begin
			Grb = 1; BAout = 1; Yin = 1;
			#15 Grb = 0; BAout = 0; Yin = 0;
		end
		LD1T4: begin
			Cout = 1; ALUCode = 5'b00011; Zin = 1;
			#15 Cout = 0; Zin = 0;
		end
		LD1T5: begin
			Zlowout = 1; MARin = 1;
			#15 Zlowout = 0; MARin = 0;
		end
		LD1T6: begin
			Read = 1; MDRin = 1;
			#15 Read = 0; MDRin = 0;
		end
		LD1T7: begin
			MDRout = 1; Gra = 1; Rin = 1;
			#15 MDRout = 0; Gra = 0; Rin = 0; 
		end
		
		// LD2 States
		LD2T3: begin
			Grb = 1; BAout = 1; Yin = 1;
			#15 Grb = 0; BAout = 0; Yin = 0;
		end
		LD2T4: begin
			Cout = 1; ALUCode = 5'b00011; Zin = 1;
			#15 Cout = 0; Zin = 0;
		end
		LD2T5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		
		// MFHI State
		MFHIT3: begin
			Gra = 1; Rin = 1; HIout = 1;
			#15 Gra = 0; Rin = 0; HIout = 0;
		end
		
		// MFLO State
		MFLOT3: begin
			Gra = 1; Rin = 1; LOout = 1;
			#15 Gra = 0; Rin = 0; LOout = 0;
		end
		
		// ORI States
		ORIT3: begin
			Grb = 1; Rout = 1; Rin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		ORIT4: begin
			Cout = 1; ALUCode = 5'b00110; Zin = 1;
			#15 Cout = 0; Zin = 0;
		end
		ORIT5: begin
			Zlowout = 1; Gra = 1; Rin = 1;
			#15 Zlowout = 0; Gra = 0; Rin = 0;
		end
		
		// OUT States
		OUTT3: begin
			Gra = 1; Rout = 1; OutPortin = 1;
			#15 Gra = 0; Rout = 0; OutPortin = 0;
		end
		
		// ST1 states
		ST1T3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		ST1T4: begin
			Cout = 1; ALUCode = 5'b00011; Zin = 1;
			#15 Cout = 0; Zin = 0;
		end
		ST1T5: begin
			Zlowout = 1; MARin = 1;
			#15 Zlowout = 0; MARin = 0;
		end
		ST1T6: begin
			Write = 1; Gra = 1; Rout = 1;
			#15 Write = 0; Gra = 0; Rout = 0;
		end
		
		// ST2 States
		ST2T3: begin
			Grb = 1; Rout = 1; Yin = 1;
			#15 Grb = 0; Rout = 0; Yin = 0;
		end
		ST2T4: begin
			Cout = 1; ALUCode = 5'b00011; Zin = 1;
			#15 Cout = 0; Zin = 0;
		end
		ST2T5: begin
			Zlowout = 1; MARin = 1;
			#15 Zlowout = 0; MARin = 0;
		end
		ST2T6: begin
			Write = 1; Gra = 1; Rout = 1;
			#15 Write = 0; Gra = 0; Rout = 0;
		end
		
	endcase
end

endmodule
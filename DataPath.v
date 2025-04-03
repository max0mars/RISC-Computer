module DataPath(
	input wire clock,
	
	input wire [31:0] IPortInput,
	
	input wire initMem,
	input wire reset, stop
);

wire [15:0] regIn;//register enable signal
wire [31:0] regVal [15:0];//register output value
wire [31:0] BusVal;//bus line after mux
wire Gra, Grb, Grc, RIn, ROut, BAOut;
wire ConIn, ConOut;
wire HiIn, LoIn, ZIn, PCIn, MDRIn, MARIn, YIn, OPortIn, IRIn;
wire HiSel, LoSel, ZHiSel, ZLoSel, PCSel, MDRSel, IPortSel, CSel;
wire memread, memwrite;
wire run;

wire [4:0] ALUCode;
wire [31:0] HiVal, LoVal, ZHiVal, ZLoVal, PCVal, MDRVal, MARVal, YVal, OPortVal, IPortVal, IRVal;

control_unit CU(
	.Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(RIn), .Rout(ROut), .BAout(BAOut),
	.CONin(ConIn),
	.HIin(HiIn), .LOin(LoIn), .Zin(ZIn), .PCin(PCIn), .MDRin(MDRIn), .MARin(MARIn), .Yin(YIn), .OutPortin(OPortIn), .IRin(IRIn),
	.HIout(HiSel), .LOout(LoSel), .Zhighout(ZHiSel), .Zlowout(ZLoSel), .PCout(PCSel), .MDRout(MDRSel), .InPortout(IPortSel), .Cout(CSel),
	.Read(memread), .Write(memwrite), .Clear(clear), .Run(run),
	.ALUCode(ALUCode),
	.IR(IRVal),
	.Clock(clock), .Reset(reset), .Stop(stop), .CON_FF(ConOut)
);


//BASIC REGISTERS START
//genvar i;//generate R1 to R15
//generate
//for (i = 1; i < 16; i=i+1)
//	begin: registers
//		register r (clear, clock, regIn[i], BusVal, regVal[i]);
//	end
//endgenerate
register r1(clear, clock, regIn[1], BusVal, regVal[1]);
register r2(clear, clock, regIn[2], BusVal, regVal[2]);
register r3(clear, clock, regIn[3], BusVal, regVal[3]);
register r4(clear, clock, regIn[4], BusVal, regVal[4]);
register r5(clear, clock, regIn[5], BusVal, regVal[5]);
register r6(clear, clock, regIn[6], BusVal, regVal[6]);
register r7(clear, clock, regIn[7], BusVal, regVal[7]);
register r8(clear, clock, regIn[8], BusVal, regVal[8]);
register r9(clear, clock, regIn[9], BusVal, regVal[9]);
register r10(clear, clock, regIn[10], BusVal, regVal[10]);
register r11(clear, clock, regIn[11], BusVal, regVal[11]);
register r12(clear, clock, regIn[12], BusVal, regVal[12]);
register r13(clear, clock, regIn[13], BusVal, regVal[13]);
register r14(clear, clock, regIn[14], BusVal, regVal[14]);
register r15(clear, clock, regIn[15], BusVal, regVal[15]);

 // added MARval, OPortVal, IPortVal for phase 2

register hi (clear, clock, HiIn, BusVal, HiVal);
register lo (clear, clock, LoIn, BusVal, LoVal);
register pc (clear, clock, PCIn, BusVal, PCVal);
register Y (clear, clock, YIn, BusVal, YVal);
register MAR (clear, clock, MARIn, BusVal, MARVal); // added for phase 2
register OutPort (clear, clock, OPortIn, BusVal, OPortVal);// added for phase 2
register IR (clear, clock, IRIn, BusVal, IRVal);// added for phase 2
//BASIC REGISTERS END


wire [31:0] MdataOut;// added for phase 2
wire [63:0] ALUresult;
//SPECIAL REGISTERS START
r0_Register R0 (clear, clock, regIn[0], BusVal, BAOut, regVal[0]);
//
Zregister zr (clear, clock, ZIn, ALUresult, ZHiVal, ZLoVal);
Inport_Reg InPort(clear, IPortInput, IPortVal); // added for phase 2
//SPECIAL REGISTERS END


wire [15:0] regSel;
Bus bus(
	regVal[0], regVal[1], regVal[2], regVal[3], regVal[4], regVal[5], regVal[6], regVal[7], regVal[8], regVal[9], regVal[10], regVal[11], regVal[12], //val is the 32 value fed into the bus mux
	regVal[13], regVal[14], regVal[15], HiVal, LoVal, ZHiVal, ZLoVal, PCVal, MDRVal, IPortVal, //added IPortVal for Phase 2
	
	{{13{IRVal[18]}}, IRVal[18:0]},
	
	regSel, HiSel, LoSel, ZHiSel, ZLoSel, PCSel, MDRSel, IPortSel, CSel,//added IPortSel for phase 2
	
	BusVal // value output to the bus
);

ALU alu (YVal, BusVal, ALUCode, ALUresult);

select_and_encode SelEnc(Gra, Grb, Grc, IRVal, RIn, ROut, BAOut, regIn, regSel);



CON_FF conff(ConIn, BusVal, IRVal[20:19], ConOut);



RAM ram (memread, memwrite, MARVal[8:0], BusVal, MdataOut, initMem); // added for phase 2


MDR mdr(clear, clock, MDRIn, BusVal, MdataOut, memread, MDRVal);





endmodule

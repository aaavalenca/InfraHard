module cpu(input clock,
	input reset,
	output [6:0] state,
	output [5:0] w_opcode,
	output [15:0] w_rd
);

//logic [15:0] w_rd;
logic [1:0] aluSrcA;
logic [1:0] iorD;
logic [2:0] aluCtrl;
logic [2:0] aluSrcB;
logic [2:0] memToReg;
logic [2:0] pcSrc;
logic [2:0] regDist;
logic [31:0] w_AIn;
logic [31:0] w_AOut;
logic [31:0] w_BIn;
logic [31:0] w_BOut;
logic [31:0] w_Out;
logic [31:0] w_aluOut;
logic [31:0] w_aluResult;
logic [31:0] w_excpCtrl;
logic [31:0] w_lsOut;
logic [31:0] w_mdrOut;
logic [31:0] w_memAddressIn;
logic [31:0] w_memDataIn;
logic [31:0] w_memDataOut;
logic [31:0] w_multS;
logic [31:0] w_pcIn;
logic [31:0] w_pcOut;
logic [31:0] w_shiftLeft16Out;
logic [31:0] w_shiftLeft2Out;
logic [31:0] w_shiftLeft2628Out;
logic [31:0] w_shiftRegOut;
logic [31:0] w_signExtend132Out;
logic [31:0] w_signExtend1632Out;
logic [31:0] w_writeDataIn;
logic [31:0] w_divHighOut;
logic [31:0] w_divLowOut;
logic [31:0] w_multHighOut;
logic [31:0] w_multLowOut;
logic [31:0] w_highIn;
logic [31:0] w_lowIn;
logic [31:0] w_highOut;
logic [31:0] w_lowOut;
logic [25:0] w_inst25_0rs;
logic [4:0] w_inst15_11rd;
logic [4:0] w_rs;
logic [4:0] w_rt;
logic [4:0] w_writeRegIn;
//logic [5:0] w_opcode;
logic aluOutCtrl;
logic irWrite;
logic memCtrl;
logic negativo;
logic overflow;
logic pcWrite;
logic regWrite;
logic w_eq;
logic w_gt;
logic w_lt;
logic w_regA;
logic w_regB;
logic w_z;
logic divMult;
logic regHighW;
logic regLowW;
logic multS;

Control controle(
	.Clock(clock),
	.GT(w_gt),
	.EQ(w_eq),
	.LT(w_lt),
	.OPCode(w_opcode),
	.Funct(w_rd[5:0]),
	.Estado(state),

	// sinais dos muxes
	.flagIorD(iorD),
	.flagRegDist(regDist),
	.flagMemReg(memToReg),
	.flagALUSrcA(aluSrcA),
	.flagALUSrcB(aluSrcB),
	.flagPCSrc(pcSrc),
	.flagMultS(multS),
	.flagDivMult(divMult),

	// sinais de registradores
	.flagPcWrite(pcWrite),
	.flagRegA(w_regA),
	.flagRegB(w_regB),
	.flagALUOut(aluOutCtrl),

	// sinais dos componentes	
	.flagALUCtrl(aluCtrl),
	.flagRegWrite(regWrite),
	.flagIrWrite(irWrite),
	.flagMemCtrl(memCtrl)
);

Registrador pc(
	.Clk(clock),
	.Reset(reset),
	.Load(pcWrite),
	.Entrada(w_pcIn),
	.Saida(w_pcOut)
);

MUX1 muxIorD(
	.flagIorD(iorD),
	.w_muxIn0(w_pcOut),
	.w_muxIn1(w_aluOut),
	.w_muxIn2(w_regAOut),
	.w_muxIn3(w_excpCtrl),
	.w_muxOut(w_memAddressIn)
);

Memoria memory(
	.Address(w_memAddressIn),
	.Clock(clock),
	.Wr(memCtrl),
	.Datain(w_memDataIn),
	.Dataout(w_memDataOut)
);

Instr_Reg instructionRegister(
	.Clk(clock),			
	.Reset(reset),		
	.Load_ir(irWrite),		
	.Entrada(w_memDataOut),
	.Instr31_26(w_opcode),
	.Instr25_21(w_rs),
	.Instr20_16(w_rt),
	.Instr15_0(w_rd)
);

Banco_reg registers(
	.Clk(clock),
	.Reset(reset),
	.RegWrite(regWrite),
	.ReadReg1(w_rs),
	.ReadReg2(w_rt),
	.WriteReg(w_writeRegIn),
	.WriteData(w_writeDataIn),
	.ReadData1(w_AIn),
	.ReadData2(w_BIn)
);

Registrador regA(
	.Clk(clock),
	.Reset(reset),
	.Load(w_regA),
	.Entrada(w_AIn),
	.Saida(w_AOut)
);

Registrador regB(
	.Clk(clock),
	.Reset(reset),
	.Load(w_regB),
	.Entrada(w_BIn),
	.Saida(w_BOut)
);

Ula32 ALU(
	.A(w_ulaAIn),
	.B(w_ulaBIn),
	.Seletor(aluCtrl),
	.S(w_aluResult),
	.Overflow(overflow),
	.Negativo(negativo),
	.z(w_z),
	.Igual(w_eq),
	.Maior(w_gt),
	.Menor(w_lt)
);

Registrador aluOut(
	.Clk(clock),
	.Reset(reset),
	.Load(aluOutCtrl),
	.Entrada(w_aluResult),
	.Saida(w_aluOut)
);

MUX4 muxRegDist(
	.flagRegDist(regDist),
	.w_muxIn0(w_rt),
	.w_muxIn1(w_rd[15:11]), //nao sabia q podia passar assim, ai criei o assign, mas nao vou mudar
	.w_muxIn3(w_rs),
	.w_muxOut(w_writeRegIn)
);

MUX5 muxMemToReg(
	.flagMemToReg(memToReg),
	.w_muxIn0(w_aluOut),
	.w_muxIn1(w_lsOut),
	.w_muxIn2(w_multS),
	.w_muxIn3(w_signExtend132eOut),
	.w_muxIn4(w_BOut),
	.w_muxIn5(w_shiftRegOut),
	.w_muxIn6(w_shiftLeft16Out),
	.w_muxOut(w_writeDataIn)
);

MUX6 muxAluSrcA(
	.flagAluSrcA(aluSrcA),
	.w_muxIn0(w_pcOut),
	.w_muxIn1(w_AOut),
	.w_muxIn2(w_mdrOut),
	.w_muxOut(w_ulaAIn)
);

MUX7 muxAluSrcB(
	.flagAluSrcB(aluSrcB),
	.w_muxIn0(w_BOut),
	.w_muxIn2(w_signExtend1632Out),
	.w_muxIn3(w_shiftLeft2Out),
	.w_muxOut(w_ulaBIn)
);

MUX8 muxDivMultHigh(
	.flagDivMult(divMult),
	.w_muxIn0(w_divHighOut),
	.w_muxIn1(w_multHighOut),
	.w_muxOut(w_highIn)
);

MUX9 muxDivMultLow(
	.flagDivMult(divMult),
	.w_muxIn0(w_divLowOut),
	.w_muxIn1(w_multLowOut),
	.w_muxOut(w_lowIn)
);

MUX10 muxPCSrc(
	.flagPCSrc(pcSrc),
	.w_muxIn0(w_aluResult),
	.w_muxIn1(w_aluOut),
	.w_muxIn2(w_shiftleft2pc),
	.w_muxIn3(w_signExtend132dOut),
	.w_muxIn4(w_epcOut),
	.w_muxOut(w_pcIn)
);

Registrador high(
	.Clk(clock),
	.Reset(reset),
	.Load(regHighW),
	.Entrada(w_highIn),
	.Saida(w_highOut)
);

Registrador low(
	.Clk(clock),
	.Reset(reset),
	.Load(regLowW),
	.Entrada(w_lowIn),
	.Saida(w_lowOut)
);

MUX11 muxMultS(
	.flagMultS(multS),
	.w_muxIn0(w_highOut),
	.w_muxIn1(w_lowOut),
	.w_muxOut(w_multS)
);


SignExtend16_32 signEx1632( //Sign Extend que pega o rd. Precisamos de um Sign Extend de 1 pra 32 tamb�m
	.instructionIn15_0(w_rd),
	.instructionOut31_0(w_signExtend1632Out)
);

ShiftLeft2 sL2( //Shift Left que pega o resultado do Sign Extend 16_32
	.instructionIn31_0(w_signExtend1632Out),
	.instructionOut31_0(w_ShiftLeft2OUt)
);

ShiftLeft26_28 sL2628 ( //Shift Left que pega rs 25_0 e transforma em 27_0
	.instructionIn25_0(w_inst25_0rs),
	.instructionOut27_0(w_shiftLeft2628Out)
);

assign w_inst25_0rs [25:21] = w_rs; //O rs tem 4 bits, ele passa pelo ShiftLeft 26_28 com 25 bits, ent�o criamos o w_inst25_0rs e colocamos o rs de 4 bits nos bits 25:21, pra que ele possa passar no ShiftLeft
assign w_inst15_11rd = w_rd[15:11]; //O rd tem 16 bits, mas s� os bits 15:11 entram no MUX, ent�o criamos o w_inst15_11rd pra passar pelo MUX

endmodule: cpu
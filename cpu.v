module CPU(input clock,
	input reset
);

logic pcWrite;
logic [1:0] iorD;
logic [31:0] w_pcIn;
logic [31:0] w_pcOut;
logic [31:0] w_aluOut;
logic [31:0] w_regAOut;
logic [31:0] w_excpCtrl;
logic [31:0] w_memAddressIn;
logic memCtrl;
logic [31:0] w_memDataIn;
logic [31:0] w_memDataOut
logic irWrite;
logic [31:0] w_memDataOut;
logic [5:0] w_opcode
logic [4:0] w_rs
logic [4:0] w_rt
logic [15:0] w_rd
logic regWrite;
logic [4:0] w_writeRegIn;
logic [31:0] w_writeDataIn;
logic [31:0] w_AIn;
logic [31:0] w_BIn;
logic regA;
logic [31:0] w_AOut;
logic regB;
logic [31:0] w_BOut;
logic [2:0] aluCtrl;
logic [31:0] w_aluResult;
logic overflow;
logic negativo;
logic w_z;
logic w_eq;
logic w_gt;
logic w_lt;

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
	.Load(regA),
	.Entrada(w_AIn),
	.Saida(w_AOut)
);

Registrador regB(
	.Clk(clock),
	.Reset(reset),
	.Load(regB),
	.Entrada(w_BIn),
	.Saida(w_BOut)
);

Ula32 ALU(
	.A(w_AOut),
	.B(w_BOut),
	.Seletor(aluCtrl),
	.S(w_aluResult),
	.Overflow(overflow),
	.Negativo(negativo),
	.z(w_z),
	.Igual(w_eq),
	.Maior(w_gt),
	.Menor(w_lt)
);

endmodule: CPU
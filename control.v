module Control(Estado, Clock, GT, EQ, LT, OPCode, Funct, flagPcWrite, flagIorD, flagMemCtrl, flagIrWrite, flagRegWrite, flagRegDist, flagRegA, flagRegB, flagALUSrcA, flagALUSrcB, flagALUCtrl, flagPCSrc, flagEPC, flagALUOut, flagSSCtrl, flagLSCtrl, flagMDR, flagMemReg, flagDivStart, flagMultStart, flagDivMult, flagRegHighW, flagRegLowW, flagMultS, flagShiftSrc, flagShiftAmt, flagShiftCtrl, flagExcpCtrl, Reset);

	output reg[6:0] Estado;
	input Clock, GT, EQ, LT;
	input[5:0] OPCode, Funct;

	output reg      flagPcWrite, flagMemCtrl, flagIrWrite, flagRegWrite, flagRegA, flagRegB, flagEPC, flagALUOut, flagMDR, flagDivStart, flagMultStart, flagDivMult, flagRegHighW, flagRegLowW, flagMultS, Reset;
	output reg[1:0] flagIorD, flagALUSrcA, flagSSCtrl, flagLSCtrl, flagShiftSrc, flagShiftAmt, flagExcpCtrl;
	output reg[2:0] flagRegDist, flagALUSrcB, flagALUCtrl, flagMemReg, flagShiftCtrl, flagPCSrc;
	
	initial Estado <= 7'b0000000;

	//Estados

	//~~~Estados Inicias~~~
	parameter Resetar = 7'b0000000, Fetch = 7'b0000001, Wait = 7'b0000010, Decode = 7'b0000011, Wait2 = 7'b1111111;

	//~~~Estados das Funcoes~~~
	parameter Add = 7'b0000100, Sub = 7'b0000101, And = 7'b0000110, R_write = 7'b0000111;
	
	reg [6:0] state;
	
	//Maquina de Estados
	always @ (posedge Clock) begin
		Estado = state;
	end
	
	always @(*) begin

		case(Estado)

			Resetar: begin
				flagALUOut <= 0;
				flagALUCtrl <= 000;
				flagALUSrcA <= 00;
				flagALUSrcB <= 000;
				flagDivMult <= 0;
				flagDivStart <= 0;
				flagEPC <= 0;
				flagExcpCtrl <= 00;
				flagIorD <= 00;
				flagIrWrite <= 0;
				flagLSCtrl <= 00;
				flagMDR <= 0;
				flagMemCtrl <= 0;
				flagMemReg <= 111;
				flagMultS <= 0;
				flagMultStart <= 0;
				flagPCSrc <= 00;
				flagPcWrite <= 0;
				flagRegA <= 0;
				flagRegB <= 0;
				flagRegDist <= 100;
				flagRegHighW <= 0;
				flagRegLowW <= 0;
				flagRegWrite <= 1;
				flagShiftAmt <= 00;
				flagShiftCtrl <= 000;
				flagShiftSrc <= 00;
				flagSSCtrl <= 00;
				Reset <= 1;
				//Estado <= Fetch;
				state <= Fetch;
			end

			Fetch: begin
				flagALUOut <= 0;
				flagALUCtrl <= 3'b001;
				flagALUSrcA <= 00;
				flagALUSrcB <= 001;
				flagDivMult <= 0;
				flagDivStart <= 0;
				flagEPC <= 0;
				flagExcpCtrl <= 00;
				flagIorD <= 00;
				flagIrWrite <= 0;
				flagLSCtrl <= 00;
				flagMDR <= 0;
				flagMemCtrl <= 0;
				flagMemReg <= 000;
				flagMultS <= 0;
				flagMultStart <= 0;
				flagPCSrc <= 00;
				flagPcWrite <= 1;
				flagRegA <= 0;
				flagRegB <= 0;
				flagRegDist <= 000;
				flagRegHighW <= 0;
				flagRegLowW <= 0;
				flagRegWrite <= 0;
				flagShiftAmt <= 00;
				flagShiftCtrl <= 000;
				flagShiftSrc <= 00;
				flagSSCtrl <= 00;
				Reset <= 0;
				//Estado <= Wait;
				state <= Wait;
			end
			
			Wait: begin
				flagALUOut <= 1;
				flagALUCtrl <= 001;
				flagALUSrcA <= 00;
				flagALUSrcB <= 001;
				flagDivMult <= 0;
				flagDivStart <= 0;
				flagEPC <= 0;
				flagExcpCtrl <= 00;
				flagIorD <= 00;
				flagIrWrite <= 0;
				flagLSCtrl <= 00;
				flagMDR <= 0;
				flagMemCtrl <= 0;
				flagMemReg <= 000;
				flagMultS <= 0;
				flagMultStart <= 0;
				flagPCSrc <= 00;
				flagPcWrite <= 0;
				flagRegA <= 0;
				flagRegB <= 0;
				flagRegDist <= 000;
				flagRegHighW <= 0;
				flagRegLowW <= 0;
				flagRegWrite <= 0;
				flagShiftAmt <= 00;
				flagShiftCtrl <= 000;
				flagShiftSrc <= 00;
				flagSSCtrl <= 00;
				Reset <= 0;
				//Estado <= Decode;
				state <= Wait2;
			end

			Wait2: begin
				flagALUOut <= 1;
				flagALUCtrl <= 001;
				flagALUSrcA <= 00;
				flagALUSrcB <= 001;
				flagDivMult <= 0;
				flagDivStart <= 0;
				flagEPC <= 0;
				flagExcpCtrl <= 00;
				flagIorD <= 00;
				flagIrWrite <= 0;
				flagLSCtrl <= 00;
				flagMDR <= 0;
				flagMemCtrl <= 0;
				flagMemReg <= 000;
				flagMultS <= 0;
				flagMultStart <= 0;
				flagPCSrc <= 00;
				flagPcWrite <= 0;
				flagRegA <= 0;
				flagRegB <= 0;
				flagRegDist <= 000;
				flagRegHighW <= 0;
				flagRegLowW <= 0;
				flagRegWrite <= 0;
				flagShiftAmt <= 00;
				flagShiftCtrl <= 000;
				flagShiftSrc <= 00;
				flagSSCtrl <= 00;
				Reset <= 0;
				//Estado <= Decode;
				state <= Decode;
			end


			Decode: begin
				flagALUOut <= 1;
				flagALUCtrl <= 001;
				flagALUSrcA <= 00;
				flagALUSrcB <= 011;
				flagDivMult <= 0;
				flagDivStart <= 0;
				flagEPC <= 0;
				flagExcpCtrl <= 00;
				flagIorD <= 00;
				flagIrWrite <= 0;
				flagLSCtrl <= 00;
				flagMDR <= 0;
				flagMemCtrl <= 0;
				flagMemReg <= 000;
				flagMultS <= 0;
				flagMultStart <= 0;
				flagPCSrc <= 00;
				flagPcWrite <= 0;
				flagRegA <= 0;
				flagRegB <= 0;
				flagRegDist <= 000;
				flagRegHighW <= 0;
				flagRegLowW <= 0;
				flagRegWrite <= 0;
				flagShiftAmt <= 00;
				flagShiftCtrl <= 000;
				flagShiftSrc <= 00;
				flagSSCtrl <= 00;
				Reset <= 0;

				//Indentificar a Instrucao
				
				case (OPCode)

					6'b000000: 
					begin //OPCode: 0x0 -> Tipo R

						case (Funct)
							
							//6'b100000: Estado <= Add; //Funct: 0x20 -> Add
							6'b100000: state <= Add;

						endcase

					end

				endcase
				
			end

			//~~~Tipo R~~~

			Add: begin
				flagALUOut <= 1;
				flagALUCtrl <= 001;
				flagALUSrcA <= 01;
				flagALUSrcB <= 000;
				flagDivMult <= 0;
				flagDivStart <= 0;
				flagEPC <= 0;
				flagExcpCtrl <= 00;
				flagIorD <= 00;
				flagIrWrite <= 0;
				flagLSCtrl <= 00;
				flagMDR <= 0;
				flagMemCtrl <= 0;
				flagMemReg <= 000;
				flagMultS <= 0;
				flagMultStart <= 0;
				flagPCSrc <= 00;
				flagPcWrite <= 0;
				flagRegA <= 0;
				flagRegB <= 0;
				flagRegDist <= 000;
				flagRegHighW <= 0;
				flagRegLowW <= 0;
				flagRegWrite <= 0;
				flagShiftAmt <= 00;
				flagShiftCtrl <= 000;
				flagShiftSrc <= 00;
				flagSSCtrl <= 00;
				Reset <= 0;
				//Estado <= R_write;				
				state <= R_write;
			end

			Sub: begin
				flagALUOut <= 1;
				flagALUCtrl <= 010;
				flagALUSrcA <= 01;
				flagALUSrcB <= 000;
				flagDivMult <= 0;
				flagDivStart <= 0;
				flagEPC <= 0;
				flagExcpCtrl <= 00;
				flagIorD <= 00;
				flagIrWrite <= 0;
				flagLSCtrl <= 00;
				flagMDR <= 0;
				flagMemCtrl <= 0;
				flagMemReg <= 000;
				flagMultS <= 0;
				flagMultStart <= 0;
				flagPCSrc <= 00;
				flagPcWrite <= 0;
				flagRegA <= 0;
				flagRegB <= 0;
				flagRegDist <= 000;
				flagRegHighW <= 0;
				flagRegLowW <= 0;
				flagRegWrite <= 0;
				flagShiftAmt <= 00;
				flagShiftCtrl <= 000;
				flagShiftSrc <= 00;
				flagSSCtrl <= 00;
				Reset <= 0;
				//Estado <= R_write;
				state <= R_write;
			end

			And: begin
				flagALUOut <= 1;
				flagALUCtrl <= 011;
				flagALUSrcA <= 01;
				flagALUSrcB <= 000;
				flagDivMult <= 0;
				flagDivStart <= 0;
				flagEPC <= 0;
				flagExcpCtrl <= 00;
				flagIorD <= 00;
				flagIrWrite <= 0;
				flagLSCtrl <= 00;
				flagMDR <= 0;
				flagMemCtrl <= 0;
				flagMemReg <= 000;
				flagMultS <= 0;
				flagMultStart <= 0;
				flagPCSrc <= 00;
				flagPcWrite <= 0;
				flagRegA <= 0;
				flagRegB <= 0;
				flagRegDist <= 000;
				flagRegHighW <= 0;
				flagRegLowW <= 0;
				flagRegWrite <= 0;
				flagShiftAmt <= 00;
				flagShiftCtrl <= 000;
				flagShiftSrc <= 00;
				flagSSCtrl <= 00;
				Reset <= 0;
				//Estado <= R_write;
				state <= R_write;
			end

			R_write: begin
				flagALUOut <= 0;
				flagALUCtrl <= 000;
				flagALUSrcA <= 00;
				flagALUSrcB <= 000;
				flagDivMult <= 0;
				flagDivStart <= 0;
				flagEPC <= 0;
				flagExcpCtrl <= 00;
				flagIorD <= 00;
				flagIrWrite <= 0;
				flagLSCtrl <= 00;
				flagMDR <= 0;
				flagMemCtrl <= 0;
				flagMemReg <= 000;
				flagMultS <= 0;
				flagMultStart <= 0;
				flagPCSrc <= 00;
				flagPcWrite <= 0;
				flagRegA <= 0;
				flagRegB <= 0;
				flagRegDist <= 001;
				flagRegHighW <= 0;
				flagRegLowW <= 0;
				flagRegWrite <= 1;
				flagShiftAmt <= 00;
				flagShiftCtrl <= 000;
				flagShiftSrc <= 00;
				flagSSCtrl <= 00;
				Reset <= 0;
				//Estado <= Fetch;
				state <= Fetch;
			end

		endcase
	end

endmodule


/*
				flagALUOut <= 0;
				flagALUCtrl <= 000;
				flagALUSrcA <= 00;
				flagALUSrcB <= 000;
				flagDivMult <= 0;
				flagDivStart <= 0;
				flagEPC <= 0;
				flagExcpCtrl <= 00;
				flagIorD <= 00;
				flagIrWrite <= 0;
				flagLSCtrl <= 00;
				flagMDR <= 0;
				flagMemCtrl <= 0;
				flagMemReg <= 000;
				flagMultS <= 0;
				flagMultStart <= 0;
				flagPCSrc <= 00;
				flagPcWrite <= 0;
				flagRegA <= 0;
				flagRegB <= 0;
				flagRegDist <= 000;
				flagRegHighW <= 0;
				flagRegLowW <= 0;
				flagRegWrite <= 0;
				flagShiftAmt <= 00;
				flagShiftCtrl <= 000;
				flagShiftSrc <= 00;
				flagSSCtrl <= 00;
				Reset <= 0;
				Estado <= Fetch;
*/
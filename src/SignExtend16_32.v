module SignExtend16_32(instructionIn15_0, instructionOut31_0);

    input [15:0] instructionIn15_0;
	output reg [31:0] instructionOut31_0;

always@(*)

	begin
		instructionOut31_0[31:0] = (instructionIn15_0[15] == 0) ? (32'b00000000000000000000000000000000 + instructionIn15_0) : (32'b11111111111111110000000000000000 + instructionIn15_0);
	end

endmodule
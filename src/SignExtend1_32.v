module SignExtend1_32(instructionIn, instructionOut31_0);

    input instructionIn;
	output reg [31:0] instructionOut31_0;

always@(*)

	begin
		instructionOut31_0[31:0] = 32'b00000000000000000000000000000000 + instructionIn;
	end

endmodule
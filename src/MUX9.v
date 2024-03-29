module MUX9 (flagDivMult, w_muxIn0, w_muxIn1, w_muxOut);

	input flagDivMult;
	input [31:0] w_muxIn0, w_muxIn1;
	output reg[31:0] w_muxOut;

always @(*)

begin
	case (flagDivMult)
        1'b0: begin
			w_muxOut[31:0] = w_muxIn0[31:0];
		end
		1'b1: begin
			w_muxOut[31:0] = w_muxIn1[31:0];
		end
	endcase
end

endmodule
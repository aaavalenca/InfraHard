module MUX10 (flagPCSrc, w_muxIn0, w_muxIn1, w_muxIn2, w_muxIn3, w_muxIn4, w_muxOut);

	input [2:0] flagPCSrc;
	input [31:0] w_muxIn0, w_muxIn1, w_muxIn2, w_muxIn3, w_muxIn4;
	output reg[31:0] w_muxOut;

always @(*)

begin
	case (flagPCSrc)
        3'b000: begin
			w_muxOut[31:0] = w_muxIn0[31:0];
		end
		3'b001: begin
			w_muxOut[31:0] = w_muxIn1[31:0];
		end
		3'b010: begin
			w_muxOut[31:0] = w_muxIn2[31:0];
		end
		3'b011: begin
			w_muxOut[31:0] = w_muxIn3[31:0];
		end
		3'b100: begin
			w_muxOut[31:0] = w_muxIn4[31:0];
		end
	endcase
end

endmodule
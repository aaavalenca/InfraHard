module MUX4 (flagRegDist, w_muxIn0, w_muxIn1, w_muxIn3, w_muxOut);

	input [2:0] flagRegDist;
	input [4:0] w_muxIn0, w_muxIn1, w_muxIn3;
	output reg[4:0] w_muxOut;

always @(*)

begin
	case (flagRegDist)
        3'b000: begin
			w_muxOut[4:0] = w_muxIn0[4:0];
		end
		3'b001: begin
			w_muxOut[4:0] = w_muxIn1[4:0];
		end
		3'b010: begin
			w_muxOut[4:0] = 31;
		end
		3'b011: begin
			w_muxOut[4:0] = w_muxIn3[4:0];
		end
		3'b100: begin
			w_muxOut[4:0] = 29;
		end
	endcase
end

endmodule
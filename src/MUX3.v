module MUX3 (flagShiftAmt, w_muxIn0, w_muxIn1, w_muxOut);

	input [1:0] flagShiftAmt;
	input [31:0] w_muxIn0, w_muxIn1;
	output reg[31:0] w_muxOut;

always @(*)

begin
	case (flagShiftAmt)
		2'b00: begin
			w_muxOut[31:0] = w_muxIn0[31:0];
		end
		2'b01: begin
			w_muxOut[31:0] = w_muxIn1[31:0];
		end
		2'b10: begin
			w_muxOut[31:0] = 16;
        end
	endcase
end

endmodule
module ShiftLeft16(instructionIn15_0, instructionOut31_0);

input [15:0] instructionIn15_0;
output reg[31:0] instructionOut31_0;


always @(*)
begin
    instructionOut31_0[31:0] <= instructionIn15_0[15:0] << 16'b0000000000000000;
end

endmodule
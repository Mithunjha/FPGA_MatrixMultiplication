module alu
( 
	input clk,
	input [15:0] aluIn1, // aluIn1 => AC
	input [15:0] aluIn2,
	input [2:0] aluOp,
	output reg [15:0] aluOut,
	output reg z
);

always @(aluOp)//posedge clk)//aluOp)
begin
	case(aluOp)
		3'd1: aluOut <= aluIn1 + aluIn2; // AC + R
		3'd2: aluOut <= aluIn1 - aluIn2; // AC - R
		3'd3:	aluOut <= aluIn1 * aluIn2; // AC x R
		3'd4: 
		begin
		aluOut = aluIn1 - 16'b1;            // AC - 1
		if (aluOut==0)
			z <= 1'b1;
		else
			z <= 1'b0;
		end
		3'd5:	
		begin
		aluOut <= 16'b0;           // Case 0 -> 0
		z <= 1'b1;
		end
		3'd6:	aluOut <= aluIn1 ^ aluIn2; // AC ^ 1
	endcase

end

endmodule
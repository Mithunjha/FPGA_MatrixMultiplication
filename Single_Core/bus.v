module bus
( 
	input clk,
	input [3:0] read_en, 	//read enable
	input [7:0] ir,
	input [7:0] tr,
	input [7:0] dr,
	input [15:0] ra,
	input [15:0] rb,
	input [15:0] ro,
	input [7:0] rn,
	input [7:0] rp,
	input [7:0] rc,
	input [7:0] rr,
	input [15:0] rt,
	input [15:0] ac,
	input [7:0] dram,
	output reg [15:0] busIn
	
	) ;
	
always @(read_en or ir or tr or dr or ra or rb or ro or rn or rp or rc or rr or rt or ac or dram)

begin
case(read_en)
	4'd1: busIn <= ir;
	4'd2: busIn <= tr;
	4'd3: busIn <= dr;
	4'd4: busIn <= ra;
	4'd5: busIn <= rb;
	4'd6: busIn <= ro;
	4'd7: busIn <= rn;
	4'd8: busIn <= rp;
	4'd9: busIn <= rc;
	4'd10: busIn <= rr;
	4'd11: busIn <= rt;
	4'd12: busIn <= ac;
	4'd13: busIn <= dram;
	4'd14: busIn <= {ir,tr};
	4'd15: busIn <= ac[15:8];
	
	//default: busIn <=16'd0;
endcase
end
endmodule
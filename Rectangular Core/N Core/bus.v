module bus
( 
	input clk,
	input [4:0] read_en, 	//read enable
	input [7:0] ir,
	input [7:0] tr,
	input [7:0] dr,
	input [15:0] ra,
	input [15:0] rb,
	input [15:0] ro,
	input [7:0] rcol1,
	input [7:0] rcol2,
	input [7:0] rn,
	input [7:0] rp,
	input [7:0] rc,
	input [7:0] rr,
	input [15:0] rt,
	input [15:0] ac,
	input [7:0] dram,
	output reg [15:0] busIn
	
	) ;
	
always @(read_en or ir or tr or dr or ra or rb or ro or rn or rp or rc or rr or rt or ac or dram or rcol1 or rcol2)

begin
case(read_en)
	5'd1: busIn <= ir;
	5'd2: busIn <= tr;
	5'd3: busIn <= dr;
	5'd4: busIn <= ra;
	5'd5: busIn <= rb;
	5'd6: busIn <= ro;
	5'd7: busIn <= rn;
	5'd8: busIn <= rp;
	5'd9: busIn <= rc;
	5'd10: busIn <= rr;
	5'd11: busIn <= rt;
	5'd12: busIn <= ac;
	5'd13: busIn <= dram;
	5'd14: busIn <= {ir,tr};
	5'd15: busIn <= ac[15:8];
	5'd16: busIn <= rcol1;
	5'd17: busIn <= rcol2;
	
	//default: busIn <=16'd0;
endcase
end
endmodule
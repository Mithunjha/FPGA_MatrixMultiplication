module acc
(
	input [15:0] dataIn,
	input [15:0] aluIn,
	input write_en,
	input inc_en,
	input rst,
	input clk,
	input alu_en,
	output reg [15:0] dataOut
	
);

always @(posedge clk or negedge rst)
begin
	if(~rst)
	begin
		dataOut <= 16'd0;
	end
	
	else if(write_en && ~alu_en)
	begin
	dataOut = dataIn;
	if(inc_en)
		dataOut = dataOut + 16'd1;
	end
	
	else if(alu_en && ~write_en)
	begin
	dataOut = aluIn;
	if(inc_en)
		dataOut = dataOut + 16'd1;
	end
	
	else if(inc_en && ~write_en && ~alu_en)
	begin
	dataOut <= dataOut + 16'd1;
	end
	
end


endmodule
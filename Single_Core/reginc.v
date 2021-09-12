module reginc
#(parameter width = 16) //default size
(
	input [width-1:0] dataIn,
	input write_en,
	input inc_en,
	input rst,
	input clk,
	output reg [width-1:0] dataOut
	
);


always @(posedge clk or negedge rst)
begin
	if(~rst)
	begin
		dataOut <= 0;
	end
	
	else
	begin
	if(write_en)
		dataOut = dataIn;
	if(inc_en)
		dataOut = dataOut + 1;
	end
end


endmodule
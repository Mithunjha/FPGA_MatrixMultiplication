module register
#(parameter width = 16) //default size
(
	input [width-1:0] dataIn,
	input write_en,
	input rst,
	input clk,
	output reg [width-1:0] dataOut
);


always @(posedge clk or negedge rst)
begin
	if(~rst)
		dataOut <= 0;
	else if (write_en)
		dataOut <= dataIn;
end


endmodule
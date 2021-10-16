module registerinc
#(parameter width = 16)  // parameterized module, default size is 16, can be used to create registers with different sizes
	
(
	input [width-1:0] dataIn,
	input wrEn, rst, clk, incEn,
	output [width-1:0] dataOut

);

//writing to the register part
 
reg [width-1:0] value;

always @(posedge clk or negedge rst) 
begin
	if (~rst)
		value <= 0;
	else if (wrEn)
		value <= dataIn;
	else if (incEn)
		value <= value + 1 ;
end



assign dataOut = value;

endmodule
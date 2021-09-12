`timescale 1ns/1ps

module instr_memory_tb();


localparam CLK_PERIOD = 20;


reg	  clk;
reg read_en;
reg [7:0] addr;
wire [7:0]  instr_out;


/////Create Clock//////

initial begin
	clk = 1'b0;
	forever begin
		#(CLK_PERIOD/2); // after half clock change 1-->0 or 0--1
		clk = ~clk;
	end
end


////instantiate the module in test bench ///////////////
instr_memory IRAM(.clk(clk), .read_IRAM(read_en), .addr(addr), .instr_out(instr_out));

initial begin

	@(posedge clk)
	addr <= 8'd0;
	read_en <= 1'd0;
	
	@(posedge clk)
	addr <= 8'd0;
	read_en <= 1'd1;
	
	@(posedge clk)
	addr <= 8'd1;
	read_en <= 1'd0;
	
	@(posedge clk)
	addr <= 8'd1;
	read_en <= 1'd1;
	
	
	repeat(78) @(posedge clk)    //// randomize inputs
	begin
		addr <= addr + 8'd1;
		read_en <= 1'd1;
		$display("%8b ", instr_out );
	end
	
	$stop;
end

endmodule

module single_core_processor

( 
	input clk,
	input status,
	input rst,
	output end_process
	
);

wire [7:0] dram_out;
wire [7:0] iram_out;
wire [15:0] bus_out;
wire [7:0] pc_out;
wire [15:0] ar_out;
wire dram_wrEn;
wire read_IRAM;



core core1(.clk(clk), .dram_out(dram_out), .iram_out(iram_out), .status(status), .rst(rst),
.dram_wrEn(dram_wrEn), .read_IRAM(read_IRAM), .pc_out(pc_out),
.ar_out(ar_out), .bus_out(bus_out), .end_process(end_process)); 

instr_memory IRAM(.clk(clk), .read_IRAM(read_IRAM), .addr(pc_out), .instr_out(iram_out));
DRAM DRAM(.clock(clk), .address(ar_out), .data(bus_out), .wren(dram_wrEn),.q(dram_out));

endmodule
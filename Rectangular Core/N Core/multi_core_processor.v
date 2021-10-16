module multi_core_processor
#(parameter cores = 6)
( 
	input clk,
	input status,
	input rst,
	output end_process
	
);

wire [(8*cores)-1:0] dram_out; //6cores (maximum)
wire [7:0] iram_out;

wire [7:0] pc_out;
wire [15:0] ar_out;

wire [(8*cores)-1:0] bus_out;  //6cores

wire dram_wrEn;
wire read_IRAM;


core core1(.clk(clk), .dram_out(dram_out[(8*cores)-1:8*(cores-1)]), .iram_out(iram_out), .status(status), .rst(rst),
.dram_wrEn(dram_wrEn), .read_IRAM(read_IRAM), .pc_out(pc_out),
.ar_out(ar_out), .bus_out(bus_out[(8*cores)-1:8*(cores-1)]), .end_process(end_process)); 

genvar i;
generate
    for (i=0; i<=cores-2; i=i+1) begin : processor 
    core coren(.clk(clk), .dram_out(dram_out[(i+1)*8-1:i*8]), .iram_out(iram_out), .status(status), .rst(rst),
 .bus_out(bus_out[(i+1)*8-1:i*8])
    );
end 
endgenerate

 
// core core2(.clk(clk), .dram_out(dram_out[39:32]), .iram_out(iram_out), .status(status), .rst(rst),
// .bus_out(bus_out[39:32])); 
// 
// core core3(.clk(clk), .dram_out(dram_out[31:24]), .iram_out(iram_out), .status(status), .rst(rst),
// .bus_out(bus_out[31:24])); 
// 
//
//core core4(.clk(clk), .dram_out(dram_out[23:16]), .iram_out(iram_out), .status(status), .rst(rst),
// .bus_out(bus_out[23:16])); 
//
//core core5(.clk(clk), .dram_out(dram_out[15:8]), .iram_out(iram_out), .status(status), .rst(rst), 
//.bus_out(bus_out[15:8])); 
//
//core core6(.clk(clk), .dram_out(dram_out[7:0]), .iram_out(iram_out), .status(status), .rst(rst),
// .bus_out(bus_out[7:0])); 


instr_memory IRAM(.clk(clk), .read_IRAM(read_IRAM), .addr(pc_out), .instr_out(iram_out));
DRAM #(.width(cores*8)) DRAM(.clock(clk), .address(ar_out), .data(bus_out), .wren(dram_wrEn),.q(dram_out));

endmodule


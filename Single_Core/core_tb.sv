`timescale 1ns/1ps

module core_tb();

localparam CLK_PERIOD = 20;


reg clk;
reg status;
reg rst;
reg [7:0] instruction; //iram_out
reg [7:0] dram_out;


wire dram_wrEn;
wire read_DRAM;
wire read_IRAM;
wire [7:0] pc_out;
wire [15:0] ar_out;
wire [15:0] bus_out;
wire end_process;

//create clock//

initial
    begin
    clk = 1'b0;
    forever begin
        #(CLK_PERIOD/2);
        clk = ~clk;
    end
end

core core(.clk(clk), .rst(rst), .status(status), .iram_out(instruction), .dram_out(dram_out), .dram_wrEn(dram_wrEn), .read_DRAM(read_DRAM), .read_IRAM(read_IRAM), .pc_out(pc_out), .ar_out(ar_out), .bus_out(bus_out), .end_process(end_process));

initial begin
	@(posedge clk)
	begin
		rst <=0;
	end
    status <= 1;
	 dram_out <= 35;
    instruction <= 6'd0;    
    repeat(3) @(posedge clk) //fetch
    begin
       instruction <= 6'd4; 
	   rst <= 1;
    end

    repeat(7) @(posedge clk) //ldac
    begin
       instruction <= 6'd8; 
    end

    repeat(6) @(posedge clk) //ldacm
    begin
       instruction <= 6'd11; 
    end

    repeat(12) @(posedge clk) //stac
    begin
       instruction <= 6'd20; 
    end

    repeat(4) @(posedge clk) //clac
    begin
       instruction <= 6'd21; 
    end

    repeat(4) @(posedge clk) //movr
    begin
       instruction <= 6'd22; 
    end

    repeat(4) @(posedge clk) //movra
    begin
       instruction <= 6'd43; 
      
    end

    repeat(3) @(posedge clk) //jpnzy (z <= 0)
    begin

    end

    repeat(3) @(posedge clk)
    begin 
    
    end

    repeat(5) @(posedge clk) //jpnz  (z <= 1)
    begin

    end

    @(posedge clk)
    begin

    end
 

    $stop;

end
endmodule
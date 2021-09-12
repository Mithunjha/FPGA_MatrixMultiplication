`timescale 1ns/1ps

module control_unit_tb();

localparam CLK_PERIOD = 20;


reg clk;
reg z;
reg status;
reg [7:0] instruction;

wire [2:0] alu_op;
wire [16:0] write_en;
wire [1:0] inc_en;
wire [3:0] read_en;
wire read_IRAM;
wire read_DRAM;
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

control_unit cu(.clk(clk), .z(z), .status(status), .instruction(instruction), .alu_op(alu_op), .write_en(write_en), .inc_en(inc_en), .read_en(read_en), .read_IRAM(read_IRAM), .read_DRAM(read_DRAM), .end_process(end_process));

initial begin
    status <= 1;

    instruction <= 6'd0;     
    repeat(3) @(posedge clk) //fetch
    begin
       instruction <= 6'd4; 
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
       z <= 0;
    end

    repeat(3) @(posedge clk) //jpnzy (z <= 0)
    begin

    end

    repeat(3) @(posedge clk)
    begin 
        z <= 1;
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
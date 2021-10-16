`timescale 1ns/1ps

module register_tb();

localparam width = 8;
localparam CLK_PERIOD = 20;

reg [width-1:0] dataIn;
reg write_en;
reg rst;
reg clk;
wire [width-1:0] dataOut;



//create clock//

initial
    begin
    clk = 1'b0;
    forever begin
        #(CLK_PERIOD/2);
        clk = ~clk;
    end
end

//module in testbench//

register #(.width(width)) dut(.clk(clk), .rst(rst), .write_en(write_en), .dataIn(dataIn), .dataOut(dataOut));

initial begin

    @(posedge clk)
    rst <= 0;

    @(posedge clk)
    rst <= 1;
    dataIn <= 20;
    write_en <= 0;

    @(posedge clk)
    dataIn <= 43;
    write_en <= 1;

    repeat(10) @(posedge clk)
    begin
        dataIn <= $random;
        write_en <= $random;
        $display("%12b ", dataIn);
    end

    $stop;
end

endmodule

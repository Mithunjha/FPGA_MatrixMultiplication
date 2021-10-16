`timescale 1ns/1ps

module reginc_tb();

localparam width = 16;
localparam CLK_PERIOD = 20;

reg [width-1:0] dataIn;
reg write_en;
reg inc_en;
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

reginc #(.width(width)) pc(.clk(clk), .rst(rst), .write_en(write_en), .inc_en(inc_en), .dataIn(dataIn), .dataOut(dataOut));

initial begin

    @(posedge clk)
    rst <= 0;
    inc_en <= 0;

    @(posedge clk)
    dataIn <= 20;
    write_en <= 0;
    inc_en <= 0;

    @(posedge clk)
    dataIn <= 25;
    write_en <= 0;
    inc_en <= 1;

    @(posedge clk)
    dataIn <= 30;
    write_en <= 1;
    inc_en <= 0;

    @(posedge clk)
    dataIn <= 35;
    write_en <= 1;
    inc_en <= 1;

    @(posedge clk)
    rst <= 1;
    inc_en <= 0;

    @(posedge clk)
    dataIn <= 20;
    write_en <= 0;
    inc_en <= 0;

    @(posedge clk)
    dataIn <= 25;
    write_en <= 0;
    inc_en <= 1;

    @(posedge clk)
    dataIn <= 30;
    write_en <= 1;
    inc_en <= 0;

    @(posedge clk)
    dataIn <= 35;
    write_en <= 1;
    inc_en <= 1;

    repeat(10) @(posedge clk)
    begin
        dataIn <= $random;
        write_en <= $random;
        inc_en <= $random;
        $display("%16b ", dataIn);
    end

    $stop;
end

endmodule
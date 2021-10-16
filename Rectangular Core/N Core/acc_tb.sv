`timescale 1ns/1ps

module acc_tb();

localparam CLK_PERIOD = 20;


reg [15:0] dataIn;
reg [15:0] aluIn;
reg write_en;
reg inc_en;
reg rst;
reg clk;
reg alu_en;
wire [15:0] dataOut;


//create clock//

initial
    begin
    clk = 1'b0;
    forever begin
        #(CLK_PERIOD/2);
        clk = ~clk;
    end
end

acc acc(.dataIn(dataIn), .aluIn(aluIn), .write_en(write_en), .inc_en(inc_en), .rst(rst), .clk(clk), .alu_en(alu_en), .dataOut(dataOut));

initial 
begin
    @(posedge clk)
    rst <= 0;


    @(posedge clk)
    dataIn <= 20;
    aluIn <= 200;
    inc_en <= 0;
    write_en <= 0;
    alu_en <= 0;

    @(posedge clk)
    dataIn <= 25;
    aluIn <= 250;
    inc_en <= 0;
    write_en <= 0;
    alu_en <= 1;

    @(posedge clk)
    dataIn <= 30;
    aluIn <= 300;
    inc_en <= 0;
    write_en <= 1;
    alu_en <= 0;

    @(posedge clk)
    dataIn <= 35;
    aluIn <= 350;
    inc_en <= 1;
    write_en <= 0;
    alu_en <= 0;

    @(posedge clk)
    dataIn <= 40;
    aluIn <= 400;
    inc_en <= 1;
    write_en <= 0;
    alu_en <= 1;

    @(posedge clk)
    dataIn <= 45;
    aluIn <= 450;
    inc_en <= 1;
    write_en <= 1;
    alu_en <= 0;

    rst <= 1;


    @(posedge clk)
    dataIn <= 20;
    aluIn <= 200;
    inc_en <= 0;
    write_en <= 0;
    alu_en <= 0;

    @(posedge clk)
    dataIn <= 25;
    aluIn <= 250;
    inc_en <= 0;
    write_en <= 0;
    alu_en <= 1;

    @(posedge clk)
    dataIn <= 30;
    aluIn <= 300;
    inc_en <= 0;
    write_en <= 1;
    alu_en <= 0;

    @(posedge clk)
    dataIn <= 35;
    aluIn <= 350;
    inc_en <= 1;
    write_en <= 0;
    alu_en <= 0;

    @(posedge clk)
    dataIn <= 40;
    aluIn <= 400;
    inc_en <= 1;
    write_en <= 0;
    alu_en <= 1;

    @(posedge clk)
    dataIn <= 45;
    aluIn <= 450;
    inc_en <= 1;
    write_en <= 1;
    alu_en <= 0;

    @(posedge clk)
    dataIn <= 50;
    aluIn <= 500;
    inc_en <= 1;
    write_en <= 1;
    alu_en <= 1;

    repeat(10) @(posedge clk)
    begin
        dataIn <= $random;
        write_en <= $random;
        inc_en <= $random;
        $display("%12b ", dataIn);
    end

    $stop;
end
endmodule


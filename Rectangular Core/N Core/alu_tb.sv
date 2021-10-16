`timescale 1ns/1ps

module alu_tb();

localparam CLK_PERIOD = 20;


reg clk;
reg [15:0] aluIn1; // aluIn1 => AC
reg [15:0] aluIn2;
reg [2:0] aluOp;
wire [15:0] aluOut;
wire z;


//create clock//

initial
    begin
    clk = 1'b0;
    forever begin
        #(CLK_PERIOD/2);
        clk = ~clk;
    end
end

alu alu(.clk(clk), .aluIn1(aluIn1), .aluIn2(aluIn2), .aluOp(aluOp), .aluOut(aluOut), .z(z));

initial begin
    @(posedge clk)
    aluIn1 <= 63;
    aluIn2 <= 47;
    aluOp <= 1;

    @(posedge clk)
    aluOp <= 2;

    @(posedge clk)
    aluOp <= 3;

    @(posedge clk)
    aluOp <= 4;

    @(posedge clk)
    aluOp <= 5;

    @(posedge clk)
    aluOp <= 6;

    @(posedge clk)
    aluOp <= 7;
    



    repeat(10) @(posedge clk)
    begin
        aluIn1 <= aluIn1 + 1;
        aluIn2 <= aluIn2 + 10;
        aluOp <= $random;
        $display("%16b ", aluIn1);
        $display("%16b ", aluIn2);
    end

    @(posedge clk)
    aluIn1 <= 1;
    aluIn2 <= 47;
    aluOp <= 0;

    @(posedge clk)
    aluIn1 <= 63;
    aluIn2 <= 47;
    aluOp <= 6;

    @(posedge clk)
    aluIn1 <= 2;
    aluOp <= 4;

    @(posedge clk)
    aluIn1 <= 1;
    aluOp <= 4;

    @(posedge clk)
    aluIn1 <= 2;
    aluIn2 <= 47;
    aluOp <= 0;

    @(posedge clk)
    aluIn1 <= 63;
    aluIn2 <= 47;
    aluOp <= 6;


    $stop;

end
endmodule


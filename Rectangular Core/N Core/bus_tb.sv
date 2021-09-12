`timescale 1ns/1ps
module bus_tb();
localparam CLK_PERIOD = 20;


reg clk;
reg [4:0] read_en; 	//read enable
reg [7:0] ir;
reg [7:0] tr;
reg [7:0] dr;
reg [15:0] ra;
reg [15:0] rb;
reg [15:0] ro;
reg [7:0] rcol1;
reg [7:0] rcol2;
reg [7:0] rn;
reg [7:0] rp;
reg [7:0] rc;
reg [7:0] rr;
reg [15:0] rt;
reg [15:0] ac;
reg [7:0] dram;
wire [15:0] busIn;


//create clock//
initial
    begin
    clk = 1'b0;
    forever begin
        #(CLK_PERIOD/2);
        clk = ~clk;
    end
end

bus bus(.clk(clk), .read_en(read_en), .ir(ir), .tr(tr), .dr(dr), .ra(ra), .rb(rb), .ro(ro), .rcol1(rcol1), .rcol2(rcol2), .rn(rn), .rp(rp), .rc(rc), .rr(rr), .rt(rt), .ac(ac), .dram(dram), .busIn(busIn));

initial begin
    @(posedge clk)
	 ir <= 11;			//max255
	 tr <= 22;
	 dr <= 33;
	 ra <= 44;
	 
    read_en <=1 ;		//5d1-->ir
	 @(posedge clk)
	 ir <= 0;			
	 @(posedge clk)
	 ir <= -1;			
	 @(posedge clk)
	 ir <= 255;			
	 @(posedge clk)
	 ir <= 256;			
	 	
	 @(posedge clk)
    read_en <=2 ;		//5d2-->tr
	 @(posedge clk)
	 tr <= 0;	
	 @(posedge clk)
	 tr <= -2;			
	 @(posedge clk)
	 tr <= 255;			
	 @(posedge clk)
	 tr <= 256;			
	 @(posedge clk)
	 ir <= 27;			
    //read_en <=1 ;
	 @(posedge clk)
	 tr <= -2;

	 @(posedge clk)
    read_en <=3 ;		//5d3-->dr
	 @(posedge clk)
	 dr <= -2;	
	 @(posedge clk)
	 dr <= 2;			
	 @(posedge clk)
	 dr <= 255;			
	 @(posedge clk)
	 tr <= 255;			
	 @(posedge clk)
	 ir <= 28;
	 
	 @(posedge clk)
    read_en <=4;		//5d4-->ra
	 @(posedge clk)
	 ra <= -2;	
	 @(posedge clk)
	 ra <= 2;			
	 @(posedge clk)
	 ra <= 65533;					
	 @(posedge clk)
	 ra <= 27;
	 
	 @(posedge clk)
    read_en <=5 ;		//5d5-->rb
	 rb <= 99;
	 @(posedge clk)
	 rb <= -2;	
	 @(posedge clk)
	 rb <= 2;						
	 @(posedge clk)
	 rb <= 65535;			
	 @(posedge clk)
	 ir <= 30;
	 
	 @(posedge clk)
	 ro <= 88;
    read_en <=6 ;		//5d6-->ro
	 @(posedge clk)
	 ro <= -2;	
	 @(posedge clk)
	 ro <= 2;						
	 @(posedge clk)
	 ro <= 65536;			
	 
	 @(posedge clk)
    read_en <=7 ;		//5d7-->rn
	 @(posedge clk)
	 rn <= -2;	
	 @(posedge clk)
	 rn <= 2;						
	 @(posedge clk)
	 rn<= 256;			
	 @(posedge clk)
	 ir <= 31;
	 
	 @(posedge clk)
	 rp <= 88;
    read_en <=8;		//5d8-->rp
	 @(posedge clk)
	 rp <= 5;	
	 @(posedge clk)
	 rp<= 255;						
	 @(posedge clk)
	 rp <= 256;
	 
	 @(posedge clk)
	 rc <= 99;
    read_en <=9 ;		//5d9-->rc
	 @(posedge clk)
	 rc <= 0;	
	 @(posedge clk)
	 rc<= -5;						
	 @(posedge clk)
	 rp <= 13;
	 
	 @(posedge clk)
	 rr <= 100;
    read_en <=10 ;		//5d10-->rr
	 @(posedge clk)
	 rr <= 0;	
	 @(posedge clk)
	 rr<= -5;						
	 @(posedge clk)
	 ir <= 133;
	 
	 @(posedge clk)
	 rt <= 65536;
    read_en <=11 ;		//5d11-->rt
	 @(posedge clk)
	 rt <= 0;	
	 @(posedge clk)
	 rt<= -5;						
	 @(posedge clk)
	 rp <= 1300;
	 
	 @(posedge clk)
	 ac <= 0;
    read_en <=12 ;		//5d12-->ac
	 @(posedge clk)
	 ac <= -3;	
	 @(posedge clk)
	 ac<= 65537;
	 @(posedge clk)
	 ac<= 65535;
	 @(posedge clk)
	 rr <= 66;
	 
	 @(posedge clk)
	 dram <= 0;
    read_en <=13 ;		//5d13-->dram
	 @(posedge clk)
	 dram <= -5;	
	 @(posedge clk)
	 dram<= 256;						
	 @(posedge clk)
	 rc <= 77;
	 
	 @(posedge clk)
	 ir <= 2;
	 tr <= 7;
	 read_en <= 14;		//5d14-->IR-TR
	 
	 @(posedge clk)
	 dram <= 0;
    read_en <=15 ;		//5d15-->AC[15:8]
	 @(posedge clk)
	 ac <= 16'b0000000011111111;	
	 @(posedge clk)
	 ac<= 16'b1100111000100001 ;						
	 @(posedge clk)
	 ac <= 16'b1010010100111001;
	 
	 @(posedge clk)
	 rcol1 <= 100;
    read_en <=16 ;		//5d16-->rcol1
	 @(posedge clk)
	 rcol1 <= 0;	
	 @(posedge clk)
	 rcol1<= -5;						
	 @(posedge clk)
	 rcol1 <= 133;

	 @(posedge clk)
	 rcol2 <= 100;
    read_en <=17 ;		//5d17-->rcol2
	 @(posedge clk)
	 rcol2 <= 0;	
	 @(posedge clk)
	 rcol2<= -5;						
	 @(posedge clk)
	 rcol2 <= 133;
	 @(posedge clk)
	 rcol1<= -5;						
	 @(posedge clk)
	 rcol1 <= 133;

	 @(posedge clk)		//repetition of test bench case
	 dram <= 0;
	 
    $stop;
end
endmodule


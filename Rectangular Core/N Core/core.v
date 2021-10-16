module core

( 
	input clk,
	input [7:0] dram_out,
	input [7:0] iram_out,
	input status,
	input rst,
	output reg dram_wrEn,
	//output read_DRAM,
	output read_IRAM,
	output [7:0] pc_out,
	output [15:0] ar_out,
	output [15:0] bus_out,
	output end_process 
);

wire [2:0] alu_op;
wire [18:0] write_en ;  //19bits
wire [4:0] read_en ;  //5bits
wire [1:0] inc_en;
//wire read_IRAM;
//wire read_DRAM;
//wire end_process; 



wire [15:0] alu_out;
//wire [15:0] bus_out;
wire [15:0] r_out ;
wire [15:0] ac_out ;
wire [15:0] ra_out ;
wire [15:0] rb_out ;
wire [15:0] ro_out ;
wire [7:0] rcol1_out ;
wire [7:0] rcol2_out ;
wire [7:0] rn_out ;
wire [7:0] rp_out ;
wire [7:0] rc_out ;
wire [7:0] rr_out ;
wire [15:0] rt_out ;
wire [7:0] dr_out ;
wire [7:0] tr_out ;
wire [7:0] ir_out ;


wire z ;

localparam width = 8;


register ar(.dataIn(bus_out), .write_en(write_en[0]), .rst(rst), .clk(clk), .dataOut(ar_out));
register #(.width(width)) ir(.dataIn(iram_out), .write_en(write_en[2]), .rst(rst), .clk(clk), .dataOut(ir_out));
register #(.width(width)) tr(.dataIn(ir_out), .write_en(write_en[3]), .rst(rst), .clk(clk), .dataOut(tr_out));
register #(.width(width)) dr(.dataIn(bus_out), .write_en(write_en[4]), .rst(rst), .clk(clk), .dataOut(dr_out));
register ra(.dataIn(bus_out), .write_en(write_en[5]), .rst(rst), .clk(clk), .dataOut(ra_out));
register rb(.dataIn(bus_out), .write_en(write_en[6]), .rst(rst), .clk(clk), .dataOut(rb_out));
register ro(.dataIn(bus_out), .write_en(write_en[7]), .rst(rst), .clk(clk), .dataOut(ro_out));
register #(.width(width)) rn(.dataIn(bus_out), .write_en(write_en[8]), .rst(rst), .clk(clk), .dataOut(rn_out));
register #(.width(width)) rcol1(.dataIn(bus_out), .write_en(write_en[17]), .rst(rst), .clk(clk), .dataOut(rcol1_out));
register #(.width(width)) rcol2(.dataIn(bus_out), .write_en(write_en[18]), .rst(rst), .clk(clk), .dataOut(rcol2_out));
register #(.width(width)) rp(.dataIn(bus_out), .write_en(write_en[9]), .rst(rst), .clk(clk), .dataOut(rp_out));
register #(.width(width)) rc(.dataIn(bus_out), .write_en(write_en[10]), .rst(rst), .clk(clk), .dataOut(rc_out));
register #(.width(width)) rr(.dataIn(bus_out), .write_en(write_en[11]), .rst(rst), .clk(clk), .dataOut(rr_out));
register rt(.dataIn(bus_out), .write_en(write_en[12]), .rst(rst), .clk(clk), .dataOut(rt_out));
register r(.dataIn(ac_out), .write_en(write_en[13]), .rst(rst), .clk(clk), .dataOut(r_out));


reginc #(.width(width)) pc(.dataIn(ir_out), .write_en(write_en[1]), .inc_en(inc_en[0]), .rst(rst), .clk(clk), .dataOut(pc_out));
acc ac(.dataIn(bus_out), .aluIn(alu_out), .write_en(write_en[14]), .inc_en(inc_en[1]), .rst(rst), .clk(clk), .alu_en(write_en[15]), .dataOut(ac_out));

alu alu(.clk(clk), .aluIn1(ac_out), .aluIn2(r_out), .aluOp(alu_op), .aluOut(alu_out), .z(z));
bus bus(.clk(clk), .read_en(read_en), .ir(ir_out), .tr(tr_out), .dr(dr_out), .ra(ra_out), .rb(rb_out), .ro(ro_out), .rcol1(rcol1_out), .rcol2(rcol2_out), .rn(rn_out), .rp(rp_out), .rc(rc_out), .rr(rr_out), .rt(rt_out), .ac(ac_out), .dram(dram_out), .busIn(bus_out));

control_unit cu(.clk(clk), .z(z), .status(status), .instruction(ir_out), .alu_op(alu_op), .write_en(write_en), .inc_en(inc_en), .read_en(read_en), .read_IRAM(read_IRAM), .end_process(end_process));

always@(write_en[16])
begin
dram_wrEn <= write_en[16];
end

endmodule
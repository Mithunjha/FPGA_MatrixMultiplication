module instr_memory(input clk,
input read_IRAM,
input [7:0] addr,//256 locations
output reg [7:0] instr_out);

reg [7:0] ram [102:0];
parameter idle = 8'd0;
parameter ldac = 8'd4;
parameter ldacm = 8'd8;
parameter stac = 8'd11;
parameter clac = 8'd19;
parameter movr = 8'd20;
parameter movra = 8'd21;
parameter movrb = 8'd22;
parameter movro = 8'd23;
parameter movrn = 8'd24; //
parameter movrp = 8'd25;
parameter movrc = 8'd26;
parameter movrr = 8'd27;
parameter movrt = 8'd28;
parameter mvacra = 8'd29;
parameter mvacrb = 8'd30;
parameter mvacro = 8'd31;
parameter mvacrn = 8'd32; //
parameter mvacrp = 8'd33;
parameter mvacrc = 8'd34;
parameter mvacrr = 8'd35;
parameter mvacrt = 8'd36;
parameter add = 8'd37;
parameter mul = 8'd38;
parameter sub = 8'd39;
parameter inc = 8'd40;
parameter dec = 8'd41;
parameter jpnz = 8'd42;
parameter endop = 8'd46;
parameter movrcol1 = 6'd47;
parameter mvacrcol1 = 6'd48;
parameter movrcol2 = 6'd49;
parameter mvacrcol2 = 6'd50;
parameter xorop = 6'd51;



initial begin
ram[0] = clac;
ram[1] = ldac;
ram[2] = 8'd0;	//load data memory location of matrix size
ram[3] = 8'd0;
ram[4] = ldacm;
ram[5] = movrn;
ram[6] = movrp;
ram[7] = ldac;
ram[8] = 8'd1;
ram[9] = 8'd0;
ram[10] = ldacm;
ram[11] = movrr;


ram[12] = ldac;
ram[13] = 8'd2;
ram[14] = 8'd0;
ram[15] = ldacm;
ram[16] = movrcol1;
ram[17] = ldac;
ram[18] = 8'd3;
ram[19] = 8'd0;
ram[20] = ldacm;
ram[21] = movrcol2;



ram[22] = ldac;
ram[23] = 8'd4;
ram[24] = 8'd0;
ram[25] = movra;
ram[26] = ldac;
ram[27] = 8'd4;//lsb
ram[28] = 8'd1;
ram[29] = movrb;
ram[30] = ldac;
ram[31] = 8'd4;//lsb
ram[32] = 8'd2;
ram[33] = movro;
ram[34] = mvacrcol2;
ram[35] = movrc;
ram[36] = clac;
ram[37] = movrt;
ram[38] = mvacrcol1;
ram[39] = movrp;
ram[40] = mvacra;
ram[41] = ldacm;
ram[42] = movr;
ram[43] = mvacrb;
ram[44] = ldacm;
ram[45] = mul; //xorop
ram[46] = movr;
ram[47] = mvacrt;
ram[48] = add;
ram[49] = movrt;
ram[50] = mvacra;
ram[51] = inc;
ram[52] = movra;
ram[53] = mvacrcol2;
ram[54] = movr;
ram[55] = mvacrb;
ram[56] = add;
ram[57] = movrb;
ram[58] = mvacrp;
ram[59] = dec;
ram[60] = movrp;
ram[61] = jpnz;
ram[62] = 8'd40;  
ram[63] = mvacro;
ram[64] = stac;
ram[65] = mvacro;
ram[66] = inc;
ram[67] = inc;
ram[68] = movro;
ram[69] = mvacrcol1;
ram[70] = movr;
ram[71] = mvacra;
ram[72] = sub;
ram[73] = movra;
ram[74] = mvacrcol1;
ram[75] = movr;


ram[76] = mvacrcol2;


ram[77] = mul;
ram[78] = movr;
ram[79] = mvacrb;
ram[80] = sub;
ram[81] = inc;
ram[82] = movrb;
ram[83] = mvacrc;
ram[84] = dec;
ram[85] = movrc;
ram[86] = jpnz;
ram[87] = 8'd36;
ram[88] = mvacrcol1;
ram[89] = movr;
ram[90] = mvacra;
ram[91] = add;
ram[92] = movra;
ram[93] = ldac;
ram[94] = 8'd4;
ram[95] = 8'd1;
ram[96] = movrb;
ram[97] = mvacrr;
ram[98] = dec;
ram[99] = movrr;
ram[100] = jpnz;
ram[101] = 8'd34;
ram[102] = endop;
end

always @(posedge clk) 
begin
if (read_IRAM == 1)
instr_out <= ram[addr];
end

endmodule




module instr_memory(input clk,
input read_IRAM,
input [7:0] addr,//256 locations
output reg [7:0] instr_out);

reg [7:0] ram [90:0];
parameter idle = 8'd0;
parameter ldac = 8'd4;
parameter ldacm = 8'd8;
parameter stac = 8'd11;
parameter clac = 8'd19;
parameter movr = 8'd20;
parameter movra = 8'd21;
parameter movrb = 8'd22;
parameter movro = 8'd23;
parameter movrn = 8'd24;
parameter movrp = 8'd25;
parameter movrc = 8'd26;
parameter movrr = 8'd27;
parameter movrt = 8'd28;
parameter mvacra = 8'd29;
parameter mvacrb = 8'd30;
parameter mvacro = 8'd31;
parameter mvacrn = 8'd32;
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

initial begin
ram[0] = clac;
ram[1] = ldac;
ram[2] = 8'd0;	//load data memory location of matrix size
ram[3] = 8'd0;
ram[4] = ldacm;
ram[5] = movrr;
ram[6] = movrp;
ram[7] = movrn;
ram[8] = ldac;
ram[9] = 8'd2;
ram[10] = 8'd0;
ram[11] = movra;
ram[12] = ldac;
ram[13] = 8'd2;//lsb
ram[14] = 8'd1;
ram[15] = movrb;
ram[16] = ldac;
ram[17] = 8'd2;//lsb
ram[18] = 8'd2;
ram[19] = movro;
ram[20] = mvacrn;
ram[21] = movrc;
ram[22] = clac;
ram[23] = movrt;
ram[24] = mvacrn;
ram[25] = movrp;
ram[26] = mvacra;
ram[27] = ldacm;
ram[28] = movr;
ram[29] = mvacrb;
ram[30] = ldacm;
ram[31] = mul;
ram[32] = movr;
ram[33] = mvacrt;
ram[34] = add;
ram[35] = movrt;
ram[36] = mvacra;
ram[37] = inc;
ram[38] = movra;
ram[39] = mvacrn;
ram[40] = movr;
ram[41] = mvacrb;
ram[42] = add;
ram[43] = movrb;
ram[44] = mvacrp;
ram[45] = dec;
ram[46] = movrp;
ram[47] = jpnz;
ram[48] = 8'd26;
ram[49] = mvacro;
ram[50] = stac;
ram[51] = mvacro;
ram[52] = inc;
ram[53] = inc;
ram[54] = movro;
ram[55] = mvacrn;
ram[56] = movr;
ram[57] = mvacra;
ram[58] = sub;
ram[59] = movra;
ram[60] = mvacrn;
ram[61] = movr;
ram[62] = mul;
ram[63] = movr;
ram[64] = mvacrb;
ram[65] = sub;
ram[66] = inc;
ram[67] = movrb;
ram[68] = mvacrc;
ram[69] = dec;
ram[70] = movrc;
ram[71] = jpnz;
ram[72] = 8'd22;
ram[73] = mvacrn;
ram[74] = movr;
ram[75] = mvacra;
ram[76] = add;
ram[77] = movra;
ram[78] = ldac;
ram[79] = 8'd2;
ram[80] = 8'd1;
ram[81] = movrb;
ram[82] = mvacrr;
ram[83] = dec;
ram[84] = movrr;
ram[85] = jpnz;
ram[86] = 8'd20;
ram[87] = endop;
end

always @(posedge clk) 
begin
if (read_IRAM == 1)
instr_out <= ram[addr];
end

endmodule




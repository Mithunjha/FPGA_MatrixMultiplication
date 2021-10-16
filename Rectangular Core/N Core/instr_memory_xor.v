module instr_memory_xor(input clk,
input read_IRAM,
input [7:0] addr,//256 locations
output reg [7:0] instr_out);

reg [7:0] ram [16:0];
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
ram[2] = 8'd4;	//load data memory location of matrix size
ram[3] = 8'd0;
ram[4] = ldacm;
ram[5] = movr;
ram[6] = ldac;
ram[7] = 8'd4;
ram[8] = 8'd1;
ram[9] = ldacm;
ram[10] = xorop;
ram[11] = movrt;
ram[12] = ldac;
ram[13] = 8'd4;
ram[14] = 8'd2;
ram[15] = stac;
ram[16] = endop;

end

always @(posedge clk) 
begin
if (read_IRAM == 1)
instr_out <= ram[addr];
end

endmodule




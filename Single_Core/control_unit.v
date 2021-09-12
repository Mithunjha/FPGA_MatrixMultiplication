module control_unit
(
    input clk,
    input z,
    input status,
    input [7:0] instruction,
    output reg [2:0] alu_op,
    output reg [16:0] write_en,
    output reg [1:0] inc_en,
    output reg [3:0] read_en,
    output reg read_IRAM,
    //output reg read_DRAM,
    output reg end_process
);

reg [5:0] present = 6'd0;      //6'd0 = idle
reg [5:0] next = 6'd0;

//Micro Instructions
parameter
idle = 6'd0,
fetch1 = 6'd1,
fetch2 = 6'd2,
fetch3 = 6'd3,
ldac1 = 6'd4,
ldac2 = 6'd5,
ldac3 = 6'd6,
ldac4 = 6'd7,
ldacm1 = 6'd8,
ldacm2 = 6'd9,
ldacm3 = 6'd10,
stac1 = 6'd11,
stac2 = 6'd12,
stac3 = 6'd13,
stac4 = 6'd14,
stac5 = 6'd15,
stac6 = 6'd16,
stac7 = 6'd17,
stac8 = 6'd18,
clac = 6'd19,
movr = 6'd20,
movra = 6'd21,
movrb = 6'd22,
movro = 6'd23,
movrn = 6'd24,
movrp = 6'd25,
movrc = 6'd26,
movrr = 6'd27,
movrt = 6'd28,
mvacra = 6'd29,
mvacrb = 6'd30,
mvacro = 6'd31,
mvacrn = 6'd32,
mvacrp = 6'd33,
mvacrc = 6'd34,
mvacrr = 6'd35,
mvacrt = 6'd36,
add = 6'd37,
mul = 6'd38,
sub = 6'd39,
inc = 6'd40,
dec = 6'd41,
jpnz = 6'd42,
jpnzy1 = 6'd43,
jpnzy2 = 6'd44,
jpnzn1 = 6'd45,
endop = 6'd46;
//nop = 6'd48;


//checking the termination condition
always @(posedge clk)
begin
    present <= next;
    if (present == endop)
        end_process <= 1'd1;
    else
        end_process <= 1'd0;
end


always @(present or z or instruction or status) 
case(present)
    idle: begin
        read_IRAM <= 0;
        read_en <= 4'd0;
        write_en <= 17'b00000000000000000 ;
        inc_en <= 2'b00 ;
        alu_op <= 3'd0;
        if (status == 1)
        next <= fetch1;
        else
        next <= idle;
    end

    endop: begin
        read_IRAM <= 0;
        read_en <= 4'd0;  
        write_en <= 17'b00000000000000000 ;
        inc_en <= 2'b00 ;  
        alu_op <= 3'd0;
        next <= endop;
    end

    fetch1: begin
        read_IRAM <= 1;  //READ IRAM
        read_en <= 4'd0;  
        write_en <= 17'b00000000000000000 ; 
        inc_en <= 2'b00 ;
        alu_op <= 3'd0;
        next <= fetch2;
    end


    fetch2: begin
        read_IRAM <= 0;
        read_en <= 4'd0;    
        write_en <= 17'b00000000000000100 ; // IR <- IRAM
        inc_en <= 2'b01 ; //pc<-pc+1
        alu_op <= 3'd0;
        next <= fetch3;
    end


    fetch3: begin
        read_IRAM <= 1;    //Read IRAM
        read_en <= 4'd0;
        write_en <= 17'b00000000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= instruction[5:0];  //get assembly code
    end

    ldac1: begin
        read_IRAM <= 0;
        read_en <= 4'd0;
        write_en <= 17'b00000000000000100 ; //IR <- IRAM
        inc_en <= 2'b01 ; //pc<-pc+1
        alu_op <= 3'd0;
        next <= ldac2;
    end

    ldac2: begin
        read_IRAM <= 1; //Read
        read_en <= 4'd1; //BUS <- IR
        write_en <= 17'b00000000000001000 ;  //TR <-- BUS
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= ldac3;
    end

    ldac3: begin
        read_IRAM <= 0;
        read_en <= 4'd0;
        write_en <= 17'b00000000000000100 ; //IR <- IRAM
        inc_en <= 2'b01 ; //pc<-pc+1
        alu_op <= 3'd0;
        next <= ldac4;
    end

    ldac4: begin
        read_IRAM <= 0;
        read_en <= 4'd14;   //AC <- IR TR
        write_en <= 17'b00100000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    ldacm1: begin
        read_IRAM <= 0;
        //read_DRAM <= 1;
        read_en <= 4'd12;  //BUS <- AC
        write_en <= 17'b00000000000000001 ;  //AR <- BUS
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= ldacm2;
    end
	 
	 ldacm2 : begin
//	     read_IRAM <= 0;
//        read_en <= 4'd0;  
//        write_en <= 17'b00000000000000000 ;  //waste a clock cycle
//        inc_en <= 2'b00 ; 
//        alu_op <= 3'd0;
        next <= ldacm3;
	 end

    ldacm3: begin
        read_IRAM <= 0;
        read_en <= 4'd13;  // BUS <- DRAM 
        write_en <= 17'b00100000000010000 ; 
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end



    stac1: begin
        read_IRAM <= 0;
        read_en <= 4'd12;  //BUS <- AC
        write_en <= 17'b00000000000000001 ; // AR <- BUS
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= stac2;
    end

    stac2: begin
        read_IRAM <= 0;
        read_en <= 4'd11;  //BUS <- RT
        write_en <= 17'b00100000000000000 ; //AC <- BUS
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= stac3;
    end

    stac3: begin
        read_IRAM <= 0;
        read_en <= 4'd12;  //BUS <- AC[7:0]  check 12
        write_en <= 17'b00000000000010000 ; //DR <- BUS
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= stac4;
    end
	 
	 

    stac4: begin
        read_IRAM <= 0;
        read_en <= 4'd3;  //BUS <- DR
        write_en <= 17'b10000000000000000 ; //DRAM <- BUS
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= stac5;
    end
	 

    stac5: begin
        read_IRAM <= 0;
        read_en <= 4'd6;  //BUS <- RO
        write_en <= 17'b00100000000000000 ; //AC<- BUS
        inc_en <= 2'b10 ; //AC <- AC+1 
        alu_op <= 3'd0;
        next <= stac6;
    end

    stac6: begin
        read_IRAM <= 0;
        read_en <= 4'd12;  //BUS <- AC
        write_en <= 17'b00000000000000001 ; // AR <- BUS
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= stac7;
    end

    stac7: begin
        read_IRAM <= 0;
        read_en <= 4'd11;  //BUS <-RT
        write_en <= 17'b00100000000000000 ; // AC <-- BUS
        inc_en <= 2'b00; 
        alu_op <= 3'd0;
        next <= stac8;
    end

    stac8: begin
        read_IRAM <= 0;
        read_en <= 4'd15;  //BUS<-AC[15:8]   Check with dhinesh
        write_en <= 17'b10000000000010000 ; // DR <-- BUS, DRAM <-- BUS
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end


    clac: begin
        read_IRAM <= 0;
        read_en <= 4'd0;  
        write_en <= 17'b01000000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd5; //default AC <- 0, Z<- 1
        next <= fetch1;
    end

    movr: begin
        read_IRAM <= 0;
        read_en <= 4'd12;  //BUS <- AC
        write_en <= 17'b00010000000000000 ; // R <- BUS
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    movra: begin
        read_IRAM <= 0;
        read_en <= 4'd12;  //BUS <- AC
        write_en <= 17'b00000000000100000 ; // RA <- BUS
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end


    movrb: begin
        read_IRAM <= 0;
        read_en <= 4'd12;  //BUS <- AC
        write_en <= 17'b00000000001000000 ; // RB <- BUS
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    movro: begin
        read_IRAM <= 0;
        read_en <= 4'd12;                       //RO <- AC
        write_en <= 17'b00000000010000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    movrn: begin
        read_IRAM <= 0;
        read_en <= 4'd12;                      //RN <- AC
        write_en <= 17'b00000000100000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end
//
    movrp: begin
        read_IRAM <= 0;
        read_en <= 4'd12;                   //RP <- AC
        write_en <= 17'b00000001000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    movrc: begin
        read_IRAM <= 0;
        read_en <= 4'd12;                   //RC <- AC
        write_en <= 17'b000000010000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    movrr: begin
        read_IRAM <= 0;
        read_en <= 4'd12;                   //RR <- AC
        write_en <= 17'b00000100000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    movrt: begin
        read_IRAM <= 0;
        read_en <= 4'd12;                  //RT <- AC
        write_en <= 17'b00001000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    mvacra: begin
        read_IRAM <= 0;
        read_en <= 4'd4;            //AC <- RA
        write_en <= 17'b00100000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    mvacrb: begin
        read_IRAM <= 0;
        read_en <= 4'd5;        //AC <- RB
        write_en <= 17'b00100000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    mvacro: begin
        read_IRAM <= 0;
        read_en <= 4'd6;  //AC <- RO
        write_en <= 17'b00100000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    mvacrn: begin
        read_IRAM <= 0;
        read_en <= 4'd7;  //AC <- RN
        write_en <= 17'b00100000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    mvacrp: begin
        read_IRAM <= 0;
        read_en <= 4'd8;                //AC <- RP
        write_en <= 17'b00100000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    mvacrc: begin
        read_IRAM <= 0;
        read_en <= 4'd9;                //AC <- RC
        write_en <= 17'b00100000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    mvacrr: begin
        read_IRAM <= 0;
        read_en <= 4'd10;               //AC <- RR
        write_en <= 17'b00100000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end

    mvacrt: begin
        read_IRAM <= 0;
        read_en <= 4'd11;                  //AC <- RT
        write_en <= 17'b00100000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= fetch1;
    end
//
    add: begin
        read_IRAM <= 0;
        read_en <= 4'd0;  
        write_en <= 17'b01000000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd1; //AC <- AC + R
        next <= fetch1;
    end

    mul: begin
        read_IRAM <= 0;
        read_en <= 4'd0;  
        write_en <= 17'b01000000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd3; //AC <- AC * R
        next <= fetch1;
    end
    
    sub: begin
        read_IRAM <= 0;
        read_en <= 4'd0;  
        write_en <= 17'b01000000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd2; //AC <- AC - R
        next <= fetch1;
    end

    inc: begin
        read_IRAM <= 0;
        read_en <= 4'd0;  
        write_en <= 17'b00000000000000000 ;//
        inc_en <= 2'b10 ; //AC <- AC + 1
        alu_op <= 3'd0;
        next <= fetch1;
    end

    dec: begin
        read_IRAM <= 0;
        read_en <= 4'd0;  
        write_en <= 17'b01000000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd4; //AC <- AC - 1
        next <= fetch1;
    end

    
    jpnz: begin
        read_IRAM <= 0;
        read_en <= 4'd0;  //IR <-IRAM
        write_en <= 17'b00000000000000000 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        if (z==0)
            next <= jpnzy1;
        else
            next <= jpnzn1;
    end   


    jpnzy1: begin
        read_IRAM <= 0;
        read_en <= 4'd0;  //IR <- IRAM
        write_en <= 17'b00000000000000100 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;
        next <= jpnzy2;
    end

    jpnzy2: begin
        read_IRAM <= 0;
        read_en <= 4'd1;  //PC <- IR
        write_en <= 17'b00000000000000010 ;
        inc_en <= 2'b00 ; 
        alu_op <= 3'd0;  //3'd2
        next <= fetch1;
    end
    
    jpnzn1: begin
        read_IRAM <= 0;
        read_en <= 4'd0;  
        write_en <= 17'b00000000000000000 ;
        inc_en <= 2'b01 ;  //PC<-PC+1
        alu_op <= 3'd0;
        next <= fetch1;
    end

endcase
endmodule

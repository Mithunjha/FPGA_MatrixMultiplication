`timescale 1ns/1ps

module single_core_processor_tb();

localparam CLK_PERIOD = 20;


reg clk;
reg status;
reg rst;
wire end_process;

//create clock//

initial
    begin
    clk = 1'b0;
    forever begin
        #(CLK_PERIOD/2);
        clk = ~clk;
    end
end

single_core_processor processor(.clk(clk), .rst(rst), .status(status), .end_process(end_process));

initial begin
	@(posedge clk)
	begin
		rst <=0;
	end

   @(posedge clk)
	begin
		rst <=1;
	end

   @(posedge clk)
	begin
		status <= 1;
	end
   
    
      
   if (end_process == 1)  
       $stop;

end
endmodule
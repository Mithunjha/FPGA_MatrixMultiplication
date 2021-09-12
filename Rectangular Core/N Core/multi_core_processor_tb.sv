`timescale 1ns/1ps

module multi_core_processor_tb();

localparam CLK_PERIOD = 20;
localparam cores = 4;

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

multi_core_processor #(.cores(cores)) processor(.clk(clk), .rst(rst), .status(status), .end_process(end_process));

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
	
      
	forever @(posedge clk)
    begin
		if(end_process)
		begin
			$stop;
		end
    end


end
endmodule
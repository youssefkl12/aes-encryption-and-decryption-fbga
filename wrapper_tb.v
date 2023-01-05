`timescale 1 ns/ 10 ps
module wrapper_tb(

);
reg clk;
reg reset;
wire finishin;


wrapper w(
.clk(clk),
.reset(reset),
.finishin(finishin)
); 

localparam PERIOD=10;

always begin
 #(PERIOD/2) clk=~clk;
 end
 
 initial begin
clk=0;
reset=0;

#PERIOD
reset=1;

#PERIOD 
reset=0;

#(20*100)
	if (finishin ==0)
	$display("Testing Failed!");
	else begin
	
	$display("Testing Succeeded!");
	end 
	
	#0 $finish;


end


endmodule
 
 
`timescale 1 ns/ 10 ps

module Decryption_tb();
reg clk;
reg reset;
reg [255:0]key;
reg [1:0]mux;
reg [127:0]in_state;
wire [127:0] out_state;
wire [3:0] counter;



Decryption e(
.clk(clk),
.reset(reset),
.key(key),
.mux(mux),
.in_state(in_state),
.out_state(out_state),
.counter(counter)
);

localparam PERIOD=10;

always begin
 #(PERIOD/2) clk=~clk;
 end
 
 initial begin
clk=0;
reset=0;
key=256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
        
mux=2'b10;
in_state=128'h8ea2b7ca516745bfeafc49904b496089; 

#PERIOD
reset=1;

#PERIOD 
reset=0;

#(20*50)


$finish;

end


endmodule
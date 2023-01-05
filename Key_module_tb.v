module Key_module_tb();
reg [255:0] key;
reg [1:0] Algorithm;
reg [3:0] i;
wire[127:0] out;


key_module e(
. key(key),
.Algorithm(Algorithm),
.i(i),
.out(out)


);
 initial begin
key=256'h000102030405060708090a0b0c0d0e0f10111213141516170000000000000000; 
Algorithm=2'b01;
i=0;
#100
i=1;
#100
i=2;
#100
i=3;
#100
i=4;
#100
i=5;
#100
i=6;
#100
i=7;
#100
i=8;
#100
i=9;
#100
i=10;
#100
i=11;
#100
i=12;
#100

$finish;

end


endmodule
 
 
module sBox_tb();
reg [7:0] in;
wire [7:0] out;



initial begin
in = 8'h00 ;
#100
in = 8'h39 ;
#100
in = 8'h94 ;
#200 $finish;
end

sBox s1(
in,
out
);


endmodule

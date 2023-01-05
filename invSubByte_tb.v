module invSubByte_tb();
reg [31:0] in;
wire [31:0] out;



initial begin
in = 32'h2b7e1516 ;
#100
in = 32'h28aed2a6 ;
#100
in = 32'habf71588  ;
#200 $finish;
end

invSubByte s1(
in,
out
);


endmodule

module SubByte(
input [31:0] in,
output [31:0] out
);


sBox s1(in[7:0], out[7:0]);
sBox s2(in[15:8], out[15:8]);
sBox s3(in[23:16], out[23:16]);
sBox s4(in[31:24], out[31:24]);

endmodule

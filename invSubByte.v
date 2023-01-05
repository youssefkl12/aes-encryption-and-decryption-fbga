module invSubByte(
input [31:0] in,
output [31:0] out
);


invsBox s1(in[7:0], out[7:0]);
invsBox s2(in[15:8], out[15:8]);
invsBox s3(in[23:16], out[23:16]);
invsBox s4(in[31:24], out[31:24]);

endmodule

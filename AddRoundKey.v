module AddRoundKey(
input [127:0] key,
input [127:0] text,
output [127:0] textenq
);

assign textenq=key^text;

endmodule

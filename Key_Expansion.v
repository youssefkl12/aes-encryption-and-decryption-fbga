module Key_Expansion(
input [31:0] W0_old,
input [31:0] W1_old,
input [31:0] W2_old,
input [31:0] W3_old,
input [3:0] i_Nk,
output [31:0] W0_new,
output [31:0] W1_new,
output [31:0] W2_new,
output [31:0] W3_new
);

wire [31:0] Rcon_out;
wire [31:0] W3_temp1;
wire [31:0] W3_temp2;

Rcon r1(i_Nk, Rcon_out);

assign W3_temp1 [7:0]=W3_old[31:24];
assign W3_temp1 [31:8]=W3_old[23:0];

SubByte s1(
W3_temp1,
W3_temp2
);

assign W0_new=W0_old^W3_temp2^Rcon_out;
assign W1_new=W1_old^W0_new;
assign W2_new=W2_old^W1_new;
assign W3_new=W3_old^W2_new;

endmodule


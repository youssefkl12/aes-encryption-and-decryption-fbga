module inv_ShiftRow (
input [127:0] in,
output [127:0] out
);
wire [7:0] wire_in[0:3][0:3];
wire [7:0] wire_out[0:3][0:3];

assign wire_in[0][0]=in[127:120];
assign wire_in[1][0]=in[119:112];
assign wire_in[2][0]=in[111:104];
assign wire_in[3][0]=in[103:96];


assign wire_in[0][1]=in[95:88];
assign wire_in[1][1]=in[87:80];
assign wire_in[2][1]=in[79:72];
assign wire_in[3][1]=in[71:64];


assign wire_in[0][2]=in[63:56];
assign wire_in[1][2]=in[55:48];
assign wire_in[2][2]=in[47:40];
assign wire_in[3][2]=in[39:32];


assign wire_in[0][3]=in[31:24];
assign wire_in[1][3]=in[23:16];
assign wire_in[2][3]=in[15:8];
assign wire_in[3][3]=in[7:0];








assign wire_out[0][0]=wire_in[0][0];
assign wire_out[0][1]=wire_in[0][1];
assign wire_out[0][2]=wire_in[0][2];
assign wire_out[0][3]=wire_in[0][3];


assign wire_out[1][0]=wire_in[1][3];
assign wire_out[1][1]=wire_in[1][0];
assign wire_out[1][2]=wire_in[1][1];
assign wire_out[1][3]=wire_in[1][2];


assign wire_out[2][0]=wire_in[2][2];
assign wire_out[2][1]=wire_in[2][3];
assign wire_out[2][2]=wire_in[2][0];
assign wire_out[2][3]=wire_in[2][1];

assign wire_out[3][0]=wire_in[3][1];
assign wire_out[3][1]=wire_in[3][2];
assign wire_out[3][2]=wire_in[3][3];
assign wire_out[3][3]=wire_in[3][0];






assign out[127:120]=wire_out[0][0]; 
assign out[119:112]=wire_out[1][0];
assign out[111:104]=wire_out[2][0]; 
assign out[103:96]=wire_out[3][0]; 


assign out[95:88]=wire_out[0][1];
assign out[87:80]=wire_out[1][1]; 
assign out[79:72]=wire_out[2][1];
assign out[71:64]=wire_out[3][1];


assign out[63:56]=wire_out[0][2];
assign out[55:48]=wire_out[1][2];
assign out[47:40]=wire_out[2][2];
assign out[39:32]=wire_out[3][2];


assign out[31:24]=wire_out[0][3];
assign out[23:16]=wire_out[1][3];
assign out[15:8]=wire_out[2][3];
assign out[7:0]=wire_out[3][3];




endmodule 
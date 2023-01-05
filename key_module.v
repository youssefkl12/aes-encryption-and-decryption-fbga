module key_module(
input [255:0] key,
input [1:0] Algorithm,
input [3:0] i,
output reg [127:0] out
);

wire [255:0] keyin1;
wire [255:0] keyin2;
wire [255:0] keyin3;
wire [255:0] keyin4;
wire [255:0] keyin5;
wire [255:0] keyin6;
wire [255:0] keyin7;
wire [255:0] keyin8;

wire[1663:0] array; 
wire [3:0] i_Nk;
wire [255:0]key_exp_out1;
wire [255:0]key_exp_out2;
wire [255:0]key_exp_out3;
wire [255:0]key_exp_out4;
wire [255:0]key_exp_out5;
wire [255:0]key_exp_out6;
wire [255:0]key_exp_out7;
wire [255:0]key_exp_out8;
//0 original 192 key
assign array[1663:1472]=key[255:64];
//1
assign keyin1=key;
Key_Expansion_new  singleKeyExpansionInst1 (keyin1,4'h1,2'b01,key_exp_out1);
assign array[1471:1280]=key_exp_out1[255:64];
//2
assign keyin2=key_exp_out1;
Key_Expansion_new  singleKeyExpansionInst2 (keyin2,4'h2,2'b01,key_exp_out2);
assign array[1279:1088]=key_exp_out2[255:64];
//3
assign keyin3=key_exp_out2;
Key_Expansion_new  singleKeyExpansionInst3 (keyin3,4'h3,2'b01,key_exp_out3);
assign array[1087:896]=key_exp_out3[255:64];
//4
assign keyin4=key_exp_out3;
Key_Expansion_new  singleKeyExpansionInst4 (keyin4,4'h4,2'b01,key_exp_out4);
assign array[895:704]=key_exp_out4[255:64];
//5
assign keyin5=key_exp_out4;
Key_Expansion_new  singleKeyExpansionInst5 (keyin5,4'h5,2'b01,key_exp_out5);
assign array[703:512]=key_exp_out5[255:64];
//6
assign keyin6=key_exp_out5;
Key_Expansion_new  singleKeyExpansionInst6 (keyin6,4'h6,2'b01,key_exp_out6);
assign array[511:320]=key_exp_out6[255:64];
//7
assign keyin7=key_exp_out6;
Key_Expansion_new  singleKeyExpansionInst7 (keyin7,4'h7,2'b01,key_exp_out7);
assign array[319:128]=key_exp_out7[255:64];
//8
assign keyin8=key_exp_out7;
Key_Expansion_new  singleKeyExpansionInst8 (keyin8,4'h8,2'b01,key_exp_out8);
assign array[127:00]=key_exp_out8[255:128];

always@(*)begin
//originla key
if(i==0)begin
out=array[1663:1536];
end

if(i==1)begin
out=array[1535:1408];
end

if(i==2)begin
out=array[1407:1280];
end
if(i==3)begin
out=array[1279:1152];
end
if(i==4)begin
out=array[1151:1024];
end
if(i==5)begin
out=array[1023:896];
end
if(i==6)begin
out=array[895:768];
end
if(i==7)begin
out=array[767:640];
end
if(i==8)begin
out=array[639:512];
end
if(i==9)begin
out=array[511:384];
end
if(i==10)begin
out=array[383:256];
end
if(i==11)begin
out=array[255:128];
end
if(i==12)begin
out=array[127:0];
end
end


endmodule
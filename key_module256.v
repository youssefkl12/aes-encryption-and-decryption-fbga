module key_module256(
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

wire[1919:0] array; 
wire [3:0] i_Nk;
wire [255:0]key_exp_out1;
wire [255:0]key_exp_out2;
wire [255:0]key_exp_out3;
wire [255:0]key_exp_out4;
wire [255:0]key_exp_out5;
wire [255:0]key_exp_out6;
wire [255:0]key_exp_out7;
//0 original 192 key
assign array[1919:1664]=key[255:0];
//1
assign keyin1=key;
Key_Expansion_new  singleKeyExpansionInst1 (keyin1,4'h1,2'b10,key_exp_out1);
assign array[1663:1408]=key_exp_out1[255:0];
//2
assign keyin2=key_exp_out1;
Key_Expansion_new  singleKeyExpansionInst2 (keyin2,4'h2,2'b10,key_exp_out2);
assign array[1407:1152]=key_exp_out2[255:0];
//3
assign keyin3=key_exp_out2;
Key_Expansion_new  singleKeyExpansionInst3 (keyin3,4'h3,2'b10,key_exp_out3);
assign array[1151:896]=key_exp_out3[255:0];
//4
assign keyin4=key_exp_out3;
Key_Expansion_new  singleKeyExpansionInst4 (keyin4,4'h4,2'b10,key_exp_out4);
assign array[895:640]=key_exp_out4[255:0];
//5
assign keyin5=key_exp_out4;
Key_Expansion_new  singleKeyExpansionInst5 (keyin5,4'h5,2'b10,key_exp_out5);
assign array[639:384]=key_exp_out5[255:0];
//6
assign keyin6=key_exp_out5;
Key_Expansion_new  singleKeyExpansionInst6 (keyin6,4'h6,2'b10,key_exp_out6);
assign array[383:128]=key_exp_out6[255:0];
//7
assign keyin7=key_exp_out6;
Key_Expansion_new  singleKeyExpansionInst7 (keyin7,4'h7,2'b10,key_exp_out7);
assign array[127:0]=key_exp_out7[255:128];

always@(*)begin
//originla key
if(i==0)begin
out=array[1919:1792];
end
if(i==1)begin
out=array[1791:1664];
end

if(i==2)begin
out=array[1663:1536];
end
if(i==3)begin
out=array[1535:1408];
end
if(i==4)begin
out=array[1407:1280];
end
if(i==5)begin
out=array[1279:1152];
end
if(i==6)begin
out=array[1151:1024];
end
if(i==7)begin
out=array[1023:896];
end
if(i==8)begin
out=array[895:768];
end
if(i==9)begin
out=array[767:640];
end
if(i==10)begin
out=array[639:512];
end
if(i==11)begin
out=array[511:384];
end
if(i==12)begin
out=array[383:256];
end
if(i==13)begin
out=array[255:128];
end
if(i==14)begin
out=array[127:0];
end
end

endmodule

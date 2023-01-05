module InvMixColumns(in,out
    );
input [0:127]in;
output [0:127]out;

assign out[0:7] = MultiplyByE(in[0:7])^MultiplyByB(in[8:15])^MultiplyByD(in[16:23])^MultiplyByNine(in[24:31]);
assign out[8:15] = MultiplyByNine(in[0:7])^MultiplyByE(in[8:15])^MultiplyByB(in[16:23])^MultiplyByD(in[24:31]);
assign out[16:23] = MultiplyByD(in[0:7])^MultiplyByNine(in[8:15])^MultiplyByE(in[16:23])^MultiplyByB(in[24:31]);
assign out[24:31] = MultiplyByB(in[0:7])^MultiplyByD(in[8:15])^MultiplyByNine(in[16:23])^MultiplyByE(in[24:31]);

assign out[32:39] = MultiplyByE(in[32:39])^MultiplyByB(in[40:47])^MultiplyByD(in[48:55])^MultiplyByNine(in[56:63]);
assign out[40:47] = MultiplyByNine(in[32:39])^MultiplyByE(in[40:47])^MultiplyByB(in[48:55])^MultiplyByD(in[56:63]);
assign out[48:55] = MultiplyByD(in[32:39])^MultiplyByNine(in[40:47])^MultiplyByE(in[48:55])^MultiplyByB(in[56:63]);
assign out[56:63] = MultiplyByB(in[32:39])^MultiplyByD(in[40:47])^MultiplyByNine(in[48:55])^MultiplyByE(in[56:63]);

assign out[64:71] = MultiplyByE(in[64:71])^MultiplyByB(in[72:79])^MultiplyByD(in[80:87])^MultiplyByNine(in[88:95]);
assign out[72:79] = MultiplyByNine(in[64:71])^MultiplyByE(in[72:79])^MultiplyByB(in[80:87])^MultiplyByD(in[88:95]);
assign out[80:87] = MultiplyByD(in[64:71])^MultiplyByNine(in[72:79])^MultiplyByE(in[80:87])^MultiplyByB(in[88:95]);
assign out[88:95] = MultiplyByB(in[64:71])^MultiplyByD(in[72:79])^MultiplyByNine(in[80:87])^MultiplyByE(in[88:95]);

assign out[96:103] = MultiplyByE(in[96:103])^MultiplyByB(in[104:111])^MultiplyByD(in[112:119])^MultiplyByNine(in[120:127]);
assign out[104:111] = MultiplyByNine(in[96:103])^MultiplyByE(in[104:111])^MultiplyByB(in[112:119])^MultiplyByD(in[120:127]);
assign out[112:119] = MultiplyByD(in[96:103])^MultiplyByNine(in[104:111])^MultiplyByE(in[112:119])^MultiplyByB(in[120:127]);
assign out[120:127] = MultiplyByB(in[96:103])^MultiplyByD(in[104:111])^MultiplyByNine(in[112:119])^MultiplyByE(in[120:127]);

function [0:7]xtime;
input [0:7]i;
begin
if(i[0] ==0)
xtime = {i[1:7],1'b0};
else
xtime = {i[1:7],1'b0}^8'h1b;
end
endfunction



function [7:0] MultiplyByTwo;
	input [7:0] x;
	begin 
			/* multiplication by 2 is shifting on bit to the left, and if the original 8 bits had a 1 @ MSB, xor the result with 0001 1011*/
			if(x[7] == 1) MultiplyByTwo = ((x << 1) ^ 8'h1b);
			else MultiplyByTwo = x << 1; 
	end 	
endfunction


function [7:0] MultiplyByNine;
	input [7:0] x;
	begin 
/*	 x*2*2=4
*2=8
^x =9*/
	
			/* multiplication by 3 ,= 01 ^ 10 = (NUM * 01) XOR (NUM * 10) = (NUM) XOR (NUM Muliplication by 2) */
			MultiplyByNine = MultiplyByTwo(MultiplyByTwo(MultiplyByTwo(x)))^x ;
	end 
endfunction

function [7:0] MultiplyByB;
	input [7:0] x;
	begin 
/*x*2 *2 =4
   ^ x =5
   *2=10
   ^x =11*/
	
			/* multiplication by 3 ,= 01 ^ 10 = (NUM * 01) XOR (NUM * 10) = (NUM) XOR (NUM Muliplication by 2) */
			MultiplyByB = MultiplyByTwo(MultiplyByTwo(MultiplyByTwo(x))^x)^x ;
	end 
endfunction


function [7:0] MultiplyByE;
	input [7:0] x;
	begin 
/*
x*2
^x=3
*2=6
^x=7
*2=14
*/
	
			/* multiplication by 3 ,= 01 ^ 10 = (NUM * 01) XOR (NUM * 10) = (NUM) XOR (NUM Muliplication by 2) */
			MultiplyByE = MultiplyByTwo(MultiplyByTwo(MultiplyByTwo(x)^x)^x );
	end 
endfunction

function [7:0] MultiplyByD;
	input [7:0] x;
	begin 
/*
X*2=2
^x=3
*2=6
*2=12
^x=13
*/
	
			/* multiplication by 3 ,= 01 ^ 10 = (NUM * 01) XOR (NUM * 10) = (NUM) XOR (NUM Muliplication by 2) */
			MultiplyByD = MultiplyByTwo(MultiplyByTwo(MultiplyByTwo(x)^x))^x;
	end 
endfunction




endmodule




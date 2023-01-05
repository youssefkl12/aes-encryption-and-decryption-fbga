module MixColumns(in,out
    );
input [0:127]in;
output [0:127]out;

assign out[0:7] = xtime(in[0:7])^xtime(in[8:15])^in[8:15]^in[16:23]^in[24:31];
assign out[8:15] = in[0:7]^xtime(in[8:15])^xtime(in[16:23])^in[16:23]^in[24:31];
assign out[16:23] = in[0:7]^in[8:15]^xtime(in[16:23])^xtime(in[24:31])^in[24:31];
assign out[24:31] = xtime(in[0:7])^in[0:7]^in[8:15]^in[16:23]^xtime(in[24:31]);

assign out[32:39] = xtime(in[32:39])^xtime(in[40:47])^in[40:47]^in[48:55]^in[56:63];
assign out[40:47] = in[32:39]^xtime(in[40:47])^xtime(in[48:55])^in[48:55]^in[56:63];
assign out[48:55] = in[32:39]^in[40:47]^xtime(in[48:55])^xtime(in[56:63])^in[56:63];
assign out[56:63] = xtime(in[32:39])^in[32:39]^in[40:47]^in[48:55]^xtime(in[56:63]);

assign out[64:71] = xtime(in[64:71])^xtime(in[72:79])^in[72:79]^in[80:87]^in[88:95];
assign out[72:79] = in[64:71]^xtime(in[72:79])^xtime(in[80:87])^in[80:87]^in[88:95];
assign out[80:87] = in[64:71]^in[72:79]^xtime(in[80:87])^xtime(in[88:95])^in[88:95];
assign out[88:95] = xtime(in[64:71])^in[64:71]^in[72:79]^in[80:87]^xtime(in[88:95]);

assign out[96:103] = xtime(in[96:103])^xtime(in[104:111])^in[104:111]^in[112:119]^in[120:127];
assign out[104:111] = in[96:103]^xtime(in[104:111])^xtime(in[112:119])^in[112:119]^in[120:127];
assign out[112:119] = in[96:103]^in[104:111]^xtime(in[112:119])^xtime(in[120:127])^in[120:127];
assign out[120:127] = xtime(in[96:103])^in[96:103]^in[104:111]^in[112:119]^xtime(in[120:127]);

function [0:7]xtime;
input [0:7]i;
begin
if(i[0] ==0)
xtime = {i[1:7],1'b0};
else
xtime = {i[1:7],1'b0}^8'h1b;
end
endfunction
endmodule


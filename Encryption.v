module Encryption(
input clk,
input reset,
input [255:0]key,
input [1:0]mux,
input [127:0]in_state,
output reg [127:0] out_state,//for testing
output reg [3:0] counter,
output reg finishEncrypt
);

//-----states-------//
reg [3:0] state_reg;
reg [3:0] state_next;
//-----------------//

//------holding the initial values.......//
reg [127:0] in_state_reg;
reg [255:0] key_reg;


//-----------module registers-----------//

reg [127:0] addroundkeyin;

wire [127:0] addroundkeyout;

reg [127:0] addroundk;

reg [127:0] roundKeyStateOut;

wire [127:0] subByteStateOut;

reg [127:0] shiftrowin;

wire [127:0] shiftrowout;

reg [127:0] mixcolumnsin;

wire [127:0] mixcolumnsout;

reg [255:0] keyexpansionin;

reg [3:0] i_Nk;

reg [1:0] Algorithm;

wire [255:0] keyexpansionout;
wire [255:0] keyexpansionout192;
wire [255:0] keyexpansionout256;
//---------------------------------------//


localparam idle=4'd0;
localparam subbytes=4'd1;
localparam shiftrow=4'd2;
localparam mixcolumns=4'd3;
localparam addroundkeynormal=4'd4;
localparam keyExpansion=4'd5;
localparam done=4'd6;
localparam keyExpansion192=4'd7;
localparam keyExpansion256=4'd8;
//--------------------------------------//
integer i = 1;

//--------------calling assignments-----------//

key_module k1(key,2'b01,i,keyexpansionout192);
key_module256 k2(key,2'b10,i,keyexpansionout256);
AddRoundKey a1(
addroundk,
addroundkeyin,
addroundkeyout
);
genvar itr;
	generate
		for (itr = 0 ; itr <= 127; itr = itr+32)
		begin:hi
			SubByte subByteInst (roundKeyStateOut[itr +:32] , subByteStateOut[itr +:32]);
	   end
endgenerate
	
ShiftRow shiftRowsInst (shiftrowin, shiftrowout);
MixColumns mixColumnsInst (mixcolumnsin,mixcolumnsout);
Key_Expansion_new singleKeyExpansionInst (keyexpansionin,i_Nk,Algorithm,keyexpansionout);
//---------------------------------------------//

always@(posedge clk or posedge reset)
if(reset == 1'b1)
begin
state_reg = idle;
i=1;
out_state=0;
counter=0;
end
else begin


case (state_reg)

//------adding the round key---------//
idle:
begin
addroundk = key[255:128];
addroundkeyin=in_state;
out_state = addroundkeyout;
state_reg = subbytes;
end

subbytes:

begin

// activate sub byte //
roundKeyStateOut = addroundkeyout;
out_state = subByteStateOut;
state_reg = shiftrow;
//-------------------//
end

shiftrow:
begin
// activate shift row //
shiftrowin = subByteStateOut;
out_state = shiftrowout;
if(mux==2'b00) begin
	if(i==10) begin 
		state_reg = keyExpansion;
	end
	else begin
		state_reg = mixcolumns;
	end
end

if(mux==2'b01) begin
	if(i==12) begin 
		state_reg = keyExpansion192;
	end
	else begin
		state_reg = mixcolumns;
	end
end

if(mux==2'b10) begin
	if(i==14) begin 
		state_reg = keyExpansion256;
	end
	else begin
		state_reg = mixcolumns;
	end
end

end
//-------------------//

mixcolumns:
begin
//------ activate mix columns----- //
mixcolumnsin = shiftrowout;
if(mux==2'b00) begin
	state_reg = keyExpansion;
end
else if(mux==2'b01) begin
	state_reg = keyExpansion192;
end

else if(mux==2'b10) begin
	state_reg = keyExpansion256;
end

out_state = mixcolumnsout;
//--------------------------------//
end
//-------------Key Expansion state----------//
keyExpansion:
begin
if(i==1)begin
keyexpansionin=key;
end else begin 
keyexpansionin=keyexpansionout;
end
i_Nk=((4'd4)*i)/4;
Algorithm=2'b00;
out_state =  keyexpansionout[255:128];
state_reg = addroundkeynormal;
end
//--------------------------------------//
keyExpansion192:
begin
out_state =  keyexpansionout192;
state_reg = addroundkeynormal;
end

keyExpansion256:
begin
out_state =  keyexpansionout256;
state_reg = addroundkeynormal;
end
//-----------add round key state-------//

addroundkeynormal:
begin
counter = i;
if(mux==2'b00) begin 
		addroundk = keyexpansionout[255:128];
	if(i==10) begin 
		addroundkeyin=shiftrowout;
	end
	else begin
		addroundkeyin=mixcolumnsout;
	end
end

if(mux==2'b01) begin 
		addroundk = keyexpansionout192;
	if(i==12) begin 
		addroundkeyin=shiftrowout;
	end
	else begin
		addroundkeyin=mixcolumnsout;
	end
end


if(mux==2'b10) begin 
		addroundk = keyexpansionout256;
	if(i==14) begin 
		addroundkeyin=shiftrowout;
	end
	else begin
		addroundkeyin=mixcolumnsout;
	end
end
//out_state =  keyexpansionout[255:128];
out_state =  addroundkeyout;

// change the key register to hold new value and change the state reg //
if(mux==2'b00) begin
	if(i<10) begin
		i=i+1;
		state_reg =subbytes;
	end else begin

		state_reg = done;

	end
end

if(mux==2'b01) begin
	if(i<12) begin
		i=i+1;
		state_reg =subbytes;
	end else begin
		state_reg = done;

	end
end

if(mux==2'b10) begin
	if(i<14) begin
		i=i+1;
		state_reg =subbytes;
	end else begin
		state_reg = done;

	end
end

end

done:
begin
out_state = addroundkeyout;
finishEncrypt=1'b1;
end

endcase 

end

//----------------------------------//


endmodule


module Decryption(
input clk,
input reset,
input [255:0]key,
input [1:0]mux,
input [127:0]in_state,
output reg [127:0] out_state,//for testing
output reg [3:0] counter,
output reg finishDecrypt
);

//-----states-------//
reg [3:0] state_reg;
reg [3:0] state_next;
//-----------------//

//------holding the initial values.......//
reg [127:0] in_state_reg;
reg [255:0] key_reg;


//-----------module registers-----------//
reg [127:0] addroundk;

reg [127:0] addroundkeyin;

wire [127:0] addroundkeyout;

reg [127:0] subbytein;

wire [127:0] subByteStateOut;

reg [127:0] shiftrowin;

wire [127:0] shiftrowout;

reg [127:0] mixcolumnsin;

wire [127:0] mixcolumnsout;

reg [255:0] keyexpansionin;

reg [3:0] i_Nk;

reg [1:0] Algorithm;

wire [127:0] keyexpansionout128;
wire [127:0] keyexpansionout192;
wire [127:0] keyexpansionout256;

//---------------------------------------//


localparam idle=4'd0;
localparam subbytes=4'd1;
localparam shiftrow=4'd2;
localparam mixcolumns=4'd3;
localparam addroundkeynormal=4'd4;
localparam done=4'd6;
localparam keyExpansion128=4'd5;
localparam keyExpansion192=4'd7;
localparam keyExpansion256=4'd8;
//--------------------------------------//
integer i = 1;
integer i2=10;
integer i3=12;
integer i4=14;
//--------------calling assignments-----------//

key_module128 k3(key,2'b00,i2,keyexpansionout128);
key_module k1(key,2'b01,i3,keyexpansionout192);
key_module256 k2(key,2'b10,i4,keyexpansionout256);

AddRoundKey a1(
addroundk,
addroundkeyin,
addroundkeyout
);
genvar itr;
	generate
		for (itr = 0 ; itr <= 127; itr = itr+32)
		begin:hi
			invSubByte subByteInst (subbytein[itr +:32] , subByteStateOut[itr +:32]);
	   end
endgenerate
	
inv_ShiftRow shiftRowsInst (shiftrowin, shiftrowout);
InvMixColumns mixColumnsInst (mixcolumnsin,mixcolumnsout);
inv_Key_Expansion singleKeyExpansionInst (keyexpansionin,Algorithm,i_Nk,keyexpansionout);//---------------------------------------------//

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
if(mux==2'b00)
addroundk = keyexpansionout128;
else if(mux==2'b01)
addroundk = keyexpansionout192;
else if(mux==2'b10)
addroundk = keyexpansionout256;

addroundkeyin=in_state;
out_state = addroundkeyout;
state_reg = shiftrow;
end


shiftrow:
begin
// activate shift row //
if(i==1)
begin
shiftrowin = addroundkeyout;
end
else
begin
shiftrowin = mixcolumnsout;
end
out_state = shiftrowout;
state_reg = subbytes;
end


subbytes:

begin

// activate sub byte //
subbytein = shiftrowout; //shiftrowout;
out_state = subByteStateOut;

if(mux==2'b00) begin

state_reg =keyExpansion128 ;
end

if(mux==2'b01) begin
state_reg = keyExpansion192;
end
	
if(mux==2'b10) begin	
state_reg = keyExpansion256;
end

if(mux==2'b00)
i2=i2-1;
if(mux==2'b01)
i3=i3-1;
if(mux==2'b10)
i4=i4-1;

end




//-------------Key Expansion state----------//
keyExpansion128:
begin
out_state =  keyexpansionout128;
if(i<11) //they don't have of these in encryption so what r these aslan
begin
state_reg = addroundkeynormal;
end
else
begin
state_reg = done;
end
end



//--------------------------------------//
keyExpansion256:
begin
out_state =  keyexpansionout256;
if(i<15) //they don't have of these in encryption so what r these aslan
begin
state_reg = addroundkeynormal;
end
else
begin
state_reg = done;
end
end


keyExpansion192:
begin
out_state =  keyexpansionout192;
if(i<13) //they don't have of these in encryption so what r these aslan
begin
state_reg = addroundkeynormal;
end
else
begin
state_reg = done;
end
end


keyExpansion256:
begin
out_state =  keyexpansionout256;
if(i<15) //they don't have of these in encryption so what r these aslan
begin
state_reg = addroundkeynormal;
end
else
begin
state_reg = done;
end
end
//-----------add round key state-------//
//--------------------------------------//

//-----------add round key state-------//

addroundkeynormal:
begin
counter = i;
if(mux==2'b00) begin 
addroundk = keyexpansionout128;
if(i<11) begin 
addroundkeyin=subByteStateOut;
end
end

if(mux==2'b01) begin 
addroundk = keyexpansionout192;
if(i<13) begin 
addroundkeyin=subByteStateOut;
end
end

if(mux==2'b10) begin 
addroundk = keyexpansionout256;
if(i<15) begin 
addroundkeyin=subByteStateOut;
end
end

//out_state =  keyexpansionout[255:128];
out_state =  addroundkeyout;
state_reg =mixcolumns;
end


//-------------------//

mixcolumns:
begin
//------ activate mix columns----- //
i=i+1;

mixcolumnsin = addroundkeyout;
out_state = mixcolumnsout;
state_reg = shiftrow;

end
//--------------------------------//



done:
begin
out_state = addroundkeyout;
finishDecrypt=1'b1;
end

endcase 

end

//----------------------------------//


endmodule


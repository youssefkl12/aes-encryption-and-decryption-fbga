module Encryption_new(
input clk,
input reset,
input [255:0]key,
input [1:0]mux,
input [127:0]in_state,
output reg [127:0] out_state,//for testing
output reg [3:0] counter

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


//---------------------------------------//


localparam idle=4'd0;
localparam subbytes=4'd1;
localparam shiftrow=4'd2;
localparam mixcolumns=4'd3;
localparam addroundkeynormal=4'd4;
localparam keyExpansion=4'd5;
localparam done=4'd6;
//--------------------------------------//
integer i = 1;

//--------------calling assignments-----------//

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

//------adding thr round key---------//
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
state_reg = mixcolumns;

end
//-------------------//

mixcolumns:
begin
//------ activate mix columns----- //
mixcolumnsin = shiftrowout;
state_reg = keyExpansion;
out_state = mixcolumnsout;
//--------------------------------//
end


addroundkeynormal:
begin
counter = i;
addroundk = keyexpansionout[255:128];
addroundkeyin=mixcolumnsout;


//out_state =  keyexpansionout[255:128];
out_state =  addroundkeyout;


// change the key register to hold new value and change the state reg //
if(i<10) begin
i=i+1;
state_reg =subbytes;
end else begin
state_reg = done;

end
end


done:
begin
out_state = addroundkeyout;
end

endcase 

end

//----------------------------------//


endmodule


module wrapper(
input clk,
input reset,
output wire finishin
//output reg [127:0]out
);

//-----states-------//
reg [3:0] state_reg;
reg [3:0] state_next;

//-----------------//
reg reseten;
reg resetde;
reg finish;
assign finishin=finish;
wire[127:0]test=128'h00112233445566778899aabbccddeeff;


//-----------module registers-----------//
wire [127:0] out_state;//for testing
wire [127:0] out_state2;//for testing
wire [3:0] counter;
wire finishEncrypt;
wire finishDecrypt;
//---------------------------------------//



localparam Encryption=4'd1;
localparam Decryption=4'd2;
localparam done=4'd3;

//--------------------------------------//


//--------------calling assignments-----------//
Encryption e(
clk,
reseten,
256'h000102030405060708090a0b0c0d0e0f00000000000000000000000000000000,
2'b00,
128'h00112233445566778899aabbccddeeff,
out_state,
counter,
finishEncrypt
);
Decryption d1(
clk,
resetde,
256'h000102030405060708090a0b0c0d0e0f00000000000000000000000000000000,
2'b00,
out_state,
out_state2,//for testing
counter,
finishDecrypt
);

//--------------------------------------------//


always @(posedge clk or posedge reset)
begin
if (reset==1'b1)
	begin
		state_reg=Encryption;
		finish=1'b0;
		reseten=1'b1;
		resetde=1'b1;
		//out=0;
	end
else begin

case (state_reg)

Encryption:
begin
reseten=1'b0;
if (finishEncrypt==1'b1)
	begin
	//out=out_state;
		state_reg=Decryption;
	end
end


Decryption:
begin
		resetde=1'b0;
if (finishDecrypt==1'b1)
	begin
	   //out=out_state2;
		state_reg=done;
	end
end

done:
begin
if(test==out_state2)
begin
finish =1'b1;
end

end

endcase
end
end
endmodule


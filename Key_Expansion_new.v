module Key_Expansion_new(
input [255:0] in,
input [3:0] i_Nk,
input [1:0] Algorithm,
output [255:0] out
);
// assigning the wire to desired part of key in case 128 the last 4 keys would be filled with zeros the old part//
wire [31:0] W0_old;
wire [31:0] W1_old;
wire [31:0] W2_old;
wire [31:0] W3_old;
wire [31:0] W4_old;
wire [31:0] W5_old;
wire [31:0] W6_old;
wire [31:0] W7_old;


assign W0_old = in [255: 224];
assign W1_old = in [223: 192];
assign W2_old = in [191: 160];
assign W3_old = in [159: 128];
assign W4_old = in [127: 96];
assign W5_old = in [95: 64];
assign W6_old = in [63: 32];
assign W7_old = in [31:0];
//------------------------------------------------------------------------------------------------//

// assigning the wire to desired part of key in case 128 the last 4 keys would be filled with zeros the old part//
wire [31:0] W0_new;
wire [31:0] W1_new;
wire [31:0] W2_new;
wire [31:0] W3_new;
wire [31:0] W4_new;
wire [31:0] W5_new;
wire [31:0] W6_new;
wire [31:0] W7_new;

//------------------------------------------------------------------------------------------------//


//the first 4 rows will always be done regardless//
wire [31:0] Rcon_out;
wire [31:0] W3_temp1;
wire [31:0] W3_temp2;

wire [31:0] W5_temp1;
wire [31:0] W5_temp2;

wire [31:0] WPrev;

wire [31:0] W7_temp1;
wire [31:0] W7_temp2;

Rcon r1(i_Nk, Rcon_out);

assign W3_temp1 [7:0]=W3_old[31:24];
assign W3_temp1 [31:8]=W3_old[23:0];

assign W5_temp1 [7:0]=W5_old[31:24];
assign W5_temp1 [31:8]=W5_old[23:0];

assign W7_temp1 [7:0]=W7_old[31:24];
assign W7_temp1 [31:8]=W7_old[23:0];

SubByte s1(
W3_temp1,
W3_temp2
);

SubByte s2(
W5_temp1,
W5_temp2
);

SubByte s3(
W7_temp1,
W7_temp2
);



SubByte s4(
W3_new,
WPrev
);

//assign W0_new=W0_old^W3_temp2^Rcon_out;
assign W0_new  =  
    (Algorithm == 2'b00 ) ? W0_old^W3_temp2^Rcon_out : 
	 (Algorithm == 2'b01 ) ? W0_old^W5_temp2^Rcon_out :
	 (Algorithm == 2'b10 ) ? W0_old^W7_temp2^Rcon_out: 32'h00000000;


assign W1_new=W1_old^W0_new;
assign W2_new=W2_old^W1_new;
assign W3_new=W3_old^W2_new;




//----------------------------------------------//

//switch case to act as mux to be able to identify which bits to take//
assign W4_new  =  
    (Algorithm == 2'b00 ) ? 32'h00000000 : 
	 (Algorithm == 2'b01 ) ? W4_old^W3_new :
	 (Algorithm == 2'b10 ) ? W4_old^WPrev : 32'h00000000;

assign W5_new  =  
    (Algorithm == 2'b00 ) ? 32'h00000000 : 
	 (Algorithm == 2'b01 ) ? W5_old^W4_new :
	 (Algorithm == 2'b10 ) ? W5_old^W4_new : 32'h00000000;

assign W6_new  =  
    (Algorithm == 2'b00 ) ? 32'h00000000 : 
	 (Algorithm == 2'b01 ) ? 32'h00000000 :
	 (Algorithm == 2'b10 ) ? W6_old^W5_new : 32'h00000000 ;
	 
assign W7_new  =  
    (Algorithm == 2'b00 ) ? 32'h00000000 : 
	 (Algorithm == 2'b01 ) ? 32'h00000000 :
	 (Algorithm == 2'b10 ) ? W7_old^W6_new : 32'h00000000 ;
//------------------------------------------------------------------//





assign out [255: 224] = W0_new; 
assign out [223: 192] = W1_new; 
assign out [191: 160] = W2_new;
assign out [159: 128] = W3_new; 
assign out [127: 96] = W4_new; 
assign out [95: 64] = W5_new; 
assign out [63: 32] = W6_new; 
assign out [31:0] = W7_new;

endmodule

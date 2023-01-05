module inv_Key_Expansion(
input [255:0] W_enq,
input [1:0] Algorithm,
input [3:0] Rcon,
output [255:0] out
);

wire [31:0] Rcon_out;

wire [31:0] W0_enq;
wire [31:0] W1_enq;
wire [31:0] W2_enq;
wire [31:0] W3_enq;
wire [31:0] W4_enq;
wire [31:0] W5_enq;
wire [31:0] W6_enq;
wire [31:0] W7_enq;

wire [31:0] W0_deq;
wire [31:0] W1_deq;
wire [31:0] W2_deq;
wire [31:0] W3_deq;
wire [31:0] W4_deq;
wire [31:0] W5_deq;
wire [31:0] W6_deq;
wire [31:0] W7_deq;

assign W0_enq = W_enq [255: 224];
assign W1_enq = W_enq [223: 192];
assign W2_enq = W_enq [191: 160];
assign W3_enq = W_enq [159: 128];
assign W4_enq = W_enq [127: 96];
assign W5_enq = W_enq [95: 64];
assign W6_enq = W_enq [63: 32];
assign W7_enq = W_enq [31:0];

wire [31:0] W3_temp1;
wire [31:0] W3_temp2;
wire [31:0] W5_temp1;
wire [31:0] W5_temp2;
wire [31:0] W7_temp1;
wire [31:0] W7_temp2;


wire [31:0] WPrev;

assign W1_deq=W1_enq^W0_enq;
assign W2_deq=W2_enq^W1_enq;
assign W3_deq=W3_enq^W2_enq;



//assign W3_temp =W3_deq;
assign W3_temp1 [7:0]=W3_deq[31:24];
assign W3_temp1 [31:8]=W3_deq[23:0];

assign W5_temp1 [7:0]=W5_deq[31:24];
assign W5_temp1 [31:8]=W5_deq[23:0];

assign W7_temp1 [7:0]=W7_deq[31:24];
assign W7_temp1 [31:8]=W7_deq[23:0];

Rcon r1(Rcon, Rcon_out);

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
W3_enq,
WPrev
);
assign W0_deq  =  
    (Algorithm == 2'b00 ) ? W0_enq^W3_temp2^Rcon_out : 
	 (Algorithm == 2'b01 ) ? W0_enq^W5_temp2^Rcon_out :
	 (Algorithm == 2'b10 ) ? W0_enq^W7_temp2^Rcon_out: 32'h00000000;

//switch case to act as mux to be able to identify which bits to take//	 
assign W4_deq  =  
    (Algorithm == 2'b00 ) ? 32'h00000000 : 
	 (Algorithm == 2'b01 ) ? W4_enq^W3_enq :
	 (Algorithm == 2'b10 ) ? W4_enq^WPrev : 32'h00000000;

assign W5_deq  =  
    (Algorithm == 2'b00 ) ? 32'h00000000 : 
	 (Algorithm == 2'b01 ) ? W5_enq^W4_enq :
	 (Algorithm == 2'b10 ) ? W5_enq^W4_enq : 32'h00000000;

assign W6_deq  =  
    (Algorithm == 2'b00 ) ? 32'h00000000 : 
	 (Algorithm == 2'b01 ) ? 32'h00000000 :
	 (Algorithm == 2'b10 ) ? W6_enq^W5_enq : 32'h00000000 ;
	 
assign W7_deq  =  
    (Algorithm == 2'b00 ) ? 32'h00000000 : 
	 (Algorithm == 2'b01 ) ? 32'h00000000 :
	 (Algorithm == 2'b10 ) ? W7_enq^W6_enq : 32'h00000000 ;
	 
	 
assign out [255: 224] = W0_deq; 
assign out [223: 192] = W1_deq; 
assign out [191: 160] = W2_deq;
assign out [159: 128] = W3_deq; 
assign out [127: 96] = W4_deq; 
assign out [95: 64] = W5_deq; 
assign out [63: 32] = W6_deq; 
assign out [31:0] = W7_deq;
endmodule

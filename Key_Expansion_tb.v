module Key_Expansion_tb();
reg [31:0] W0_old;
reg [31:0] W1_old;
reg [31:0] W2_old;
reg [31:0] W3_old;
reg [3:0] i_Nk;
wire [31:0] W0_new;
wire [31:0] W1_new;
wire [31:0] W2_new;
wire [31:0] W3_new;




initial begin
W0_old = 32'h2b7e1516;
W1_old = 32'h28aed2a6;
W2_old = 32'habf71588;
W3_old = 32'h09cf4f3c;
i_Nk = 4'd1; 

#200 $finish;
end

Key_Expansion s1(
W0_old,
W1_old,
W2_old,
W3_old,
i_Nk,
W0_new,
W1_new,
W2_new,
W3_new
);


endmodule

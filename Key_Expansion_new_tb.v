module Key_Expansion_new_tb();
reg [255:0] in;
reg [3:0] i_Nk;
reg [1:0] Algorithm;
wire [255:0] out;





initial begin
in = 256'h2b7e151628aed2a6abf7158809cf4f3c00000000000000000000000000000000; 
i_Nk = 4'd1;
Algorithm = 2'b00; 
#100
in = 256'h603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4; 
i_Nk = 4'd1;
Algorithm = 2'b10;
#100
in = 256'h8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b0000000000000000;
i_Nk = 4'd1;
Algorithm = 2'b01;
#200 $finish;
end

Key_Expansion_new s1(
in,
i_Nk,
Algorithm,
out
);


endmodule

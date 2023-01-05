module inv_Key_Expansion_tb();
reg [256:0] W_enq;
reg [1:0] algo;
reg [3:0] Rcon;
wire [255:0] W_deq;

initial begin

#5
W_enq = 256'ha0fafe1788542cb123a339392a6c760500000000000000000000000000000000;
algo=2'b00;
Rcon =((4'd4)*1)/4; 
#50
W_enq = 256'hfe0c91f72402f5a5ec12068e6c827f6b0e7a95b95c56fec20000000000000000;
algo=2'b01;
Rcon =((4'd4)*1)/4; 
#5
W_enq = 256'h9ba354118e6925afa51a8b5f2067fcdea8b09c1a93d194cdbe49846eb75d5b9a;
algo=2'b10;
Rcon =((4'd4)*1)/4; 
#5
$finish;

end

inv_Key_Expansion s1(
W_enq,
algo,
Rcon,
W_deq
);


endmodule

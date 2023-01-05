module Rcon_tb();
reg [3:0] in;
wire [31:0] out;


initial begin
in = 4'd1 ;
#100
in = 4'd5 ;
#100
in = 4'd10 ;
#200 $finish;
end

Rcon s1(
in,
out
);


endmodule

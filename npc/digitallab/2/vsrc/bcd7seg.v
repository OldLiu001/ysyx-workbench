module bcd7seg(
input  [3:0] n,
input point,
output reg [7:0] res
);

reg [6:0] h;
always @(*) begin
case (n)
4'b0000: h = 7'b0111111; // 0
4'b0001: h = 7'b0000110; // 1
4'b0010: h = 7'b1011011; // 2
4'b0011: h = 7'b1001111; // 3
4'b0100: h = 7'b1100110; // 4
4'b0101: h = 7'b1101101; // 5
4'b0110: h = 7'b1111101; // 6
4'b0111: h = 7'b0000111; // 7
4'b1000: h = 7'b1111111; // 8
4'b1001: h = 7'b1101111; // 9
default: h = 7'b0000000; // default case
endcase
res[7:1] = ~{h[0], h[1], h[2], h[3], h[4], h[5], h[6]};
res[0] = ~point;
end
endmodule


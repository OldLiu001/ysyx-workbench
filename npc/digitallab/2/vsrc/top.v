module top(
    input clk,
    input rst,
    input [4:0] btn,
    input [15:0] sw,
    input ps2_clk,
    input ps2_data,
    input uart_rx,
    output uart_tx,
    output [15:0] ledr,
    output VGA_CLK,
    output VGA_HSYNC,
    output VGA_VSYNC,
    output VGA_BLANK_N,
    output [7:0] VGA_R,
    output [7:0] VGA_G,
    output [7:0] VGA_B,
    output [7:0] seg0,
    output [7:0] seg1,
    output [7:0] seg2,
    output [7:0] seg3,
    output [7:0] seg4,
    output [7:0] seg5,
    output [7:0] seg6,
    output [7:0] seg7
);
	// 8-3 优先编码器

	// 初始化
	wire [7:0] in;
	assign in = sw[7:0];
	wire has_input;
	assign has_input = |sw[7:0];
	assign ledr[4] = has_input;
	wire [2:0] outputraw;
	assign ledr[2:0] = outputraw;
	
	// 得到lowbit
	wire [7:0] revinput;
	assign revinput = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};
	wire [7:0] lowbit;
	assign lowbit = revinput & -revinput;
	
	// lowbit丢到原味83编码器中
	wire [2:0] tmpres1; // lowbit的编码结果
	encode83 nameisnotimportant(
		lowbit,
		1,
		tmpres1
	);
	assign outputraw = has_input ? 7-tmpres1 : 0;

	bcd7seg nameisnotimportant2({1'b0, outputraw}, 0, seg0);
	assign seg1=0;
	assign seg2=1;
	
endmodule




module encode83(x, en, y);
input  [7:0] x;
input  en;
output reg [2:0] y;

always @(x or en) begin
if (en) begin
case (x)
8'b00000001 : y = 3'b000;
8'b00000010 : y = 3'b001;
8'b00000100 : y = 3'b010;
8'b00001000 : y = 3'b011;
8'b00010000 : y = 3'b100;
8'b00100000 : y = 3'b101;
8'b01000000 : y = 3'b110;
8'b10000000 : y = 3'b111;
default: y = 3'b000;
endcase
end
else y = 3'b000;
end
endmodule


/*
 * Module: calculator
 * Description: The top module of this lab 
 */
module top(
	input CLK,
	input [15:0] SW,
	input [3:0] BTN,
	output [15:0] LED,
	output [6:0] SEG,
	output DP,
	output [3:0] AN
); 
	
	wire [7:0]  result_binary;
	wire [15:0] display_value;
	wire [15:0] counter;	
	wire ov;
	wire clk_en;

	assign LED[15:8] = {ov, 7'b0};	
        assign LED[7:0] = result_binary;
   	assign display_value =  {8'b0, result_binary};

	
   calculator   Icalc(
		.data1_pi(SW[7:4]),
		.data2_pi(SW[3:0]),
		.op_pi(BTN[3:0]),
		.counter_pi(counter),
		.result_po(result_binary),
		.ovflw_po(ov));		


   sevenSegDisplay IsevenSegDisplay (
		.clk_pi(CLK),
		.clk_en_pi(clk_en),
		.num_pi(display_value),
		.seg_po(SEG),
		.dp_po(DP),
		.an_po(AN));


   clkdiv #(.SIZE(10)) Iclkdiv (
		.clk_pi(CLK),
		.clk_en_po(clk_en));
	
   increment Iincrement (
		.clk_pi(CLK),
		.counter_po(counter));
	
		

endmodule // top


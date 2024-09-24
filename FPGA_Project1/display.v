`timescale 1ns/1ns

/* 
 * Modlue: segmentFormatter
 * 
 * Description: Combinational logic for the seven segment bits of a digit of the seven segment display
 *
 * 0 - LSB of disp_po
 * 6 - MSB of disp_po
 
 *           --(0)   
 *      (5)|      |(1)
 *           --(6)
 *      (4)|      |(2)
 *           --(3) 
 * 
 * disp_po is active low 
 */

module segmentFormatter(
	input [3:0] num_pi,   // 4-bit binary number
	output reg [6:0] disp_po  // Hexadecimal digit {0, .., 9, A, b, C, d, E, F)
);
	
//Implement the segmentFormatter module in Verilog RTL.


    always @(num_pi) begin
    
        case(num_pi)
            
            4'b0000    :   disp_po = ~(7'b0111111);
            4'b0001    :   disp_po = ~(7'b0000110);
            4'b0010    :   disp_po = ~(7'b1011011);
            4'b0011    :   disp_po = ~(7'b1001111);
            4'b0100    :   disp_po = ~(7'b1100110);
            4'b0101    :   disp_po = ~(7'b1101101);
            4'b0110    :   disp_po = ~(7'b1111101);
            4'b0111    :   disp_po = ~(7'b0000111);
            4'b1000    :   disp_po = ~(7'b1111111);
            4'b1001    :   disp_po = ~(7'b1100111);
            4'b1010    :   disp_po = ~(7'b1110111);
            4'b1011    :   disp_po = ~(7'b1111100);
            4'b1100    :   disp_po = ~(7'b0111001);
            4'b1101    :   disp_po = ~(7'b1011110);
            4'b1110    :   disp_po = ~(7'b1111001);
            4'b1111    :   disp_po = ~(7'b1110001);
            default :   disp_po = 7'b1110110;
        endcase
    end 
        
        
        
endmodule // segmentFormatter



/* **************************************************************************************************** */


/*
 * Module: sevenSegDisplay
 * Description: Formats an input 16 bit number for the four digit seven-segment display
 */
module sevenSegDisplay(
	input clk_pi,
	input clk_en_pi,
	input[15:0] num_pi,
	output reg [6:0] seg_po,
	output dp_po,
	output reg [3:0] an_po
);
	
	wire [6:0] disp0, disp1, disp2, disp3;
	wire [3:0] digit0, digit1, digit2, digit3;
	
	assign digit0 = num_pi[3:0];
	assign digit1 = num_pi[7:4];
	assign digit2 = num_pi[11:8];
	assign digit3 = num_pi[15:12];
	
	assign dp_po = 1'b1;
	
	
	segmentFormatter IsegmentFormat0 ( .num_pi(digit0), .disp_po(disp0));
	segmentFormatter IsegmentFormat1 ( .num_pi(digit1), .disp_po(disp1));
	segmentFormatter IsegmentFormat2 ( .num_pi(digit2), .disp_po(disp2));
	segmentFormatter IsegmentFormat3 ( .num_pi(digit3), .disp_po(disp3));
	
	initial begin
		seg_po <= 7'h7F;
		an_po <= 4'b1111;
	end
	
	always @(posedge clk_pi) begin
		if(clk_en_pi) begin
			case(an_po) 
				4'b1110: begin
					seg_po <= disp1;
					an_po  <= 4'b1101;
				end
				4'b1101: begin
					seg_po <= disp2;
					an_po  <= 4'b1011;
				end
				4'b1011: begin
					seg_po <= disp3;
					an_po  <= 4'b0111;
				end
				default: begin
					seg_po <= disp0;
					an_po <= 4'b1110;
				end
			endcase
		end // clk_en
	end // always @(posedge clk_pi)
endmodule // sevenSegDisplay


 

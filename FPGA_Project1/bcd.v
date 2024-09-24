
/*
 * Module: bin2BCD
 * Description: Convert 8-bit binary to 3 BCD digits
 */

module bin2decimal(
	input [7:0] num_pi,
	output [11:0] bcdnum_po
	);
	
	wire[15:0] c0, c1, c2, c3,c4, c5;
	wire [3:0] d0, d1, d2,d3,d4, e0, e1,e2, e3, e4;
	
assign c0 = {9'b0, num_pi[7:5]};		
cadd cadd0L(c0[3:0], d0);

assign c1 = {7'b0, d0, num_pi[4]};		
cadd cadd1L(c1[3:0], d1);

assign c2 = {6'b0, c1[4], d1, num_pi[3]};	
cadd cadd2L(c2[3:0], d2);

assign c3 = {5'b0, c2[5:4], d2, num_pi[2]};  
cadd cadd3L(c3[3:0], d3);
cadd cadd3U(c3[7:4], e3);


assign c4 = {3'b0, e3,  d3, num_pi[1]};		
cadd cadd4L(c4[3:0], d4);
cadd cadd4U(c4[7:4], e4);

assign bcdnum_po = {2'b0, c4[8], e4,  d4, num_pi[0]};


endmodule


/*
 * Module: cadd3
 * Description: binary_to_BCD submodule
 */
module cadd(
	input [3:0] in,
  	output [3:0] out
);

	assign out = (in > 4) ? in + 3 : in;	
endmodule


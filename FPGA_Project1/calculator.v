`timescale 1ns/1ns

/*
 * Module: calculator
 * Description: Performs arithmetic operations depending on button 
 */
module calculator(
    input [3:0]  data1_pi, // operand1
    input [3:0]  data2_pi, // operand2
    input [3:0]  op_pi,    // operation 
    input [15:0] counter_pi, 
    output reg [7:0] result_po,  // result
    output reg ovflw_po    // overflow indicator
); 
	
   //assign result_po = {data1_pi, data2_pi};
   //assign ovflo_po = 1'b1;
   
   
   reg [4:0] t;

   always @(op_pi) begin

        if (op_pi == 4'b0000) begin

                result_po = {data1_pi, data2_pi};

        end else if (op_pi == 4'b0001) begin

                t = {1'b0, data1_pi} + {1'b0, data2_pi};
                result_po = {4'b0, t[3:0]};
                ovflw_po = t[4];
        
        end else if (op_pi == 4'b0010) begin

                t = {1'b0, data1_pi} - {1'b0, data2_pi};
                result_po = {4'b0, t[3:0]};
                ovflw_po = (data1_pi >= data2_pi) ? 1'b0 : 1'b1;
        

        end else if (op_pi == 4'b0100) begin

                result_po = data1_pi * data2_pi;
                        

        
        end else if (op_pi == 4'b1000) begin

   
        end else begin
            result_po = counter_pi[7:0];
            ovflw_po = 1'b0; // 

        end


        end
   
   
   
endmodule // calculator


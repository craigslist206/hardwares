`include "defines.v"
module ALU(dst, ov, zr, src0, src1, aluOp, shAmt);
  input [15:0] src0, src1;
	input [2:0] aluOp;
	input [3:0] shAmt;
	output [15:0] dst;
	output ov, zr;
	
	wire [15:0] temp;
	wire [15:0] saturated;
	
	//perform all alu operation, unsaturated arithmatic
	assign 	temp = (aluOp == `ALU_ADD) ? src0 + src1 :
					  			 (aluOp == `ALU_SUB) ? src0 - src1 :
								 (aluOp == `ALU_AND) ? src0 & src1 :
								 (aluOp == `ALU_NOR) ? ~(src0 | src1) :
								 (aluOp == `ALU_SLL) ? src0 << shAmt :
								 (aluOp == `ALU_SRL) ? src0 >> shAmt :
								 (aluOp == `ALU_SRA) ? $signed(src0 >>> shAmt) :	
								 (aluOp == `ALU_LHB) ? {src1[7:0], src0[7:0]} :
								 16'd0;
								 
	//set the zero flag if all bits are zero
  assign zr = ~|dst;
  
  //check for positive or negative overflow
  assign posOV = ~src0[15] & ~src1[15] & temp[15];
  assign negOV = src0[15] & src1[15] & ~temp[15];
  
  //set our overflow flag
  assign ov = ({posOV, negOV} == 2'b00) ? 1'b0 :        //no overflow
              ({posOV, negOV} == 2'b01) ? 1'b1 :        //neg overflow
              ({posOV, negOV} == 2'b10) ? 1'b1 :        //pos overflow
              1'b0; 
  
  //if we have overflow, saturate our values
  assign saturated = ({posOV, negOV} == 2'b00) ? temp :      //no overflow
                     ({posOV, negOV} == 2'b01) ? 16'h8000 :  //neg overflow
                     ({posOV, negOV} == 2'b10) ? 16'h7FFF :  //pos overflow
                     16'hFFFF;                               //shouldn't happen
      
  //if we did addition or subtraction, use the saturaed value
  assign dst = (aluOp == `ALU_ADD) ? saturated :
               (aluOp == `ALU_SUB) ? saturated :
               temp;
               
endmodule

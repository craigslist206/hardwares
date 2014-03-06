
module EX(dst, zr, p0, p1, shAmt, aluOp, imm, sel);
  input [15:0] p0, p1;
  input [7:0] imm;
  input [3:0] shAmt;
  input [2:0] aluOp;
  input sel;
  output [15:0] dst;
  output zr;
  
  wire [15:0] src0, src1;
  wire ov;
  
  SRC_MUX SRC_MUX(src1, p1, imm, sel);
  
  ALU ALU(dst, ov, zr, p0, src1, aluOp, shAmt);
  
  
  
endmodule

module cpu(hlt, clk, rst_n);
  input clk, rst_n;
  output hlt;
  
  //connections between the IF and ID stages
  wire [15:0] instr_IF_ID;
  
  //connections between the ID and EX stages
  wire [15:0] p0_IF_EX, p1_IF_EX;
  wire [3:0] shAmt_IF_EX;
  wire [2:0] aluOp_IF_EX;
  wire src1sel;
  
  //connections between the EX and MEM stages
  wire [15:0] dst_EX_MEM;
  wire zr_EX_MEM;
  
  //instruction fetch stage
  IF IF(.instr(instr_IF_ID), .hlt(hlt), .clk(clk), .rst_n(rst_n));
  
  //instruction decode stage
  ID ID(.p0(p0_IF_EX), .p1(p1_IF_EX), .shAmt(shAmt_IF_EX), .aluOp(aluOp_IF_EX), .src1sel(src1sel), .hlt(hlt), .instr(instr_IF_ID), .zr(zr_EX_MEM), .dst(dst_EX_MEM), .clk(clk));
  
  //execute stage
  EX EX(.dst(dst_EX_MEM), .zr(zr_EX_MEM), .p0(p0_IF_EX), .p1(p1_IF_EX), .shAmt(shAmt_IF_EX), .aluOp(aluOp_IF_EX), .imm(instr_IF_ID[7:0]), .sel(src1sel));
  
  //memory access stage
  /////////////////////////////////////not yet/////////////////////////////////////
  
  //write back stage
  /////////////////////////////////////not yet/////////////////////////////////////
endmodule
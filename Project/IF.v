
module IF(instr, pc, hlt, clk, rst_n);
  input hlt, clk, rst_n;
  output [15:0] instr, pc;
  
  //wire [15:0] pc;

  PC PC(pc, hlt, clk, rst_n);

  IM IM(clk, pc, 1'b1, instr);

  
  
endmodule


module MEM(PCSrc, readData, memRead, memWrite, sawBranch, branchOp, clk, writeData, address, N, Z, V);
  input [15:0] writeData;
  input sawBranch, memRead, memWrite, clk, N, Z, V;
  input [2:0] branchOp;
  output [15:0] readData;
  output PCSrc;
  inout [15:0] address;
  
  DM dataMem(.clk(clk),.addr(address),.re(memRead),.we(memWrite),.wrt_data(writeData),.rd_data(readData));
  
  branchLogic branchLogic(PCSrc, N, Z, V, takeBranch, branchOp);
  
  
endmodule
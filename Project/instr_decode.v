`include "defines.v"
/*******************************************************************************
* ECE 552
* WISC architecture
* Single cycle, non-branching implementation
* Instruction decoder
*
* Craig Day
*******************************************************************************/
module instr_dec(p0_addr, p1_addr, dst_addr, re0, re1, we, aluOp, shAmt, src1sel, hlt, instr, zr);
  input [15:0] instr;
  input zr;
  output [2:0] aluOp;
  output [3:0] shAmt;
  output src1sel, hlt;
  output [3:0] p0_addr, p1_addr, dst_addr;
  output re0, re1, we;
  
  wire [3:0] opCode, hbyte0, hbyte1, hbyte2;
  wire [7:0] imm;
  
  //break the instruction into useful parts
  assign opCode = instr[15:12];
  assign hbyte2 = instr[11:8];
  assign hbyte1 = instr[7:4];
  assign hbyte0 = instr[3:0];
  assign imm = instr[7:0];
  

  /////////////////////////////////////////////////////////////
  // determine the src1sel based on instruction
  // the src_mux should use the immediate from the instruction
  // on any shift, or llb and lhb
  /////////////////////////////////////////////////////////////
  assign src1sel = (opCode == `SLL) ? 1'b1 :
                   (opCode == `SRL) ? 1'b1 :
                   (opCode == `SRA) ? 1'b1 :
                   (opCode == `LHB) ? 1'b1 :
                   (opCode == `LLB) ? 1'b1 :
                   1'b0;
                   
  // set the hlt flag on hlt instruction
  assign hlt = (opCode == `HLT) ? 1'b1 : 1'b0;
  
  // set shAmt if we get a shift
  assign shAmt = (opCode == `SLL) ? hbyte0 :
                 (opCode == `SRL) ? hbyte0 :
                 (opCode == `SRA) ? hbyte0 :
                 4'b0000;
                 
  // send the ALU the right opCode
  assign aluOp = (opCode == `ADD) ? `ALU_ADD :
                 (opCode == `SUB) ? `ALU_SUB :
                 (opCode == `AND) ? `ALU_AND :
                 (opCode == `NOR) ? `ALU_NOR :
                 (opCode == `SLL) ? `ALU_SLL :
                 (opCode == `SRL) ? `ALU_SRL :
                 (opCode == `SRA) ? `ALU_SRA :
                 (opCode == `LHB) ? `ALU_LHB :
                 (opCode == `LLB) ? `ALU_ADD :
                 (opCode == `ADDZ && zr == 1'b1) ? `ALU_ADD :
                 3'b000;
  
  // set port0 read for the correct operations, all but shifts           
  assign re0 = (opCode == `HLT) ? 1'b0 : 1'b1;
 
  // set port1 read for correct operations, all accept byte loads
  assign re1 = (opCode == `SLL) ? 1'b0 :
               (opCode == `SRL) ? 1'b0 :
               (opCode == `SRA) ? 1'b0 :
               (opCode == `LLB) ? 1'b0 :
               (opCode == `HLT) ? 1'b0 :
               1'b1;
  
  // set write to register, always saving to register now unless halting
  assign we = (opCode == `HLT) ? 1'b0 : 1'b1;
  
  // will always want instr[7:4] on p0_addr whenever we set re0 to high,
  // unless performing LLB, which is done by Rd = R0 + imm
  assign p0_addr = (opCode == `LLB) ? 16'h0000 : hbyte1;
  
  // will always want instr[3:0] on p1_addr whenever we set re1 to high
  assign p1_addr = hbyte0;
  
  // will always write to register instr[11:8]
  assign dst_addr = hbyte2;
  
endmodule
  
//Define the opcodes used in our instruction decoder
`define ADD  4'b0000
`define ADDZ 4'b0001
`define SUB  4'b0010
`define AND  4'b0011
`define NOR  4'b0100
`define SLL  4'b0101
`define SRL  4'b0110
`define SRA  4'b0111
`define LW   4'b1000
`define SW   4'b1001
`define LHB  4'b1010
`define LLB  4'b1011
`define B    4'b1100
`define JAL  4'b1101
`define JR   4'b1110
`define HLT  4'b1111

//Define the codes sent the the alu
`define ALU_ADD 3'b000
`define ALU_SUB 3'b001
`define ALU_AND 3'b010
`define ALU_NOR 3'b011
`define ALU_SLL 3'b100
`define ALU_SRL 3'b101
`define ALU_SRA 3'b110
`define ALU_LHB 3'b111


/*******************************************************************************
* ECE 552
* WISC architecture
* Simple program counter with synchronous reset and increment by 1
*
* Craig Day
*******************************************************************************/
module PC(pc, hlt, clk, rst_n);
  input rst_n, hlt, clk;
  output reg [15:0] pc;
  wire temp;
  
  //at the posedge of clk, reset the pc if rst_n is low, otherwise
  //grab the next value from the hlt mux
  always @(posedge clk, negedge rst_n) begin
    if(~rst_n) begin
      pc <= 16'd0;
    end else begin
      if(hlt) pc <= pc;
      else pc <= pc + 1;
    end
  end
  
endmodule
  
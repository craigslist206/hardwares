module t_alu();
  wire [15:0] dst;
  wire ov, zr;
  
  reg [15:0] src0, src1;
  reg [3:0] ctrl, shamt;
  
  integer i;
  
  ALU DUT(dst, ov, zr, src0, src1, ctrl, shamt);
  
  initial begin
    //test 100 random additions
    ctrl = 4'b0000;
    for(i = 0; i < 100; i = i + 1) begin: add_loop
      src0 = $random();
      src1 = $random();
      #1;
      $display("Testing %d + %d", src0, src1);
      if({ov, dst} != (src0 + src1))
        $display("ERROR: %d + %d = %d, Expected: %d", src0, src1, {ov, dst}, (src0 + src1));
    end
    
    //test the zero flag by doing 0 + 0
    src0 = 16'd0;
    src1 = 16'd1;
    #1;
    if(zr != 0)
      $display("ERROR: Zero flag not properly set.");
      
    //test sll by 0 - 16 bits
    ctrl = 4'b0100;
    for(i = 0; i < 16; i = i + 1) begin: sll_loop
      src0 = 16'hABCD;
      shamt = i;
      #1;
      $display("Testing %d << %d", src0, i);
      if(dst != (16'hABCD << i))
        $display("ERROR: sll.  Received: %h, Expected: %h", dst, (16'hABCD << i));
        
    end
    
    
    $stop;
  end
  
endmodule
  
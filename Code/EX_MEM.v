module EX_MEM(Ex_Wreg, Ex_Reg2reg, Ex_Wmem, Ex_Alu_R, Ex_D2, Ex_Rd, en, clk, clr_n, Mem_Wreg, Mem_Reg2reg, Mem_Wmem, Mem_Alu_R, Mem_D2, Mem_Rd);
  input Ex_Wreg, Ex_Reg2reg, Ex_Wmem, en, clk, clr_n;
  input [4:0] Ex_Rd;
  input [31:0] Ex_Alu_R, Ex_D2;
  output reg Mem_Wreg, Mem_Reg2reg, Mem_Wmem;
  output reg [4:0] Mem_Rd;
  output reg [31:0]  Mem_Alu_R, Mem_D2;
  
  always@(posedge clk)begin
    if(~en)
      Mem_D2 <= Mem_D2;
    else if(~clr_n)
      Mem_D2 <= 32'd0;
    else
      Mem_D2 <= Ex_D2;
  end
  
  always@(posedge clk)begin
    if(~en)
      Mem_Alu_R <= Mem_Alu_R;
    else if(~clr_n)
      Mem_Alu_R <= 32'd0;
    else
      Mem_Alu_R <= Ex_Alu_R;
  end
  
  
  always@(posedge clk)begin
    if(~en)
      Mem_Rd <= Mem_Rd;
    else if(~clr_n)
      Mem_Rd <= 5'd0;
    else
      Mem_Rd <= Ex_Rd;
  end
  
  always@(posedge clk)begin
    if(~en)
      Mem_Wmem <= Mem_Wmem;
    else if(~clr_n)
      Mem_Wmem <= 1'd0;
    else
      Mem_Wmem <= Ex_Wmem;
  end
  
  always@(posedge clk)begin
    if(~en)
      Mem_Reg2reg <= Mem_Reg2reg;
    else if(~clr_n)
      Mem_Reg2reg <= 1'd0;
    else
      Mem_Reg2reg <= Ex_Reg2reg;
  end
  
  always@(posedge clk)begin
    if(~en)
      Mem_Wreg <= Mem_Wreg;
    else if(~clr_n)
      Mem_Wreg <= 1'd0;
    else
      Mem_Wreg <= Ex_Wreg;
  end
  
endmodule
  
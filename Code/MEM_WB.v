module MEM_WB(Mem_Wreg, Mem_Reg2reg, Mem_Alu_R, Mem_D, Mem_Rd, clk, en, clr_n, Wb_Wreg, Wb_Reg2reg, Wb_Alu_R, Wb_D, Wb_Rd);
  input Mem_Wreg, Mem_Reg2reg, clk, en, clr_n;
  input [4:0] Mem_Rd;
  input [31:0] Mem_Alu_R, Mem_D;
  output reg Wb_Wreg, Wb_Reg2reg;
  output reg [4:0] Wb_Rd;
  output reg [31:0] Wb_Alu_R, Wb_D;
  
  always@(posedge clk)begin
    if(~en)
      Wb_D <= Wb_D;
    else if(~clr_n)
      Wb_D <= 32'd0;
    else
      Wb_D <= Mem_D;
  end
  
  always@(posedge clk)begin
    if(~en)
      Wb_Alu_R <= Wb_Alu_R;
    else if(~clr_n)
      Wb_Alu_R <= 32'd0;
    else
      Wb_Alu_R <= Mem_Alu_R;
  end
  
  always@(posedge clk)begin
    if(~en)
      Wb_Rd <= Wb_Rd;
    else if(~clr_n)
      Wb_Rd <= 5'd0;
    else
      Wb_Rd <= Mem_Rd;
  end
  
  always@(posedge clk)begin
    if(~en)
      Wb_Reg2reg <= Wb_Reg2reg;
    else if(~clr_n)
      Wb_Reg2reg <= 1'd0;
    else
      Wb_Reg2reg <= Mem_Reg2reg;
  end
  
  always@(posedge clk)begin
    if(~en)
      Wb_Wreg <= Wb_Wreg;
    else if(~clr_n)
      Wb_Wreg <= 1'd0;
    else
      Wb_Wreg <= Mem_Wreg;
  end
endmodule
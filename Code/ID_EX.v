module ID_EX(Id_Pc_Add4, Wreg, Reg2reg, Wmem, Id_Op, Aluc, Aluqb, Id_Qa, Id_Qb, Id_Extimm, Id_Rd, en, clk, clr_n, Ex_Pc, Ex_Wreg, Ex_Reg2reg, Ex_Wmem, Ex_Op, Ex_Aluc, Ex_Aluqb, Ex_D1, Ex_D2, Ex_Extimm, Ex_Rd, Fwd_A, Fwd_B, Ex_Fwd_A, Ex_Fwd_B, stall, condition_met);
  
  input[31:0] Id_Qa, Id_Qb, Id_Extimm, Id_Pc_Add4;
  input[5:0] Id_Op;
  input[4:0] Id_Rd;
  input[2:0] Aluc;
  input [1:0] Fwd_A, Fwd_B;
  input Wreg, Reg2reg, Wmem, Aluqb, en, clk, clr_n, stall, condition_met;
  
  output reg [31:0] Ex_D1, Ex_D2, Ex_Extimm, Ex_Pc;
  output reg [5:0] Ex_Op;
  output reg [4:0] Ex_Rd;
  output reg [2:0] Ex_Aluc;
  output reg [1:0] Ex_Fwd_A, Ex_Fwd_B; 
  output reg Ex_Wreg, Ex_Reg2reg, Ex_Wmem, Ex_Aluqb;
  
    always@(posedge clk)begin
    if(~en)
      Ex_Pc <= Ex_Pc;
    else if(~clr_n || condition_met || stall)
      Ex_Pc <= 32'd0;
    else
      Ex_Pc <= Id_Pc_Add4 + {Id_Extimm << 2};
  end
  
  always@(posedge clk)begin
    if(~en)
      Ex_Aluqb <= Ex_Aluqb;
    else if(~clr_n || condition_met || stall)
      Ex_Aluqb <= 1'd0;
    else
      Ex_Aluqb <= Aluqb;
  end
  
  always@(posedge clk)begin
    if(~en)
      Ex_Wmem <= Ex_Wmem;
    else if(~clr_n || condition_met || stall)
      Ex_Wmem <= 1'd0;
    else
      Ex_Wmem <= Wmem;
  end
  
  always@(posedge clk)begin
    if(~en)
      Ex_Reg2reg <= Ex_Reg2reg;
    else if(~clr_n || condition_met || stall)
      Ex_Reg2reg <= 1'd0;
    else
      Ex_Reg2reg <= Reg2reg;
  end
  
  always@(posedge clk)begin
    if(~en)
      Ex_Wreg <= Ex_Wreg;
    else if(~clr_n || condition_met || stall)
      Ex_Wreg <= 1'd0;
    else
      Ex_Wreg <= Wreg;
  end
  
  always@(posedge clk)begin
    if(~en)
      Ex_Fwd_B <= Ex_Fwd_B;
    else if(~clr_n || condition_met || stall)
      Ex_Fwd_B <= 2'd0;
    else
      Ex_Fwd_B <= Fwd_B;
  end
  
  always@(posedge clk)begin
    if(~en)
      Ex_Fwd_A <= Ex_Fwd_A;
    else if(~clr_n || condition_met || stall)
      Ex_Fwd_A <= 2'd0;
    else
      Ex_Fwd_A <= Fwd_A;
  end
  
  always@(posedge clk)begin
    if(~en)
      Ex_Aluc <= Ex_Aluc;
    else if(~clr_n || condition_met || stall)
      Ex_Aluc <= 3'd0;
    else
      Ex_Aluc <= Aluc;
  end
  
  always@(posedge clk)begin
    if(~en)
      Ex_Rd <= Ex_Rd;
    else if(~clr_n || condition_met || stall)
      Ex_Rd <= 5'd0;
    else
      Ex_Rd <= Id_Rd;
  end
  
  always@(posedge clk)begin
    if(~en)
      Ex_Op <= Ex_Op;
    else if(~clr_n || condition_met || stall)
      Ex_Op <= 6'd0;
    else
      Ex_Op <= Id_Op;
  end
  

  
  always@(posedge clk)begin
    if(~en)
      Ex_Extimm <= Ex_Extimm;
    else if(~clr_n || condition_met || stall)
      Ex_Extimm <= 32'd0;
    else
      Ex_Extimm <= Id_Extimm;
  end
  
  always@(posedge clk)begin
    if(~en)
      Ex_D1 <= Ex_D1;
    else if(~clr_n || condition_met || stall)
      Ex_D1 <= 32'd0;
    else
      Ex_D1 <= Id_Qa;
  end
  
  always@(posedge clk)begin
    if(~en)
      Ex_D2 <= Ex_D2;
    else if(~clr_n || condition_met || stall)
      Ex_D2 <= 32'd0;
    else
      Ex_D2 <= Id_Qb;
  end
  
endmodule
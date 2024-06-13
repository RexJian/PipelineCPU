//module MUX4X32(Pcsrc, PC_Add4, Ext_addr, J_addr, Out_addr);
module MUX4X32(Pcsrc, PC_Add4, Branch_Add, Out_addr);
  input[1:0] Pcsrc;
  input[31:0] PC_Add4, Branch_Add;
  output reg [31:0] Out_addr;
  
  always @(*)begin
    case(Pcsrc)
      2'd0: Out_addr = PC_Add4;
      2'd2: Out_addr = Branch_Add;
      //2'd2: Out_addr = PC_Add4 + {Ext_addr << 2};
      //2'd3: Out_addr = J_addr;
    endcase
  end
  
endmodule
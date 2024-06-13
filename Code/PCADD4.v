module PCADD4(PC, PC_Add4);

  input [31:0] PC;
  output [31:0] PC_Add4;
  assign PC_Add4 = PC + 32'd4;
endmodule
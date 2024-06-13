module SHIFTER_COMBINATION(X, PCADD4, J_addr);

  input [25:0] X;
  input [31:0] PCADD4;
  output [31:0] J_addr;
  assign J_addr = {PCADD4[31:28], X, 2'd0};
endmodule
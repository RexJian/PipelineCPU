module MUX2X32(Sel, X1, X0 , Y);
  input Sel;
  input [31:0] X1, X0;
  output [31:0] Y;
  assign Y = (Sel == 1'b1) ? X1 : X0;
endmodule
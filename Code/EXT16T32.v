module EXT16T32(X, Se, Y);

  input [15:0] X;
  input Se;
  output [31:0] Y;
  assign Y = (Se == 1'b1) ? {{15{X[15]}}, X} : {{15{1'b0}},X};
endmodule
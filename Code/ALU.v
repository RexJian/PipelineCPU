module ALU(Aluc, X, Y, Z, R);

  input [2:0] Aluc;
  input [31:0] X,Y;
  output Z;
  output [31:0] R;
  assign Z = (X == Y) ? 1'b1 : 1'b0;
  assign R = (Aluc == 3'd0) ? X+Y : ((Aluc == 3'd1) ? X-Y : (Aluc == 3'd2) ? X&Y : (Aluc == 3'd3) ? X|Y : (X < Y) ? 32'd1 : 32'd0);
  
endmodule
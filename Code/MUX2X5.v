module MUX2X5(instruction, reg_dst, rd);
  input [31:0] instruction;
  input reg_dst;
  output [4:0]rd;
  assign rd = reg_dst ? instruction[20:16]:instruction[15:11];
endmodule
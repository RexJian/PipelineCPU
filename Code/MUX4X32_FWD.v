module MUX4X32_FWD(Ex_D, Mem_Alu_R, Write_D, Fwd, Alu_In);
  input [1:0] Fwd;
  input [31:0] Ex_D, Mem_Alu_R, Write_D;
  output [31:0] Alu_In;
  // 00: No Hazard
  // 01: Hazard in MEM stage
  // 10: Hazard in EXE stage
  assign Alu_In = Fwd == 2'b10 ? Mem_Alu_R : (Fwd == 2'b01 ? Write_D : Ex_D); 
endmodule
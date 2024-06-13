module CONUNIT(op, func, Z, Rs, Rt, Ex_Op, Ex_Rd, Mem_Rd, Ex_Wreg, Mem_Wreg, Ex_Reg2reg, Regrt, Se, Wreg, Aluqb, Aluc, Wmem, Pcsrc, Reg2reg, Fwd_A, Fwd_B, stall, condition_met);
  
  input[5:0] op, func, Ex_Op;
  input Z, Ex_Wreg, Mem_Wreg, Ex_Reg2reg;
  input[4:0] Rs, Rt, Ex_Rd, Mem_Rd;
  output Regrt, Se, Wreg, Aluqb, Wmem, Reg2reg, stall, condition_met;
  output [1:0] Pcsrc;
  output [2:0] Aluc;
  output [1:0] Fwd_A, Fwd_B;
  wire [5:0] R_TYPE, ADDI, ANDI, ORI, LW, SW, BEQ, BNE, J, AND, OR, ADD, SLT;
  
  assign R_TYPE = 6'd0;
  assign ADDI = 6'd8;
  assign ANDI = 6'd12;
  assign ORI = 6'd13;
  assign LW =  6'd35;
  assign SW = 6'd43;
  assign BEQ = 6'd4;
  assign BNE = 6'd5;
  assign J = 6'd2;
  assign AND = 6'd36;
  assign OR = 6'd37;
  assign ADD = 6'd32;
  assign SLT = 6'd42;
  
  
  assign Regrt = (op == R_TYPE) ? 1'b0 : 1'b1;
  
  assign Se = (op == R_TYPE || op == J) ? 1'b0 : 1'b1;
  
  assign Wreg = (op == SW || op == BEQ || op == BNE || op == J) ? 1'b0 : 1'b1;
  
  assign Aluqb = (op == ADDI || op == ORI || op == ANDI || op == LW || op == SW) ? 1'b0 :1'b1;
  assign Aluc = ((op == R_TYPE && func == AND)|| op == ANDI) ? 3'd2 : (((op == R_TYPE && func == OR) || op == ORI) ? 3'd3 : ((op == R_TYPE && func == ADD) || op == ADDI || op == SW || op == LW) ? 3'd0 : (op == R_TYPE && func == SLT) ? 3'd4 : 3'd1);
  
  assign Wmem = (op == SW) ? 1'b1 : 1'b0;
  
  assign Pcsrc = (op == J) ? 2'd3 : (((Ex_Op == BEQ && Z == 1'b1) || (Ex_Op == BNE && Z == 1'b0))? 2'd2 : 2'd0);
  
  assign Reg2reg = (op == LW) ? 1'd0 : 1'd1;
  
  
  // 00: No Hazard
  // 01: Hazard in MEM stage
  // 10: Hazard in EXE stage
  assign Fwd_A = (Rs==Ex_Rd && Ex_Wreg && Ex_Rd!=5'd0) ? 2'b10 : ((Rs==Mem_Rd && Mem_Wreg && Mem_Rd != 5'd0) ? 2'b01 : 2'b00);
  assign Fwd_B = (Rt==Ex_Rd && Ex_Wreg && Ex_Rd!=5'd0) ? 2'b10 : ((Rt==Mem_Rd && Mem_Wreg && Mem_Rd != 5'd0) ? 2'b01 : 2'b00);
  
  assign stall = (Rs == Ex_Rd || Rt == Ex_Rd) && ~Ex_Reg2reg && Ex_Rd != 5'd0;
  assign condition_met = (Ex_Op == BEQ && Z) || (Ex_Op == BNE && ~Z); 
  
  
endmodule
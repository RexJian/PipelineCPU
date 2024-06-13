`include "PC.v"
`include "INST_MEM.v"
`include "MUX2X5.v"
`include "REG_FILE.v"
`include "CONUNIT.v"
`include "EXT16T32.v"
`include "MUX2X32.v"
`include "ALU.v"
`include "DATAMEM.v"
`include "SHIFTER_COMBINATION.v"
`include "PCADD4.v"
`include "MUX4X32.v"
`include "IF_ID.v"
`include "ID_EX.v"
`include "EX_MEM.v"
`include "MEM_WB.v"
`include "MUX4X32_FWD.v"

module main(CLK, EN, CLR_N, Addr, Alu_D1, Y, Ex_Alu_R, Write_D, stall, condition_met, Rs, Rt, Rd);
  
  input CLK, EN, CLR_N;
  output reg [31:0]  Addr;
  output [31:0] Alu_D1, Y, Ex_Alu_R, Write_D;
  output [4:0] Rs, Rt, Rd;
  output stall, condition_met;
  
  wire [31:0] Pc_Add4, extention_addr, J_addr, Y, Dout, Alu_D1, Alu_D2, Ex_Pc, Ex_Alu_R, Id_Pc_Add4, Id_Inst, Id_Extimm, Id_Qa, Id_Qb, Ex_D1, Ex_D2, Ex_Extimm, Mem_Alu_R, Mem_D2, Wb_D, Wb_Alu_R,  Instruction, Next_Addr;
  
  wire [5:0] Ex_Op;
  wire [4:0] Ex_Rd, Mem_Rd, Id_Rd, Wb_Rd;
  wire Ex_Z, Regrt, Se, Wreg, Aluqb, Reg2reg, Cout, Wmem, Ex_Wreg, Ex_Reg2reg, Ex_Wmem, Ex_Aluqb, Mem_Wreg, Mem_Reg2reg,  Wb_Wreg, Wb_Reg2reg;
  wire [1:0] Pc_Src, Fwd_A, Fwd_B, Ex_Fwd_A, Ex_Fwd_B;
  wire [2:0] Aluc, Ex_Aluc;
  
  ///////////////////////////////////////////// IF//////////////////////////////////////////
  MUX4X32 mux4x_32(.Pcsrc(Pc_Src), .PC_Add4(Pc_Add4), .Branch_Add(Ex_Pc), .Out_addr(Next_Addr));
  
  PC pc(.clk(CLK), .en(EN), .clr_n(CLR_N), .next_addr(Next_Addr), .stall(stall), .addr(Addr));
  PCADD4 pc_add4(.PC(Addr), .PC_Add4(Pc_Add4));
  INST_MEM instuction_mem(.addr(Addr), .instruction(Instruction));
  
  IF_ID if_id(.IF_pc_add4(Pc_Add4), .IF_inst(Instruction), .clk(CLK), .en(EN), .clr_n(CLR_N), .stall(stall), .condition_met(condition_met), .ID_pc_add4(Id_Pc_Add4), .ID_inst(Id_Inst));
  
  //////////////////////////////////////////// ID////////////////////////////////////////////
  CONUNIT control_unit(.op(Id_Inst[31:26]), .func(Id_Inst[5:0]), .Z(Ex_Z), .Rs(Id_Inst[25:21]), .Rt(Id_Inst[20:16]), .Ex_Op(Ex_Op), .Ex_Rd(Ex_Rd), .Mem_Rd(Mem_Rd), .Ex_Wreg(Ex_Wreg), .Mem_Wreg(Mem_Wreg), .Ex_Reg2reg(Ex_Reg2reg), .Regrt(Regrt), .Se(Se), .Wreg(Wreg), .Aluqb(Aluqb), .Aluc(Aluc), .Wmem(Wmem), .Pcsrc(Pc_Src), .Reg2reg(Reg2reg), .Fwd_A(Fwd_A), .Fwd_B(Fwd_B), .stall(stall), .condition_met(condition_met));
  
  MUX2X5 mux2x5(.instruction(Id_Inst), .reg_dst(Regrt), .rd(Id_Rd));
  
  EXT16T32 ex16t32(.X(Id_Inst[15:0]), .Se(Se), .Y(Id_Extimm));
  
  REG_FILE reg_file(.clk(CLK), .clr_n(CLR_N), .reg_write(Wb_Wreg), .rs(Id_Inst[25:21]), .rt(Id_Inst[20:16]), .rd(Wb_Rd), .write_data(Write_D), .read_data1(Id_Qa), .read_data2(Id_Qb));
  
  
  ID_EX id_ex(.Id_Pc_Add4(Id_Pc_Add4), .Wreg(Wreg), .Reg2reg(Reg2reg), .Wmem(Wmem), .Id_Op(Id_Inst[31:26]), .Aluc(Aluc), .Aluqb(Aluqb), .Id_Qa(Id_Qa), .Id_Qb(Id_Qb), .Id_Extimm(Id_Extimm), .Id_Rd(Id_Rd), .en(EN), .clk(CLK), .clr_n(CLR_N), .Ex_Pc(Ex_Pc), .Ex_Wreg(Ex_Wreg), .Ex_Reg2reg(Ex_Reg2reg), .Ex_Wmem(Ex_Wmem), .Ex_Op(Ex_Op), .Ex_Aluc(Ex_Aluc), .Ex_Aluqb(Ex_Aluqb),  .Ex_D1(Ex_D1), .Ex_D2(Ex_D2), .Ex_Extimm(Ex_Extimm), .Ex_Rd(Ex_Rd), .Fwd_A(Fwd_A), .Fwd_B(Fwd_B), .Ex_Fwd_A(Ex_Fwd_A),  .Ex_Fwd_B(Ex_Fwd_B), .stall(stall), .condition_met(condition_met));
  

  
  /////////////////////////////////////////EXE/////////////////////////////////////////////////
  MUX4X32_FWD mux4x32_fwd_d1(.Ex_D(Ex_D1), .Mem_Alu_R(Mem_Alu_R), .Write_D(Write_D), .Fwd(Ex_Fwd_A), .Alu_In(Alu_D1));
  
  MUX4X32_FWD mux4x32_fwd_d2(.Ex_D(Ex_D2), .Mem_Alu_R(Mem_Alu_R), .Write_D(Write_D), .Fwd(Ex_Fwd_B), .Alu_In(Alu_D2));
  
  MUX2X32 sel_alu_input(.Sel(Ex_Aluqb), .X1(Alu_D2), .X0(Ex_Extimm) , .Y(Y));
  ALU alu(.Aluc(Ex_Aluc), .X(Alu_D1), .Y(Y), .Z(Ex_Z), .R(Ex_Alu_R));
  
  EX_MEM ex_mem(.Ex_Wreg(Ex_Wreg), .Ex_Reg2reg(Ex_Reg2reg), .Ex_Wmem(Ex_Wmem), .Ex_Alu_R(Ex_Alu_R), .Ex_D2(Ex_D2), .Ex_Rd(Ex_Rd), .en(EN), .clk(CLK), .clr_n(CLR_N), .Mem_Wreg(Mem_Wreg), .Mem_Reg2reg(Mem_Reg2reg), .Mem_Wmem(Mem_Wmem), .Mem_Alu_R(Mem_Alu_R), .Mem_D2(Mem_D2), .Mem_Rd(Mem_Rd));
  
  /////////////////////////////////////////MEM////////////////////////////////////////////////////
  DATAMEM data_mem(.clk(CLK), .clr_n(CLR_N), .Mem_Alu_R(Mem_Alu_R), .Mem_D2(Mem_D2), .Mem_Wmem(Mem_Wmem), .Dout(Dout));
  
  MEM_WB mem_wb(.Mem_Wreg(Mem_Wreg), .Mem_Reg2reg(Mem_Reg2reg), .Mem_Alu_R(Mem_Alu_R), .Mem_D(Dout), .Mem_Rd(Mem_Rd), .clk(CLK), .en(EN), .clr_n(CLR_N), .Wb_Wreg(Wb_Wreg), .Wb_Reg2reg(Wb_Reg2reg), .Wb_Alu_R(Wb_Alu_R), .Wb_D(Wb_D), .Wb_Rd(Wb_Rd));

  ///////////////////////////////////////////WB//////////////////////////////////////////////////
  MUX2X32 sel_write_data(.Sel(Wb_Reg2reg), .X1(Wb_Alu_R), .X0(Wb_D) , .Y(Write_D));
  
  
  assign Rs = Id_Inst[25:21];
  assign Rt = Id_Inst[20:16];
  assign Rd = Wb_Rd;

endmodule


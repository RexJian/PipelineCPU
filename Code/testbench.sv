
module test_cpu();
	
  reg en, clr_n;
  reg clk;
  reg [31:0] addr, instruction;
  wire [31:0] alu_d1, y, ex_alu_r, write_d;
  wire [4:0] rs, rt, rd;
  wire  stall, condition_met;
  
  main cpu1(.CLK(clk), .EN(en), .CLR_N(clr_n), .Addr(addr), .Alu_D1(alu_d1), .Y(y), .Ex_Alu_R(ex_alu_r), .Write_D(write_d), .stall(stall), .condition_met(condition_met), .Rs(rs), .Rt(rt), .Rd(rd));
	
	initial begin
      $dumpfile("dump.vcd"); 
      $dumpvars;
	end
  
    initial begin
	    clk = 0; clr_n = 0; en = 1;
        #10
        clk = 1; 
        #10
        clk = 0; clr_n = 1;
        //#1200 $finish;
        //forever #20 clk = ~clk;
        #1200 $finish;
    end
	
  always #10 clk = ~clk;
	
//   always @(posedge clk) begin
//     if(addr == 32'd76)
//       $finish;
//   end
endmodule
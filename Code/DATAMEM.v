module DATAMEM(clk, clr_n, Mem_Alu_R, Mem_D2, Mem_Wmem, Dout);
  input clk, clr_n;
  input [31:0] Mem_Alu_R, Mem_D2;
  input Mem_Wmem;
  output [31:0] Dout;
  reg [31:0] ROM [0:31];
  wire [4:0] rom_addr;
  integer i;
  assign Dout = ROM[Mem_Alu_R[6:2]];
  assign rom_addr = Mem_Alu_R[6:2];
  
  always @(posedge clk) begin
    if(~clr_n) begin
      for(i=0; i<32 ; i++)
        ROM[i] <= 32'd0;
    end
    else if(Mem_Wmem)
      ROM[Mem_Alu_R[6:2]] <= Mem_D2;
  end
endmodule
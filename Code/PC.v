module PC(clk, en, clr_n, next_addr, stall, addr);
  input clk, en, clr_n, stall;
  input [31:0]next_addr;
  output reg [31:0]addr;
  
  always @(posedge clk) begin
    if(~clr_n)
      addr <= 32'd0;
    else if(~en || stall)
      addr <= addr;
    else
      addr <= next_addr;
  end
endmodule
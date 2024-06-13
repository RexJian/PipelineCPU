module REG_FILE(clk, clr_n, reg_write, rs, rt, rd, write_data, read_data1, read_data2);
  input clk, clr_n;
  input [4:0]rs, rt, rd;
  input [31:0] write_data;
  input reg_write;
  output [31:0]read_data1;
  output [31:0]read_data2;
  reg [31:0]register[0:31];
  wire  test_var;
  integer i;
 
  assign read_data1 = (rd == rs && rd != 5'd0) ? write_data : register[rs];
  assign read_data2 = (rd == rt && rd != 5'd0) ? write_data : register[rt];
  
  always @(posedge clk) begin
    if(~clr_n)
      for(i = 0 ; i < 32 ; i = i +1)
        register[i] <= 32'd0;
    else if(reg_write)
      register[rd] <= write_data;
  end
  
endmodule
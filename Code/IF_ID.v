module IF_ID(IF_pc_add4, IF_inst, clk, en, clr_n, stall, condition_met, ID_pc_add4, ID_inst);
  
  input [31:0] IF_pc_add4, IF_inst;
  input clk, en, clr_n, stall, condition_met;
  output reg [31:0] ID_pc_add4, ID_inst;
  
  always@(posedge clk) begin
    if(~en || stall)
      ID_pc_add4 <= ID_pc_add4;
    else if(~clr_n || condition_met)
      ID_pc_add4 <= 32'd0;
	else
      ID_pc_add4 <= IF_pc_add4;
  end
  
  always@(posedge clk) begin
    if(~en || stall)
      ID_inst <= ID_inst;
    else if(~clr_n || condition_met)
      ID_inst <= 32'd0;
	else
      ID_inst <= IF_inst;
  end
  
endmodule
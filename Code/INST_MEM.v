module INST_MEM(addr, instruction);
  input [31:0]addr;
  output reg [31:0] instruction;
  always @(*) begin
    case(addr)
      32'd0: instruction = 32'h20020005;
      32'd4: instruction = 32'h2003000c;
      32'd8: instruction = 32'h20070003;
      32'd12: instruction = 32'h00e22025;
      32'd16: instruction = 32'h00642824;
      32'd20: instruction = 32'h00a42820;
      32'd24: instruction = 32'h10a7000a;
      32'd28: instruction = 32'h0064202a;
      32'd32: instruction = 32'h10800001;
      32'd36: instruction = 32'h20050000;
      32'd40: instruction = 32'h00e2202a;
      32'd44: instruction = 32'h00853820;
      32'd48: instruction = 32'h00e23822;
      32'd52: instruction = 32'hac670044;
      32'd56: instruction = 32'h8c020050;
      //32'd60: instruction = 32'h08000011;
      32'd60: instruction = 32'h20020001;
      32'd64: instruction = 32'hac020054;
  endcase
  end
endmodule
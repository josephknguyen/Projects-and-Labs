module SignExtender(BusImm, Imm25, Ctrl); 
   output reg [63:0] BusImm; 
   input [25:0]  Imm25; 
   input [2:0]	Ctrl; 
   
   wire [63:0] temp;
   reg 	 extBit; 
   
   assign temp = {{45{extBit}}, Imm25[20:5]};
   
   always @(*) begin
      // I-type
      if (Ctrl == 3'b000) begin
         extBit = 1'b0; 
         BusImm = {{52{extBit}}, Imm25[21:10]};
         end
      // D-type
      else if (Ctrl == 3'b001) begin
         extBit = Imm25[20]; 
         BusImm = {{55{extBit}}, Imm25[20:12]};
         end 
      // B-type
      else if (Ctrl == 3'b010) begin
         extBit = Imm25[25]; 
         BusImm = {{38{extBit}}, Imm25}; 
         end
      // CB-type
      else if (Ctrl == 3'b011) begin
         extBit = Imm25[23]; 
         BusImm = {{45{extBit}}, Imm25[23:5]};
         end
      // R-type
      else if (Ctrl == 3'b100) begin
         extBit = 1'b0; 
         BusImm = {{58{extBit}}, Imm25[15:10]};
         end
      // IW-type
      else if (Ctrl == 3'b101) begin
         extBit = 1'b0; 
         BusImm = {temp << (Imm25[22:21] * 16)};
         $display("SignExt:%h=>%1b::::%b",Imm25[20:5],BusImm,Imm25[22:21]);
         
         end
      end
         
endmodule

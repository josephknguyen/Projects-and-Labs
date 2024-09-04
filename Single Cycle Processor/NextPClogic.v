

module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
   input wire [63:0] CurrentPC, SignExtImm64; 
   input wire	Branch, ALUZero, Uncondbranch; 
   output reg [63:0] NextPC; 

   always @(CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch)
      begin
         if (Uncondbranch) begin
            // Unconditional branch instruction, NextPC is CurrentPc + SignExtImm 
            NextPC <= CurrentPC + (SignExtImm64 << 2);
         end else if (Branch) begin
            // Conditonal branch instruction
            if (ALUZero) begin
               // Branch is taken (ALUZero is true), NextPc is CurrentPC + SignExt
               NextPC <= CurrentPC + (SignExtImm64 << 2);
            end else begin
               // Branch is not taken, continue to next instruction
               NextPC <= CurrentPC + 64'h4;
            end
         end else begin
            // Non-branch instructon, increment PC by 4 bytes
            NextPC <= CurrentPC + 64'h4;
            
         end
      end


endmodule

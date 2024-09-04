module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input wire [63:0] BusW;
    input wire [4:0] RA;
    input wire [4:0] RB;
    input wire [4:0] RW;
    input wire RegWr;
    input wire Clk;
    reg [63:0] registers [31:0];
    
    always @ (negedge Clk) begin
        if(RegWr)
            registers[RW] <= #3 (RW == 5'b11111) ? 64'h0000 : BusW; 
            $display("register:%d==%1h",RW,BusW);
    end
    
    //Delay or 2 ticks before reading from regs 
	assign #2 BusA = (RA == 5'b11111) ? 64'h0000 : registers[RA];
	assign #2 BusB = (RB == 5'b11111) ? 64'h0000 : registers[RB];
    
endmodule

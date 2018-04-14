/*
module splitmix(out,clk);
   input clk;
//modified Splitmix64 for 32 bits

   output [31:0] out ;

   wire [63:0]out_64 ;
 
   reg [63:0] 	 z=0 ;

   always@(posedge clk) begin
   
      z= z+ 64'h9e3779b97f4a7c15 ;
      z = (z ^ (z >> 30)) * 64'hbf58476d1ce4e5b9;
	z = (z ^ (z >> 27)) * 64'h94d049bb133111eb;
   end

   assign out_64 = z^(z>>31);
   assign out=out_64[63:32] ;
endmodule // splitmix*/
module defB(reset,clk,addrbB,doutbB,wrB_done);


 parameter N=2,P=4,M=3;
//My BramB
reg [31:0]MEM_B[0:255] ;
   input clk ;
reg  enaB=1,enbB=1,weaB=1 ;

wire clkaB, clkbB;
reg [7:0]addraB=0;
input [7:0]addrbB=0;
reg [31:0] dinaB=0;
output reg [31:0] doutbB=0;
output reg wrB_done=0 ; 
input  reset ;

assign  clkbB=clk, clkaB=clk ;

always@(posedge clkaB&weaB&enaB&(~reset)) begin
MEM_B[addraB] <= dinaB ;
end

always@(posedge clkbB&enbB&(~reset)) begin
doutbB <= MEM_B[addrbB] ;
end
 // MY bram B end
/*       
//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
//blk_mem_gen_A MemB (
 // .clka(clkaB),    // input wire clka
  //.ena(enaB),      // input wire ena
  //.wea(weaB),      // input wire [0 : 0] wea
  //.addra(addraB),  // input wire [7 : 0] addra
  //.dina(dinaB),    // input wire [31 : 0] dina
  //.clkb(clkbB),    // input wire clkb
  //.enb(enbB),      // input wire enb
  //.addrb(addrbB),  // input wire [7 : 0] addrb
  //.doutb(doutbB)  // output wire [31 : 0] doutb
//);
// INST_TAG_END ------ End INSTANTIATION Template ---------
*/
//---------writing data in 2nd matrix



always@(posedge clkaB&weaB&(~reset)) begin
   if(addraB<= P*M) begin
      case(addraB+1) 
	0 : dinaB=0;
	1 : dinaB=10;
	2 : dinaB=20;
	3 : dinaB=30;
	4 : dinaB=40;
	5 : dinaB=50;
	6 : dinaB=60;
	7 : dinaB=70;
	8 : dinaB=80;
	9 : dinaB=90;
	10 : dinaB=100;
	11 : dinaB=110;
	12 : dinaB=120;
	default : dinaB=0;
      endcase // case (addraB)
      addraB =addraB+ 1 ;
      
   end // if (addraB< P*M)
   else if(addraB > P*M) begin
        wrB_done=1 ;  
        end
     
   else
     addraB=0;
end // always@ (posedge clkaB&weaB)

endmodule
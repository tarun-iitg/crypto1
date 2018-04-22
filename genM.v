

module defB(ran,reset,clk,addrbB,doutbB,wrB_done);

input [31:0]ran ;


 parameter N=2,P=4,M=3;
 parameter col=1 ;
 reg  [31:0]col_m0=1,col_m1=2,col_m2=3,col_m3=4;
 //reg [31:0]col_m[3:0];
  
 
 
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

splitmix s1(ran,clk);

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
      default dinaB<=ran ;
      P*col+1 : dinaB <= col_m0;
      P*col+2 : dinaB <= col_m1;
      P*col+3 : dinaB <= col_m2;
      P*col+4 : dinaB <= col_m3;
      P*(M-1)+1 : dinaB <= 1 ;
      P*(M-1)+2 : dinaB <= 1 ;
      P*(M-1)+3 : dinaB <= 1 ;
      P*(M-1)+4 : dinaB <= 1 ;
      P*M+1     : dinaB <=0 ;
      
	/*0 : dinaB=0;
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
	default : dinaB=0;*/
	
      endcase // case (addraB)
      addraB =addraB+ 1 ;
      
   end // if (addraB< P*M)
   else if(addraB > P*M) begin
        wrB_done=1 ;  
        end
     
   else
     addraB=0;
end // always@ (posedge clkaB&weaB)





// ---------------------------Resetting system---   
   always@(posedge clk) begin 
    if(reset==1) begin
    addraB=0;
//    addrbB=1;  input of this module, need to be resetted in main module
      dinaB=0;
    
    wrB_done=0;
    
    doutbB=0;
    
        
    
   /* MEM_A[0]=0;
    MEM_A[1]=0;
        MEM_A[2]=0;
        MEM_A[3]=0;
            MEM_A[4]=0;
            MEM_A[5]=0;
                MEM_A[6]=0;
                MEM_A[7]=0;
                    MEM_A[8]=0;
                    MEM_A[9]=0;
                        MEM_A[10]=0;
                */                
    end
   end
 
endmodule
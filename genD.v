`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2018 08:29:09 PM
// Design Name: 
// Module Name: defD
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module defD(reset,clk,addrbD,doutbD,wrD_done);


 parameter N=2,P=4,M=3,R=5;

   input clk ;
reg  enaD=1,enbD=1,weaD=1 ;

wire clkaD, clkbD;
reg [7:0]addraD=0;
input [7:0]addrbD=0;
reg [31:0] dinaD=0;
output reg [31:0] doutbD=0;
output reg wrD_done=0 ; 
input  reset ;
    
    
    
        
   assign  clkaD=clk,clkbD=clk ;
    
//My BramD
reg [31:0]MEM_D[0:255] ;

always@(posedge clkaD&weaD&enaD&(~reset)) begin
MEM_D[addraD] <= dinaD ;
end

always@(posedge clkbD&enbD&(~reset)) begin
doutbD <= MEM_D[addrbD] ;
end
 // MY bram D end
    
 
// vaule input in D
always@(posedge clkaD&weaD&(~reset)) begin
   if(addraD<= M*R) begin
    
      addraD <= addraD +1 ;
      
   end // if (addraD< M*R)
   else if(addraD > M*R) 
     wrD_done <= 1 ;
   else
     addraD <= 0;
end // always@ (posedge clka&weaA)

always@(addraD) begin
  case(addraD)
  0 : dinaD=0;
  1 : dinaD=15;
  2 : dinaD=25;
  3 : dinaD=35;
  4 : dinaD=45;
  5 : dinaD=55;
  6 : dinaD=65;
  7 : dinaD=75;
  8 : dinaD=85;
  9 : dinaD=95;
    10 : dinaD=105;
    11 : dinaD=115;
    12 : dinaD=125;
    13 : dinaD=135;
    14 : dinaD=145;
    15 : dinaD=155;
    16 : dinaD=165;
  default : dinaD=0;
    endcase // case (addraA)
end

// ---------------------------Resetting system---   
   always@(posedge clk) begin 
    if(reset==1) begin
    addraD=0;
//    addrbD=1;  input of this module, need to be resetted in main module
      dinaD=0;
    
    wrD_done=0;
    
    doutbD=0;
    
        
    
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

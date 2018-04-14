`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2018 08:29:09 PM
// Design Name: 
// Module Name: defA
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


module defA(reset,clk,addrbA,doutbA,wrA_done);
 
     parameter N=2,P=4,M=3;
      input clk ;
   reg  enaA=1,enbA=1,weaA=1 ;
   
   wire clkaA, clkbA;
   reg [7:0]addraA=0;
   input [7:0]addrbA=0;
   reg [31:0] dinaA=0;
   output reg [31:0] doutbA=0;
   output reg wrA_done=0 ; 
   input  reset ;
   
   assign  clkbA=clk, clkaA=clk ;

    
    //My BramA
    reg [31:0]MEM_A[0:255] ;
    
    always@(posedge clkaA&weaA&enaA&(~reset)) begin
    MEM_A[addraA] <= dinaA ;
    end
    
    always@(posedge clkbA&enbA&(~reset)) begin
    doutbA <= MEM_A[addrbA] ;
    end
     // MY bram A end
        
     /*   
    //----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
    //blk_mem_gen_A MemA (
     // .clka(clkaA),    // input wire clka
      //.ena(enaA),      // input wire ena
      //.wea(weaA),      // input wire [0 : 0] wea
      //.addra(addraA),  // input wire [7 : 0] addra
      //.dina(dinaA),    // input wire [31 : 0] dina
      //.clkb(clkbA),    // input wire clkb
      //.enb(enbA),      // input wire enb
      //.addrb(addrbA),  // input wire [7 : 0] addrb
      //.doutb(doutbA)  // output wire [31 : 0] doutb
    //);
    // INST_TAG_END ------ End INSTANTIATION Template ---------
    */
    
    always@(posedge clkaA&weaA&(~reset)) begin
       if(addraA<= N*P) begin
        
          addraA <= addraA +1 ;
          
       end // if (addraA< N*P)
       else if(addraA > N*P) 
         wrA_done <= 1 ;
       else
         addraA <= 0;
    end // always@ (posedge clka&weaA)
    
    always@(addraA) begin
      case(addraA)
      0 : dinaA=0;
      1 : dinaA=1;
      2 : dinaA=2;
      3 : dinaA=3;
      4 : dinaA=4;
      5 : dinaA=5;
      6 : dinaA=6;
      7 : dinaA=7;
      8 : dinaA=8;
      
      default : dinaA=0;
        endcase // case (addraA)
    end

endmodule

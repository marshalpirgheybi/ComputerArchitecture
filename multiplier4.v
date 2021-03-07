`timescale 1ns/1ns 
module multiplier4 #(parameter nb = 8 )
(
//-----------------------Port directions and deceleration
   input clk,  
   input start,
   input [nb-1:0] A, 
   input [nb-1:0] B, 
   output reg [2*nb-1:0] Product,
   output ready
    );



//------------------------------------------------------

//----------------------------------- register deceleration
reg [nb-1:0] Multiplicand ;
reg [nb-1:0] counter;
//-------------------------------------------------------

//------------------------------------- wire deceleration
wire product_write_enable;
wire [nb:0] adder_output;
wire [nb-1:0] constantone;
wire [nb-1:0] constantzero;
wire [nb-1:0] allone;
//---------------------------------------------------------

//-------------------------------------- combinational logic
				//checking whether that it's the last partial-product or not
				//using sign extension to make sure that overflow will not happen
assign constantzero=0;
assign allone={nb{1'b1}};
assign adder_output = (counter <= 1)? {Product[2*nb-1],Product[2*nb-1:nb]} - {Multiplicand[nb-1],Multiplicand} : {Multiplicand[nb-1],Multiplicand} + {Product[2*nb-1],Product[2*nb-1:nb]} ;
assign product_write_enable = Product[0];
assign ready = counter ==0;
//---------------------------------------------------------
//--------------------------------------- sequential Logic
always @ (posedge clk)

   if(start) begin
      counter <= allone ;
      Product <= {constantzero,B};
      Multiplicand <= A;
   end

   else if(! ready) begin
         counter <= counter >>1;
         //using signed shift to make sure that sign extension is properly executed
         Product <= {Product[2*nb-1],Product[2*nb-1:1]};
			if(product_write_enable)begin
				Product <= {adder_output[nb:0],Product[nb-1:1]};
			end
   end   
endmodule
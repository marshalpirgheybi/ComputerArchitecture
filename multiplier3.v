`timescale 1ns/1ns
module multiplier3(
//-----------------------Port directions and deceleration
   input clk,  
   input start,
   input [7:0] A, 
   input [7:0] B, 
   output reg [15:0] Product,
   output ready
    );



//------------------------------------------------------

//----------------------------------- register deceleration
reg [7:0] Multiplicand ;
reg [3:0]  counter;
//-------------------------------------------------------

//------------------------------------- wire deceleration
wire product_write_enable;
wire [8:0] adder_output;
//---------------------------------------------------------

//-------------------------------------- combinational logic
				//checking whether that it's the last partial-product or not
				//using sign extension to make sure that overflow will not happen
assign adder_output = (counter[3])? {Product[15],Product[15:8]} - {Multiplicand[7],Multiplicand} : {Multiplicand[7],Multiplicand} + {Product[15],Product[15:8]};
assign product_write_enable = Product[0];
assign ready = counter[3] && counter[0];
//---------------------------------------------------------

//--------------------------------------- sequential Logic
always @ (posedge clk)

    if(start) begin
        //counter starts from 1 so the conditions in 'combinational logic' part will be easier to understnad
        counter <= 4'h01 ;
        Product <= {8'h00,B};
        Multiplicand <= A;
    end

   else if(! ready) begin
         counter <= counter + 4'b1;
         //using signed shift to make sure that sign extension is properly executed
         Product <= Product >>> 1;
			if(product_write_enable)begin
				Product <= {adder_output,Product[7:1]};    
			end
   end   

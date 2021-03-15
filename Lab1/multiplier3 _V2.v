module multiplier3  (
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
wire [8:0] adder_output1,adder_output2,adder_output3,adder_output4;
//---------------------------------------------------------

//-------------------------------------- combinational logic
assign adder_output1 = {~Multiplicand[7],Multiplicand[6:0]} + Product[15:8];
assign adder_output2 = 8'h80 + Product[15:8];
assign adder_output3 = {Multiplicand[7],~Multiplicand[6:0]} + Product[15:8];
assign adder_output4 = 8'h7f + Product[15:8];
assign product_write_enable = Product[0];
assign ready = counter[3];

//---------------------------------------------------------
//--------------------------------------- sequential Logic
always @ (posedge clk)

   if(start) begin
      counter <= 4'h0 ;
      Product <= {8'h00,B};
      Multiplicand <= A;
   end

   else if(! ready) begin
         counter <= counter + 4'b1;
         //using signed shift to make sure that sign extension is properly executed
         Product <= Product >> 1;
        if(product_write_enable) begin
        //checking whether that it's the last partial-product or not
        if (counter < 4'b0111) begin
            Product <= {adder_output1,Product[7:1]};            
        end
        else begin
            Product <= {adder_output3,Product[7:1]}+16'b1000000100000000;            
        end
		  end
		  else begin
        //checking whether that it's the last partial-product or not
        if (counter < 3'b111) begin
            Product <= {adder_output2,Product[7:1]};            
        end
        else begin
            Product <= {adder_output4,Product[7:1]}+16'b1000000100000000;            
        end
		  end
   end   

endmodule
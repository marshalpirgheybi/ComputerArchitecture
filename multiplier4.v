module multiplier3 #(
    parameter n=8
    ) (
//-----------------------Port directions and deceleration
   input clk,  
   input start,
   input [n-1:0] A, 
   input [n-1:0] B, 
   output reg [2*n-1:0] Product,
   output ready
    );

//------------------------------------------------------

//----------------------------------- register deceleration
reg [n-1:0] Multiplicand ;
reg [n-1:0]  counter;
reg [n-1:0] const1;
reg [2*n-1:0] const3;
//-------------------------------------------------------

//------------------------------------- wire deceleration
wire product_write_enable;
wire [n:0] adder_output1,adder_output2,adder_output3,adder_output4;
//---------------------------------------------------------

//-------------------------------------- combinational logic
assign adder_output1 = {~Multiplicand[n-1],Multiplicand[n-2:0]} + Product[2*n-1:n];
assign adder_output2 = const1 + Product[15:8];
assign adder_output3 = {Multiplicand[n-1],~Multiplicand[n-2:0]} + Product[2*n-1:n];
assign adder_output4 = ~const1 + Product[2*n-1:n];
assign product_write_enable = Product[0];
assign ready = counter==n;

//---------------------------------------------------------
initial begin
    const1=0;
    const1[n-1]=1;
    const3=0;
    const3[2*n-1]=1;
    const3[n]=1;
end
//--------------------------------------- sequential Logic
always @ (posedge clk)

   if(start) begin
      counter <= n'h0 ;
      Product <= {n'b0,B};
      Multiplicand <= A;
   end

   else if(! ready) begin
         counter <= counter + n'b1;
         //using signed shift to make sure that sign extension is properly executed
         Product <= Product >> 1;
        if(product_write_enable) begin
        //checking whether that it's the last partial-product or not
        if (counter < n-1) begin
            Product <= {adder_output1,Product[n-1:1]};            
        end
        else begin
            Product <= {adder_output3,Product[n-1:1]}+const3;            
        end
		  end
		  else begin
        //checking whether that it's the last partial-product or not
        if (counter < n-1) begin
            Product <= {adder_output2,Product[n-1:1]};            
        end
        else begin
            Product <= {adder_output4,Product[n-1:1]}+const3;            
        end
		  end
   end   

endmodule
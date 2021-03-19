`timescale 1ns / 1ps
module fp_adder(
    input wire [31:0] a,
    input wire [31:0] b,
    output wire [31:0] s
    );

    //wire definition
        wire hidden_bit_a;
        wire hidden_bit_b;
        wire [7:0] exp_a;
        wire [7:0] exp_b;
        wire sign_smaller;
        wire sign_bigger;
        wire [25:0] fraction_a;
        wire [25:0] fraction_b;
        wire borrow;
        wire [7:0] differnece;
        wire [7:0] real_exp_a;
        wire [7:0] real_exp_b;
        wire [26:0] smaller_fraction;
        wire [26:0] bigger_fraction;
        wire [27:0] adder_input1;
        wire [27:0] adder_input2;
        wire [7:0] bigger_exp;
        wire normalize_checkbit;
        wire [22:0] final_fraction;
        wire [7:0] final_exp;
        wire final_sign;
        //temp_fraction stands for the fraction that is not rounded yet
        wire [26:0] temp_fraction;
        wire [7:0] temp_exp;
        wire [23:0] temp_fraction2;
	
	//modules	  
		Shiftmodule uut1 (.A(smaller_fraction), .B(differnece), .result(), .sticky_bit());
        special_adder uut2 (.a(adder_input1), .b(adder_input2), .result(), .position());
        Shiftmodule uut3 (.A(uut2.result[27:1]), .B(5'd27 - uut2.position - bigger_exp), .result(), .sticky_bit());
    
	 //assignments
        //assigning the sign
        assign sign_smaller = borrow ? b[31] : a[31];
        assign sign_bigger = borrow ? a[31] : b[31];
        
        //assigning exp
        assign exp_a = a[30:23];
        assign exp_b = b[30:23];
        
        //assignig ...
        assign real_exp_a = (exp_a == 8'h00) ? 8'h01 : exp_a;
        assign real_exp_b = (exp_b == 8'h00) ? 8'h01 : exp_b;
        
        //assigning hidden bit
        assign hidden_bit_a = (exp_a == 8'h00) ? 1'b0 : 1'b1;
        assign hidden_bit_b = (exp_b == 8'h00) ? 1'b0 : 1'b1;
        
        //assigning fractions
        assign fraction_a = {hidden_bit_a, a[22:0], 2'b00};
        assign fraction_b = {hidden_bit_b, b[22:0], 2'b00};

        
        //comparing section 
        assign borrow = exp_a >= exp_b;
        assign differnece = borrow ? (exp_a - exp_b) : (exp_b - exp_a);
        assign smaller_fraction = borrow ? {fraction_b, 1'b0} : {fraction_a, 1'b0};
        assign bigger_fraction = borrow ? {fraction_a, 1'b0} : {fraction_b, 1'b0};
        assign bigger_exp = borrow ? exp_a : exp_b;

        //assigning inputs of adder (LAB1)
        assign adder_input1 = {sign_smaller, uut1.result[26:1], uut1.sticky_bit};
        assign adder_input2 = {sign_bigger, bigger_fraction};
        
        
        //making the output of he adder OK
        assign normalize_checkbit = (bigger_exp + 8'h01) > (5'd27 - uut2.position);
        assign temp_fraction = normalize_checkbit ? uut2.result[26:0] : uut3.result;
        assign final_sign = uut2.result[28];
        assign temp_exp = normalize_checkbit ? (bigger_exp - 5'd26 + uut2.position) : 8'h00;


        //rounding
        assign temp_fraction2 = temp_fraction[3] ? (|temp_fraction[2:0] ? temp_fraction[26:4] + 23'b1 : (temp_fraction[4] ? temp_fraction[26:4] + 23'b1 : temp_fraction[26:4])) : {1'b0,temp_fraction[26:4]};

        //finalizing
        assign final_fraction = temp_fraction2[23] ? temp_fraction2[23:1] : temp_fraction[22:0];
        assign final_exp = temp_fraction[23] ? temp_exp + 8'b1 : temp_exp;

        //combining
        assign s = {final_sign, final_exp, final_fraction};
        


endmodule

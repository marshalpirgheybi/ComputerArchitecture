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
        wire [7:0] differnece_temp;
        wire [5:0] differnece;
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
        wire [7:0] diff_temp;
        wire [5:0] diff;
        //temp_fraction stands for the fraction that is not rounded yet
        wire [26:0] temp_fraction;
        wire [7:0] temp_exp;
        wire [23:0] temp_fraction2;


        //
        wire [26:0] result1, result3;
        wire [28:0] result2;
        wire sticky_bit1;
        wire [4:0] position;

	
	//modules	  
		Shiftmodule uut1 (.A(smaller_fraction), .B(differnece), .result(result1), .sticky_bit(sticky_bit1));
        special_adder uut2 (.a(adder_input1), .b(adder_input2), .result(result2), .position(position));
        Shiftmodule uut3 (.A(result2[27:1]), .B(diff), .result(result3), .sticky_bit());
    
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
        assign differnece_temp = borrow ? (real_exp_a - real_exp_b) : (real_exp_b - real_exp_a);
		assign differnece = differnece_temp[5:0];
        assign smaller_fraction = borrow ? {fraction_b, 1'b0} : {fraction_a, 1'b0};
        assign bigger_fraction = borrow ? {fraction_a, 1'b0} : {fraction_b, 1'b0};
        assign bigger_exp = borrow ? real_exp_a : real_exp_b;

        //assigning inputs of adder (LAB1)
        assign adder_input1 = {sign_smaller, result1[26:1], sticky_bit1 | result1[0]};
        assign adder_input2 = {sign_bigger, bigger_fraction};
        
        //
        assign diff_temp = 5'd26 - position - bigger_exp;
        assign diff = diff_temp[5:0];

        //making the output of he adder OK
        assign normalize_checkbit = ((bigger_exp + 8'h01) > (5'd27 - position)) && (result2 != 29'b0);
        assign temp_fraction = normalize_checkbit ? result2[26:0] : result3;
        assign final_sign = result2[28];
        assign temp_exp = normalize_checkbit ? (bigger_exp - 5'd26 + position) : 8'h00;


        //rounding
        assign temp_fraction2 = temp_fraction[3] ? (temp_fraction[2:0]!=0 ? temp_fraction[26:4] + 23'b1 : (temp_fraction[4] ? temp_fraction[26:4] + 23'b1 : {1'b0, temp_fraction[26:4]})) : {1'b0,temp_fraction[26:4]};

        //finalizing
        assign final_fraction = temp_fraction2[23] ? temp_fraction2[23:1] : temp_fraction2[22:0];
        assign final_exp = temp_fraction2[23] ? temp_exp + 8'b1 : temp_exp;

        //combining
        assign s = {final_sign, final_exp, final_fraction};
        


endmodule

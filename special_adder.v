`timescale 1ns / 1ps
module special_adder (
    input wire [27:0] a,
    input wire [27:0] b,
    output wire [28:0] result,
    output wire [4:0] position
);

//defining wire
    //tcompa means 2'complement of a
    wire [28:0] tcompa;
    wire [28:0] tcompb;
    //temp_sum1 for storing 2'complement result
    wire [28:0] temp_sum1;
    //temp_sum2 for storing s&m result
    wire [28:0] temp_sum2;
    //shift temp
    wire [27:0] temp_result;
//assignments
    //converting to two's complement
    assign tcompa = a[27] ? {2'b11, ~a[26:0] + 27'b1} : {1'b0, a};   
    assign tcompb = b[27] ? {2'b11, ~b[26:0] + 27'b1} : {1'b0, b};   
    //adding :)
    assign temp_sum1 = tcompa + tcompb;
    //converting to s&m
    assign temp_sum2 = temp_sum1[28] ? {temp_sum1[28], ~temp_sum1[27:0] + 28'b1} : temp_sum1;

    //leading one detection
    assign position[4] = |temp_sum2[27:16];
    assign position[3] = position[4] ? |temp_sum2[27:24] : |temp_sum2[15:8];
    assign position[2] = position[4] ? (position[3] ? 1'b0 : |temp_sum2[23:20]) : (position[3] ? |temp_sum2[15:12] : |temp_sum2[7:4]);
    assign position[1] = position[4] ? (position[3] ? (position[2] ? 1'b0 : |temp_sum2[27:26]) : (position[2] ? |temp_sum2[23:22] : |temp_sum2[19:18]) ) : (position[3] ? ((position[2] ? |temp_sum2[15:14] : |temp_sum2[11:10])) : ((position[2] ? |temp_sum2[7:6] : |temp_sum2[3:2])) );
    assign position[0] = position[4] ? (position[3] ? (position[2] ? 1'b0 : (position[1] ? temp_sum2[27] : temp_sum2[25])) : (position[2] ? (position[1] ? temp_sum2[23] : temp_sum2[21] ) : (position[1] ? temp_sum2[19] : temp_sum2[17] )) )       :       (position[3] ? ((position[2] ? (position[1] ? temp_sum2[15] : temp_sum2[13]) : (position[1] ? temp_sum2[11] : temp_sum2[9]))) : ((position[2] ? (position[1] ? temp_sum2[7] : temp_sum2[5]) : (position[1] ? temp_sum2[3] : temp_sum2[1]))) );

    //final result
    assign temp_result =    temp_sum2[27] ? temp_sum2[27:0] :
                            temp_sum2[26] ? {temp_sum2[26:0],1'b0} :
                            temp_sum2[25] ? {temp_sum2[25:0],2'b0} :
                            temp_sum2[24] ? {temp_sum2[24:0],3'b0} :
                            temp_sum2[23] ? {temp_sum2[23:0],4'b0} :
                            temp_sum2[22] ? {temp_sum2[22:0],5'b0} :
                            temp_sum2[21] ? {temp_sum2[21:0],6'b0} :
                            temp_sum2[20] ? {temp_sum2[20:0],7'b0} :
                            temp_sum2[19] ? {temp_sum2[19:0],8'b0} :
                            temp_sum2[18] ? {temp_sum2[18:0],9'b0} :
                            temp_sum2[17] ? {temp_sum2[17:0],10'b0} :
                            temp_sum2[16] ? {temp_sum2[16:0],11'b0} :
                            temp_sum2[15] ? {temp_sum2[15:0],12'b0} :
                            temp_sum2[14] ? {temp_sum2[14:0],13'b0} :
                            temp_sum2[13] ? {temp_sum2[13:0],14'b0} :
                            temp_sum2[12] ? {temp_sum2[12:0],15'b0} :
                            temp_sum2[11] ? {temp_sum2[11:0],16'b0} :
                            temp_sum2[10] ? {temp_sum2[10:0],17'b0} :
                            temp_sum2[9] ? {temp_sum2[9:0],18'b0} :
                            temp_sum2[8] ? {temp_sum2[8:0],19'b0} :
                            temp_sum2[7] ? {temp_sum2[7:0],20'b0} :
                            temp_sum2[6] ? {temp_sum2[6:0],21'b0} :
                            temp_sum2[5] ? {temp_sum2[5:0],22'b0} :
                            temp_sum2[4] ? {temp_sum2[4:0],23'b0} :
                            temp_sum2[3] ? {temp_sum2[3:0],24'b0} :
                            temp_sum2[2] ? {temp_sum2[2:0],25'b0} :
                            temp_sum2[1] ? {temp_sum2[1:0],26'b0} :
                            temp_sum2[0] ? {temp_sum2[0],27'b0} : 28'b0;

    assign result = {temp_sum2[28],temp_result};

endmodule
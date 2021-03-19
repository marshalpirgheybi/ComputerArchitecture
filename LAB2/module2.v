module Shiftmodule (
    input wire [26:0] A,
    input wire [5:0] B,
    output wire sticky_bit,
    output wire [26:0] result
);
// Defining extra variables
wire [26:0] TrashBits;
//
assign result = (B<27) ? ( (B==26) ? {26'b0,A[26:26]} :
                            (B==25) ? {25'b0,A[26:25]} : 
                            (B==24) ? {24'b0,A[26:24]} :
                            (B==23) ? {23'b0,A[26:23]} :
                            (B==22) ? {22'b0,A[26:22]} :
                            (B==21) ? {21'b0,A[26:21]} :
                            (B==20) ? {20'b0,A[26:20]} :
                            (B==19) ? {19'b0,A[26:19]} :
                            (B==18) ? {18'b0,A[26:18]} : 
                            (B==17) ? {17'b0,A[26:17]} :
                            (B==16) ? {16'b0,A[26:16]} :
                            (B==15) ? {15'b0,A[26:15]} :
                            (B==14) ? {14'b0,A[26:14]} :
                            (B==13) ? {13'b0,A[26:13]} :
                            (B==12) ? {12'b0,A[26:12]} :
                            (B==11) ? {11'b0,A[26:11]} : 
                            (B==10) ? {10'b0,A[26:10]} :
                            (B==9) ? {9'b0,A[26:9]} :
                            (B==8) ? {8'b0,A[26:8]} :
                            (B==7) ? {7'b0,A[26:7]} :
                            (B==6) ? {6'b0,A[26:6]} :
                            (B==5) ? {5'b0,A[26:5]} :
                            (B==4) ? {4'b0,A[26:4]} : 
                            (B==3) ? {3'b0,A[26:3]} :
                            (B==2) ? {2'b0,A[26:2]} :
                             {1'b0,A[26:1]} 
                             ) : 
                             27'b0;
assign TrashBits = (B<27) ? ( (B==26) ? {1'b0,A[25:0]} :
                            (B==25) ? {2'b0,A[24:0]} : 
                            (B==24) ? {3'b0,A[23:0]} :
                            (B==23) ? {4'b0,A[22:0]} :
                            (B==22) ? {5'b0,A[21:0]} :
                            (B==21) ? {6'b0,A[20:0]} :
                            (B==20) ? {7'b0,A[19:0]} :
                            (B==19) ? {8'b0,A[18:0]} :
                            (B==18) ? {9'b0,A[17:0]} : 
                            (B==17) ? {10'b0,A[16:0]} :
                            (B==16) ? {11'b0,A[15:0]} :
                            (B==15) ? {12'b0,A[14:0]} :
                            (B==14) ? {13'b0,A[13:0]} :
                            (B==13) ? {14'b0,A[12:0]} :
                            (B==12) ? {15'b0,A[11:0]} :
                            (B==11) ? {16'b0,A[10:0]} : 
                            (B==10) ? {17'b0,A[9:0]} :
                            (B==9) ? {18'b0,A[8:0]} :
                            (B==8) ? {19'b0,A[7:0]} :
                            (B==7) ? {20'b0,A[6:0]} :
                            (B==6) ? {21'b0,A[5:0]} :
                            (B==5) ? {22'b0,A[4:0]} :
                            (B==4) ? {23'b0,A[3:0]} : 
                            (B==3) ? {24'b0,A[2:0]} :
                            (B==2) ? {25'b0,A[1:0]} :
                             {26'b0,A[0:0]} 
                             ) : 
                             A;
assign sticky_bit = TrashBits[26] | 
                    TrashBits[25] |
                    TrashBits[24] |
                    TrashBits[23] |
                    TrashBits[22] |
                    TrashBits[21] |
                    TrashBits[20] |
                    TrashBits[19] |
                    TrashBits[18] |
                    TrashBits[17] |
                    TrashBits[16] |
                    TrashBits[15] |
                    TrashBits[14] |
                    TrashBits[13] |
                    TrashBits[12] |
                    TrashBits[11] |
                    TrashBits[10] |
                    TrashBits[9] |
                    TrashBits[8] |
                    TrashBits[7] |
                    TrashBits[6] |
                    TrashBits[5] |
                    TrashBits[4] |
                    TrashBits[3] |
                    TrashBits[2] |
                    TrashBits[1] |
                    TrashBits[0] ;
endmodule
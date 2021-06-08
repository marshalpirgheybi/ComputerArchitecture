MOV TMOD,#20H                   ;TIMER 1 MODE 2
MOV TH1,#-7                     ;9600 BAUD
MOV SCON,#40H                   ;REN enable, MODE 1
MOV A, PCON
SETB ACC.7
MOV PCON, A
SETB TR1                        ;start timer1


                                ;REN enable, MODE 0
HERE:
        MOV DPTR, #NUM
LOOP:
        CLR A
        MOVC A, @A+DPTR
        JZ HERE
        ACALL TRANS
        INC DPTR
        JMP LOOP

TRANS:
        MOV SBUF, A
WAIT: 
        JNB TI,WAIT
        CLR TI
        RET

NUM:    DB '15, 68, ',0

LOOK_UP:                        ; hexadecimal encodings for displaying the digits 0 to F
        DB 3FH                  ; 0
        DB 06H                  ; 1
        DB 5BH                  ; 2
        DB 4FH                  ; 3
        DB 66H                  ; 4
        DB 6DH                  ; 5
        DB 7DH                  ; 6
        DB 07H                  ; 7
        DB 0FFH                 ; 8
        DB 6FH                  ; 9
        DB 77H                  ; A
        DB 7CH                  ; B
        DB 39H                  ; C
        DB 5EH                  ; D
        DB 79H                  ; E
        DB 71H                  ; F
        DB 00H                  ; NaN

END
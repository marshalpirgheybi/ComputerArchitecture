ORG     00
CLR     RS0
CLR     RS1
MOV     DPTR,#1000
MOV     P1,#0FFH
MOV     TMOD,#01H
;R7=LAST        R6=SECOND LAST
MOV     R7,#0           ;INITIALIZATION
MOV     R6,#0
MAIN:
        CALL    ROW_DETECTION
        CALL    COLUMN_DETECTION
        CALL    DELAY
        CJNE    R0,#3,NO_FUNCTION_NOTZERO
        CJNE    R1,#2,HASH_STAR
        MOV     A,#0            ;CURRENT_NUMBER
        JMP     NO_FUNCTION
HASH_STAR:      
        CJNE    R1,#1,HASH
STAR:
        MOV     A,R7
        MOV     R2,A            ;R2=F/100       
        JMP     MAIN
HASH:                
        MOV     A,R6
        MOV     B,#10
        MUL     AB
        ADD     A,R7
        MOV     R3,A            ;R3=DUTY CYCLE
        CALL    SIGNAL
        JMP     MAIN
NO_FUNCTION_NOTZERO:
        MOV     A,R0
        MOV     B,#3
        MUL     AB
        ADD     A,R1            ;CURRENT_NUMBER
NO_FUNCTION:
        MOV     B,R7
        MOV     R7,A
        MOV     R6,B
        JMP     MAIN




ROW_DETECTION:
        MOV     P1,#0FEH
        MOV     A,P1
        CJNE    A,#0FEH,ROW1
        MOV     P1,#0FDH
        MOV     A,P1
        CJNE    A,#0FDH,ROW2
        MOV     P1,#0FBH
        MOV     A,P1
        CJNE    A,#0FBH,ROW3
        MOV     P1,#0F7H
        MOV     A,P1
        CJNE    A,#0F7H,ROW4
        JMP     ROW_DETECTION:
ROW1:
        MOV     R0,#0
        RET
ROW2:
        MOV     R0,#1
        RET
ROW3:
        MOV     R0,#2
        RET
ROW4:
        MOV     R0,#3
        RET                

COLUMN_DETECTION:
        MOV     P1,#0EFH
        MOV     A,P1
        CJNE    A,#0EFH,COL1
        MOV     P1,#0DFH
        MOV     A,P1
        CJNE    A,#0DFH,COL2
        MOV     P1,#0BFH
        MOV     A,P1
        CJNE    A,#0BFH,COL3
        JMP     COLUMN_DETECTION:
COL1:
        MOV     R1,#1
        RET
COL2:
        MOV     R1,#2
        RET
COL3:
        MOV     R1,#3
        RET
        
DELAY:
        MOV R5, #250
        AGAIN: MOV R4,#250
        HERE:
            NOP
            NOP
            DJNZ R4, HERE
            DJNZ R5, AGAIN
            RET

SIGNAL:
        MOV     R7,#2
        MOV     A,#100         ;STEPS
        SUBB    A,R3
        MOV     R4,A
        MOV     B,R3           ;DUTY CYCLE
        MOV     R5,B
        SETB    P0.0
        MOV     A,R2
        MOVC    A,@A+DPTR   ;NUMBER OF STEPS
        JMP     AGAIN1
        DUTY_CYCLE_FINISHED:
                CLR     P0.0
                MOV     B,R4
                MOV     R5,B
        AGAIN1:
                CLR     TR0
                MOV     TL0,#0
                SETB    TR0
        HERE1:
                SETB    TR0
                CLR     TR0
                MOV     B,TL0
                CJNE    A,B,HERE1
                DJNZ    R5,AGAIN1
                DJNZ    R7,DUTY_CYCLE_FINISHED             
        RET


ORG 1000
LOOK_UP_TABLE:                  ;SETTING THE LOOK UP TABLE
        DB     #00H             ;f=0/100
        DB     #100             ;f=1/100
        DB     #50              ;f=2/100
        DB     #33              ;f=3/100
        DB     #25              ;f=4/100
        DB     #20              ;f=5/100
        DB     #17              ;f=6/100
        DB     #14              ;f=7/100
        DB     #12              ;f=8/100
        DB     #11             ;f=9/100
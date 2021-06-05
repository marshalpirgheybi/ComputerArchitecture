EN      EQU     P3.3    ;P0.3 = EN
RW      EQU     P3.2    ;P0.2 = RW
RS      EQU     P3.1    ;P0.1 = RS

ORG 00H
MOV     R0,#0 ;REGISTER FOR COUNTER
MOV     DPTR,#1000 ;BEGINNING OF A STRING
CALL    LCD_INIT
CALL    STRING_DISP
STOP:   JMP     STOP     

LCD_INIT:
        MOV     A,#38H
        CALL    CMD
        MOV     A,#0EH  ;DISP ON, CURSOR OFF
        CALL    CMD
        MOV     A,#01H  ;CLEAR DISPLAY
        CALL    CMD
        MOV     A,#0CH
        CALL    CMD
        RET

STRING_DISP:    
        LOOP:
        MOV     A,#0
        MOVC    A,@A+DPTR
        JZ      DONE
        MOV     P2,A
        CALL    DATA
        INC     DPTR
        INC     R0
        CALL    Display_Delay
        CJNE    R0,#4,END_OF_LOOP
        CALL    CLEAR_SCR
END_OF_LOOP:
        JMP     LOOP
DONE:
        RET

DATA:
        CALL    Display_Delay
        MOV     P2,A    ;DATA
        SETB    RS      ;DATA
        CLR     RW      ;WRITE
        SETB    EN
        CLR     EN
        RET
CMD:
        CALL    Display_Delay
        MOV     P2,A    ;COMMAND
        CLR    RS      ;COMMAND
        CLR     RW      ;WRITE
        SETB    EN
        CLR     EN
        RET
Display_Delay:
        MOV R5, #250
        AGAIN: MOV R4,#250
        HERE:
            NOP
            NOP
            DJNZ R4, HERE
            DJNZ R5, AGAIN
            RET

CLEAR_SCR:
        MOV     A,#01H  ;CLEAR DISPLAY
        CALL    CMD
        CALL    Display_Delay
        MOV     A,#02H  ;CLEAR DISPLAY
        CALL    CMD
        CALL    Display_Delay
        MOV     R0,#0   ;RESET THE COUNTER
        RET
;STRING
ORG     1000
     DB      'AMIRMOHAMMAD MARSHAL PIRGHEYBI_MEHRAN MONTAZER',0    
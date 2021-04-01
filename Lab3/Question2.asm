.data
	A:   .word 24
	B:   .word 32
	FinalMessage:  .asciiz "The GCD of A and B is: "
.text 
.globl main
main:
	lw $v0, A
	lw $v1, B
	
	jal GCD
	
	add  $s0, $v0, $zero	
	
	li $v0, 4
	la $a0, FinalMessage
	syscall
	
	li $v0, 1
	add $a0, $s0, $zero
	syscall 
	
	
	li $v0, 10
	syscall 
	
.globl GCD	
GCD:
	subu $sp, $sp, 8
	sw   $ra, ($sp)
	sw   $s0, 4($sp)
	
	
	#Base case
	div $v0, $v1
	move $s0, $v1
	mfhi $v1
	move $v0, $s0
	beq $v1, 0 , GCDDone
	
	jal GCD
	
	
	
	
	
	GCDDone: 
	lw    $ra, ($sp)
	lw    $s0, 4($sp)
	addu  $sp, $sp, 8
	jr    $ra
	
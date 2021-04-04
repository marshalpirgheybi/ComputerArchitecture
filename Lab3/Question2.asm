	add $a0, $s1, $zero
	add $a1, $s2, $zero
	add $v0, $a0, $zero
	add $v1, $a1, $zero
	jal GCD	
	add  $s0, $v0, $zero
	j Done		
GCD:
	subu $sp, $sp, 8
	sw   $ra, ($sp)
	sw   $s0, 4($sp)
	#Base case
	div $v0, $v1
	add $s0, $v1 , $zero
	mfhi $v1
	add $v0, $s0, $zero
	beq $v1, 0 , GCDDone
	jal GCD
	GCDDone: 
	lw    $ra, ($sp)
	lw    $s0, 4($sp)
	addu  $sp, $sp, 8
	jr    $ra
Done:
	
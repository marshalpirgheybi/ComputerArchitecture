	jal fib
	j Done
fib:	#defining fib
	addi $t0, $zero, 1	#initializing
	addi $a1, $zero , 1 
	addi $a2, $zero, 0
	while:			#the while loop
		slt   $t1, $s0, $t0
		bne   $t1, $zero, exit			#while condidion
		addi  $t0, $t0, 1
		add    $a3, $a1, $zero			# a3 = a1
		addu  $a1, $a2, $a1			# a1 = a1+a2
		add    $a2, $a3, $zero			# a2 = a3
		j while 
	exit:
        add $v0, $a2, $zero
		jr $ra	
Done:
	jal fib
	j Done
fib:	#defining fib
	addi $t0, $zero, 1	#initializing
	addi $t1, $zero , 1 
	addi $t2, $zero, 0
	while:			#the while loop
		slt   $t4, $s0, $t0
		bne   $t4, $zero, exit			#while condidion
		addi  $t0, $t0, 1
		add    $t3, $t1, $zero			# t3 = t1
		addu  $t1, $t2, $t1			# t1 = t1+t2
		add    $t2, $t3, $zero			# t2 = t3
		j while 
	exit:
		jr $ra	
Done:
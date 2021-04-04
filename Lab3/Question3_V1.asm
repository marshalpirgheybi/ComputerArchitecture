#Question3 fibonacci
#the given number is in register $s3
    or	$a0, $s3, $zero
    jal	fib
    or $s5,$v0,$zero
    j done 
fib:                addi	$sp, $sp, -12   #saving in stack
                    sw      $ra, 8($sp)
                    sw      $a0, 4($sp)
                    addi	$t0, $zero, 1 
                    #Base Case
                    bne 	$a0, $t0, zeroOrNot     
                    addi    $v0, $zero, 1           #returning 1 for the first number 
                    addi	$sp, $sp, 12
                    jr	    $ra
        zeroOrNot:  blez    $a0, zeroPart
                    j	    ndy                     #jumping to not determined yet to continue the function by calling it again
        zeroPart:   addi    $v0, $zero, 0           #returning 0 for invalid numbers
                    addi	$sp, $sp, 12
                    jr	    $ra         

    ndy:            addi	$a0, $a0, -1            
                    jal     fib                     #calling fib(n-1)
                    sw	    $v0, 0($sp)             #saving fib(n-1) in memory
                    lw      $a0, 4($sp)             
                    addi	$a0, $a0, -2            
                    jal     fib                     #calling fib(n-2)
                    or	    $s1, $v0, $zero         
                    lw	    $s0, 0($sp)
                    add 	$v0, $s0, $s1           #fib(n) = fib(n-1) + fib(n-2)
                    lw      $ra 8($sp)              #returning
                    addi	$sp, $sp, 12
                    jr	    $ra
done:	
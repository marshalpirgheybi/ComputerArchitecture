#Question4

#number of the days are in register s0
        or	$a0, $s0, $zero
        jal     function
        j	done

function:       or	    $t0, $a0, $zero     #putting days in $t0
                or      $v0, $zero, $zero   #reseting
                or      $v1, $zero, $zero   #reseting
                addi	$s1, $zero, 365     #year
                addi	$s2, $zero, 30      #month
                addi	$s3, $zero, 15      #half month
                addi    $s4, $zero, 1       #constant one        
    year:       slt	    $t1, $t0, $s1       #checking whether days are more than a yaer or not
                beq     $t1, $s4, month
                sub	    $t0, $t0, $s1
                addi	$v0, $v0, 1
                j	year
    month:      slt	    $t1, $t0, $s2       #checking whether days are more than a month or not
                beq     $t1, $s4, submonth
                sub     $t0, $t0, $s2
                addi	$v1, $v1, 1
                j	month
    submonth:   slt     $t1, $t0, $s3       #rounding
                beq     $t1, $s4, end
                addi	$v1, $v1, 1
    end:        jr  	$ra
done:

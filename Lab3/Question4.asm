#Question4

#number of the days are in register s0
        or	$a0, $s0, $zero
        jal     function
        j	done

function:       or	    $t0, $a0, $zero
                or      $v0, $zero, $zero
                or      $v1, $zero, $zero
                addi	$s1, $zero, 365
                addi	$s2, $zero, 30
                addi	$s3, $zero, 15                
    year:       blt	    $t0, $s1, month
                sub     $t0, $t0, $s1
                addi	$v0, $v0, 1
                j	year
    month:      blt	    $t0, $s2, submonth
                sub     $t0, $t0, $s2
                addi	$v1, $v1, 1
                j	month
    submonth:   blt     $t0, $s3, end
                addi	$v1, $v1, 1
    end:        jr  	$ra
done:
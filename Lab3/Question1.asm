	lui   $t7, 0x1001 
	lw    $t0, 0($t7)			#Loading the variables from the addressess
	lw    $t1, 4($t7)
	lw    $t2, 8($t7)
	lw    $t3, 12($t7)
	addu  $s0, $t0, $t2			#adding the least valueable 4 bytes
	sltu  $t4, $s0, $t0			#finding the carry
	add   $s1, $t1, $t3			#adding the most valueable 4 bytes
	add  $s1, $s1, $t4 			#finilizing adding
	sw    $s0,  16($t7)			#storing the values in the the wanted addresses
	sw    $s1,  20($t7)

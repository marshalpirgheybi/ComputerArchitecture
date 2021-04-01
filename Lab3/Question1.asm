.data
	
.text 
main:
	lw    $t0, 0x10010000			#Loading the variables from the addressess
	lw    $t1, 0x10010004
	lw    $t2, 0x10010008
	lw    $t3, 0x1001000c
	addu  $s0, $t0, $t2			#adding the least valueable 4 bytes
	sltu  $t4, $s0, $t0			#finding the carry
	add   $s1, $t1, $t3			#adding the most valueable 4 bytes
	add  $s1, $s1, $t4 			#finilizing adding
	sw    $s0,  0x10010010			#storing the values in the the wanted addresses
	sw    $s1,  0x10010014
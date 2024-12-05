.data
.text
primup: 
	move $t1 , $a0
	move $t0 , $a0
	add $t7 , $zero , 2
	beq $t1 , $t7 , prim

	andi $t1 , $t0 , 1 	#wenn readint gerade steht
				#in $t1 0, sonst 1
loop:
	beqz $t1 , noprim 	#read int ist gerade −−>noprim
	li $t2 , 3 		#$t2 = 3
	beq $t0 , $t2 , prim 	#read i nt == 3 −−> prim
	div $t0 , $t2
	mfhi $t3 		#$t3 = $t0 mod $t2
	beqz $t3 , noprim	#$t3 == 0 −−> noprim
	add $t2 , $t2 , 2	#$t2 = $t2 + 2
	mul $t4 , $t2 , $t2	#$t4 = $t2∗$t2
	blt $t4 , $t0 , loop	#$t4 < read_int −−> loop
	j prim 			#keinen Teiler gefunden −−> prim
prim:
	li $v0, 1
	j end
noprim:
	li $v0, 0
	j end
end:
				#Nachspann
	jr $ra
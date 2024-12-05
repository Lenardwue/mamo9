####################################################
#
# Programm: mirp.s
#
.data
output1: .asciiz "\nBitte eine Zahl groesser als 9 eingeben! "
output2: .asciiz "\nBitte zweite Zahl groesser als erste Zahl eingeben! "
yes: .asciiz " ist eine Mirpzahl!\n"
no: .asciiz " ist keine Mirpzahl!\n"
err: .asciiz "Bitte eine Zahl groesserer als 9 auswaehlen!\n"
err2: .asciiz "Bitte eine Zahl groesserer/gleich erstem Wert auswaehlen!\n"
endb: .asciiz "\nEnde der Berechnung!\n"

.text
.globl main
main:
	#Vorspann
	li $v0, 4 #print_string
	la $a0, output1
	syscall
	li $v0, 5 #read_int
	syscall
	move $s0, $v0 #$t0 = read_int 1. wert
	sub $t1, $s0, 9
	blez $s0, error #read_int <= 0--> error
	j go_on #-->go_on
error:
	li $v0, 4 #print_string
	la, $a0, err
	syscall
	j end #-->end
go_on:
	li $v0, 4 #print_string
	la $a0, output2
	syscall
	li $v0, 5 #read_int
	syscall
	move $s7, $v0 # $t7 2. Wert
	bge $s7, $s0, schleife
	li $v0, 4 #print_string
	la, $a0, err2
	syscall
	j go_on
test:
	bge $s7, $s0, schleife
	li $v0, 4
	la $a0, endb
	syscall
	li $v0, 10
	syscall
schleife:
	move $a0, $s0 # in $a0 steht zu pruefende Zahl
	jal primup
	# Weiterberechnung, falls Primzahl
	li $t9, 1
	move $a0, $s0
	addu $s0, $s0, 1
	bne $v0, $t9, test
	# Umdrehen der Zahl
	# Test auf Prim
	li $s2, 10
	li $s6, 0
	move $s3, $a0 # zu drehende Zahl in $t0
	move $a1, $a0
weiter: mul $s6, $s6, 10
	div $s3,$s2
	mflo $s3
	mfhi $s5
	add $s6, $s6, $s5
	bnez $s3, weiter
	# Test auf Palindrom
	beq $a0, $s6, test
	move $a0, $s6 # in $a0 steht zu pruefende Zahl
	jal primup
	# Ausgabe, falls Mirpzahl
	li $t9, 1
	bne $v0, $t9, test
	move $a0, $a1
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, yes
	syscall
	j test
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
.data
#
# Fibonacci−Berechnung
# rekursiv
#
.text
main:
	sw $fp, 0($sp)
	sw $ra, −4($sp)
	move $fp, $sp
	subu $sp, $sp, 8
	
mainLoop:
	la $a0, eingabe
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall

	move $a0, $v0
	
	li $t7, 1
	beq $a0, $t7, ruf
	subu $a0, $a0, 1

ruf : jal fib
	move $s0, $v0
	la $a0 , ergebnis
	li $v0,4
	syscall
	move $a0 , $s0
	li $v0 , 1
	syscall
	b mainLoop
fib :
	sw $fp , 0($sp)
	sw $ra , −4($sp)
	move $fp , $sp
	subu $sp , $sp , 16
	li $t0 , 1
	ble $a0 , $t0 , baseFib
	subu $a0 , $a0 , $t0
	sw $a0 , −12($fp)
	jal fib
	sw $v0, −8($fp)
	lw $a0 , −12($fp)
	li $t0 , 1
	subu $a0 , $a0 , $t0
	j al fib
	lw $t0 , −8($fp)
	addu $v0 , $v0, $t0
	b endFib
baseFib :
	li $v0 , 1
endFib :
	li $v0 , 1
	move $sp , $fp
	lw $ra , −4($sp)
	lw $fp , 0($sp)
	jr $ra
	.data
eingabe : .asciiz ”\nGib eine natuerliche Zahl ein : ”
	.align 4
ergebnis : .asciiz ”\nFib # = "
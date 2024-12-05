.data
wort: .word 0x49ce0000
wort2: .word 0
nl: .asciiz "\n"
ein: .asciiz "\nEingabe in integer: "
aus: .asciiz "\nAusgabe in integer: "

.text 0x400000
main:
	li $v0,4
	la $a0, ein
	syscall

	li $v0,5 # Eingabe der Zeichenkette als Int-Entsprechung
	syscall
	sw $v0, wort # Speichern in Wert

	li $s2, 32 # Bitkettenlaenge
	lw $t1, wort # Laden der Bittkette in Register
	sll $t2, $t1, 31 # shift links 31 bit-letztes Bit wird erstes
	li $s0, 0
anf: 	
	add $s0, $s0, 1 # Index + 1
	srl $t1, $t1, 1 # shift nach rechts
	sll $t3, $t1, 31 # naechstes Bit separiert
	srlv $t3, $t3, $s0 # Bit an richtige Stelle
	or $t2, $t2, $t3 # zum Ergebnis dazu
	blt $s0, $s2, anf # Abbruch bei 32
	nop
	nop

	sw $t2, wort2 # speichert Ergebnit unter wort2
	li $v0,4
	la $a0, aus
	syscall

	li $v0,1
	move $a0, $t2 # Ausgabe als Integerentsprechung der Zeichenkette
	syscall
	li $v0,10
	syscall
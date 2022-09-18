# print_array.asm program

.data
	array: .word 1 2 3 4 5 6 7 8 9 10
	cout: .asciiz "The contents of the array in reverse order are:\n"
	newline: .asciiz "\n"

.text
printA:
    move $a2 $a0 #move array pointer to $a2

    li $t0 4
    mult $a1 $t0 # alength * 4 
    mflo $t0
    addi $t0 $t0 -4
    move $t1 $zero #counter = 0
    add $a2 $a2 $t0

loop:
    li $v0 1
	lw $a0 0($a2)
	syscall

	li $v0 4
	la $a0 newline
	syscall

	addi $a2 $a2 -4
	
	addi $t1 $t1 1
	blt $t1 $a1 loop

    jr $ra

main:
	li $v0, 4
	la $a0, cout
	syscall

	la $a0, array #array pointer
	li $a1, 10 #array length

	jal printA

exit:
	li $v0 10
	syscall


# hello.asm

.data

    prompt: .ascii "Enter an integer: "

.text
main:

    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    andi $t1, $t0, 1

    beq $t1, $zero, even
    bne $t1, $zero, odd

    j exit

even:
    li $t2, 6
    mult $t0, $t2
    mflo $t0

    j print

    j exit

odd:
    li $t2, 9
    mult $t0, $t2
    mflo $t0

    j print

    j exit

print:
    li $v0, 1
    move $a0, $t0
    syscall

    j exit 

exit:
    li $v0, 10
    syscall
# arithmetic.asm

.text
main:
    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 5
    syscall
    move $t1, $v0

    sub $t2, $t0, $t1

    # shift left by 6 = multiply by 2^6(64)
    sll $t2, $t2, 6

    addi $t2, $t2, 32

    li $v0, 1
    move $a0, $t2
    syscall

    j exit


exit:
    li $v0, 10
    syscall
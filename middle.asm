# middle.asm program

.data
        prompt: .asciiz "Enter the next number:\n"
        finalV: .asciiz "Second Largest: "
        newspace: .asciiz "\n"

#Text Area (i.e. instructions)
.text

main:

    li $v0 4
    la $a0 prompt
    syscall

    li $v0 5
    syscall
    move $t0 $v0 # value 1

    li $v0 4
    syscall

    li $v0 5
    syscall
    move $t1 $v0 # value 2

    li $v0 4
    syscall

    li $v0 5
    syscall
    move $t2 $v0 # value 3

    bge $t0 $t1 firstGTsecond # 1 > 2

    bge $t1 $t0 secondGTfirst # 2 > 1

    j exit

firstGTsecond:
    bge $t0 $t2 compSecondThird # 1 >= 2 >= 3
    j compFirstSecond # 3 >= 1

secondGTfirst:
    bge $t1 $t2 compFirstThird # 2 >= 3 >= 1
    j compFirstSecond # 3 >= 2

compSecondThird:
    bge $t1 $t2 secondMid
    j thirdMid

compFirstThird:
    bge $t0 $t2 firstMid
    j thirdMid

compFirstSecond:
    bge $t0 $t1 firstMid
    j secondMid

firstMid:
    li $v0 4
    la $a0 finalV
    syscall

    li $v0 1
    move $a0 $t0
    syscall

    j exit

secondMid:
    li $v0 4
    la $a0 finalV
    syscall

    li $v0 1
    move $a0 $t1
    syscall

    j exit

thirdMid:
    li $v0 4
    la $a0 finalV
    syscall

    li $v0 1
    move $a0 $t2
    syscall

    j exit

exit:
    li $v0 10
    syscall
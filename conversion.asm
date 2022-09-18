# conversion.asm program

.text
conv:
    # TODO: Write your function code here

    move $t0 $zero # z = 0
    move $t1 $zero # i = 0
    li $t2 8 # register holding 8
    li $t3 2 #register holding 2
    j loop

loop:
    mult $a0 $t2 # 8x
    mflo $t4 # $t4 = 8x
    sub $t0 $t0 $t4 # z = z - 8x
    add $t0 $t0 $a1 # z = z - 8x + y

    blt $a0 $t3 if_false
    addi $a1 $a1 -1 

if_false:
    addi $a0 $a0 1
    addi $t1 $t1 1

    blt $t1 $t2 loop
    move $v0 $t0

    jr $ra

main:
    li $a0, 5
    li $a1, 7

    jal conv

	move $a0, $v0
    li $v0, 1
    syscall

exit:
    li $v0 10
    syscall
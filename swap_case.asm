# Data Area
.data
    buffer: .space 100
    input_prompt:   .asciiz "Enter string:\n"
    output_prompt:   .asciiz "Output:\n"
    convention: .asciiz "Convention Check\n"
    newline:    .asciiz "\n"
    checker: .asciiz "entered continue loop"

.text

main:
    la $a0, input_prompt    # prompt user for string input
    li $v0, 4
    syscall

    li $v0, 8       # take in input
    la $a0, buffer
    li $a1, 100
    syscall
    move $s0, $a0   # save string to s0

    ori $s1, $0, 0
    ori $s2, $0, 0
    ori $s3, $0, 0
    ori $s4, $0, 0
    ori $s5, $0, 0
    ori $s6, $0, 0
    ori $s7, $0, 0

    move $a0, $s0
    jal Swap_Case

    add $s1, $s1, $s2
    add $s1, $s1, $s3
    add $s1, $s1, $s4
    add $s1, $s1, $s5
    add $s1, $s1, $s6
    add $s1, $s1, $s7
    add $s0, $s0, $s1

    la $a0, output_prompt    # give Output prompt
    li $v0, 4
    syscall

    move $a0, $s0
    jal DispString

    j Exit

DispString:
    addi $a0, $a0, 0
    li $v0, 4
    syscall
    jr $ra

ConventionCheck:
    addi    $t0, $0, -1
    addi    $t1, $0, -1
    addi    $t2, $0, -1
    addi    $t3, $0, -1
    addi    $t4, $0, -1
    addi    $t5, $0, -1
    addi    $t6, $0, -1
    addi    $t7, $0, -1
    ori     $v0, $0, 4
    la      $a0, convention
    syscall
    addi    $v0, $zero, -1
    addi    $v1, $zero, -1
    addi    $a0, $zero, -1
    addi    $a1, $zero, -1
    addi    $a2, $zero, -1
    addi    $a3, $zero, -1
    addi    $k0, $zero, -1
    addi    $k1, $zero, -1
    jr      $ra
    
Exit:
    ori     $v0, $0, 10
    syscall

Swap_Case:
    #TODO: write your code here, $a0 stores the address of the string

    addiu $sp $sp -12 # make space on the stack
    sw $ra 0($sp) # store memory address of where function was called
    sw $s0 4($sp) # store $s0 on the stack
    sw $s1 8($sp) # store $s1 on the stack

    move $s0 $a0
    addi $s0 $s0 -1 #move the pointer back one so we can start the loop with incrementing

swap_loop:

    addi $s0 $s0 1
    lbu $s1 ($s0)

    beq $s1 $zero Swap_Case_cont # if the string is empty, leave the loop

    li $t0 65 #less than 'A' = 65
    blt $s1 $t0 swap_loop

    li $t0 122 #greater than 'z' = 122
    bgt $s1 $t0 swap_loop

    li $t0 90 # assume > 'A', so if <= 'Z' then the char is A-Z
    ble $s1 $t0 continue_loop

    li $t0 97 # assume > 'Z' and <= 'z', so if >= 'a' then the char is a-z
    bge $s1 $t0 continue_loop

    j swap_loop # character is not a letter, so restart loop and go to next char

continue_loop:

    li $v0 11 #print char
    move $a0 $s1
    syscall
    li $v0 4 #print newline
    la $a0 newline
    syscall
    
    li $t0 97 # if lower_case
    bge $s1 $t0 make_Upper

    li $t0 65 # if upper_case
    bge $s1 $t0 make_Lower
    
make_Upper:
    
    addi $s1 -32 # upper and lower case ascii differ by exactly 32
    sb $s1 ($s0) 

    li $v0 11
    move $a0 $s1
    syscall
    li $v0 4
    la $a0 newline
    syscall

    jal ConventionCheck

    j swap_loop # done with current char

make_Lower:

    addi $s1 32 # upper and lower case ascii differ by exactly 32
    sb $s1 ($s0)

    li $v0 11
    move $a0 $s1
    syscall
    li $v0 4
    la $a0 newline
    syscall

    jal ConventionCheck

    j swap_loop #done with current char


Swap_Case_cont:
    
    lw $s1 8($sp)
    lw $s0 4($sp)
    lw $ra 0($sp)
    addiu $sp $sp 12

    jr $ra
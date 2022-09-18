# Pow.asm program
#

# C++ (NON-RECURSIVE) code snippet of pow(x,n):
#    int x, n, pow=1; 
#   cout << "Enter a number x:\n"; 
#   cin >> x;
#   cout << "Enter the exponent n:\n"; 
#   cin >> n; 
#   for (int i = 1; i <= n; i++) { 
#       pow = pow * x; 
#   } 
#   cout << "Power(x,n) is:\n" << pow << "\n";
#
# Assembly (NON-RECURSIVE) code version of pow(x,n):
#
.data
    promptNum: .asciiz "Enter a number x:\n"
    promptExp: .asciiz "Enter the exponent n:\n"
    finalOutput: .asciiz "Power(x,n) is:\n"
    newspace: .asciiz "\n"


.text
main:
    li $v0 4
    la $a0 promptNum
    syscall

    li $v0 5
    syscall
    move $t0  $v0 # the actual value

    li $v0 4
    la $a0 promptExp
    syscall

    li $v0 5
    syscall
    move $t1  $v0 # exponent

    beq $t1 $zero outputZero
    beq $t0 $zero outputZero

    move $t2 $t1
    li $t3 1

    j loop

    j exit

loop:
    ble $t2 $zero output

    mult $t3 $t0
    mflo $t3

    addi $t2 $t2 -1

    j loop

output:
    li $v0 4
    la $a0 finalOutput
    syscall

    li $v0 1
    move $a0 $t3
    syscall

    li $v0 4
    la $a0 newspace
    syscall

    j exit


outputZero:
    li $v0 4
    la $a0 finalOutput
    syscall

    li $v0 1
    move $a0 $zero
    syscall

    li $v0 4
    la $a0 newspace
    syscall

    j exit

exit:
    li $v0 10
    syscall
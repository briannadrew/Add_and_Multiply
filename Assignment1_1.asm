# Program: Add or Multiply 2 Integers (Assignment 1)
# Name: Brianna Drew
# Username: briannadrew
# Date Created: 01/25/19
# Last Modified: 01/26/19

.data
# messages to be called to be printed out:
prompt1: .asciiz "Enter an Integer! "
prompt2: .asciiz "Enter Another Integer! "
prompt3: .asciiz  "Would you like to add or multiply? (1 for add, 2 for multiply) "
error_op: .asciiz "This is not a + or *, please try again. " 
resultout: .asciiz "The result is: "
.text

main:
	li $s0, 1 # set register $s0 to 1
	li $s1, 2 # set register $s1 to 2
	num1:
		la $a0, prompt1 # load prompt
		li $v0, 4 # prompt user to enter an integer
		syscall 
		li $v0, 5 # read integer from user input
		syscall
		add $t0, $v0, $zero # move integer to $t0 register
	
	num2:
		la $a0, prompt2 # load prompt
		li $v0, 4 # prompt user to enter an integer
		syscall 
		li $v0, 5 # read integer from user input
		syscall
		add $t1, $v0, $zero # move integer to $t1 register
	
	oploop:
		la $a0, prompt3 # load prompt
		li $v0, 4 # prompt user to enter an integer(1 for addition or 2 for multipication)
		syscall
		li $v0, 5 # read integer from user input
		syscall
		add $t2, $v0, $zero # move integer to $t2 register
		bne $t2, $s0, elseop1 # if the operation is not addition, branch to elseop1
		b addition # branch to addition
		elseop1:
			bne $t2, $s1, elseop2 # if the operation is not multipication, branch to elseop2
			b multipication # branch to multipication
		elseop2:
			la $a0, error_op # load error message
			li $v0, 4 # print error message
			syscall
			b oploop # restart loop and ask for integer again
		
	addition:
		add $t3, $t0, $t1 # add the two numbers together and store result in $t3
		b result # branch to result
		
	multipication:
		mulo $t3, $t0, $t1 # multiply the two numbers together and store result in $t3
		b result # branch to result
		
	result:
		la $a0, resultout # load message
		li $v0, 4 # print message introducing resulting integer
		syscall
		move $a0, $t3 # move resulting integer to printable location
		li $v0, 1 # print resulting integer
		syscall
		b end # branch to end
end:
	.macro done # macro definition to end program
	li $v0, 10 # end program
	syscall
	.end_macro
	done # call macro definition to end program
		

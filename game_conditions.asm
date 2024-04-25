	
WIN:	
	.include "win_sound.asm"
	la $a0, winMsg		#display win message if user guess correct
	li $v0, 4		#print string syscall
	syscall
	la $a0, lineBreak	#print a line break
	li $v0, 4		#print string syscall
	syscall
	j CONT			#jump to 'continue playing' option
	
LOSE:	la $a0, loseMsg		#display lose message if all guesses exhausted
	li $v0, 4		#print string syscall
	syscall
	la $a0, lineBreak	#print a line break
	li $v0, 4		#print string syscall
	syscall
	
	.include "lose_sound.asm"
	# Display the correct word
	la $a0, correctWord	# Display message indicating the correct word
	li $v0, 4		# Print string syscall
	syscall
	la $a0, 0($s1)		# Load address of the correct word
	li $v0, 4		# Print string syscall
	syscall
	la $a0, lineBreak	# Print a line break
	li $v0, 4		# Print string syscall
	syscall
	
CONT:	#determine if user wants to play again, restart if yes or exit if no
	la $a0, playAgain	#ask user if they want to keep playing
	li $v0, 4		#print string syscall
	syscall
	
	li $v0, 8		#read string syscall
	la $a0, contHolder	#specify address to hold string input
	li $a1, 4		#max input length (3 here) + 1 for null terminator
	syscall			#stringHolder now holds user input 
	
	la $t0, contHolder	#load address of stored user input
	lw $t1, 0($t0)		#load user input content
	la $t2, yes		#load address of "yes" string
	lw $t3, 0($t2)		#load "yes" string to compare against user response
	
	la $a0, lineBreak	#print a line break
	li $v0, 4		#print string syscall
	syscall
	

    beq $t1, $t3, START


START:  #beginning of game play
	.include "welcome_sound.asm"
	# Display ASCII Wordle Title
    	la $a0, line1
   	li $v0, 4
    	syscall

    	la $a0, line2
    	syscall

    	la $a0, line3
    	syscall

    	la $a0, line4
    	syscall

    	la $a0, line5
    	syscall

    	la $a0, line6
    	syscall

    	la $a0, line7
    	syscall

	la $a0, msgText		#display welcome message
	li $v0, 4		#print string syscall
	syscall

	
	
RAND:   #generates random number to choose word
	li $v0, 30		#get time in ms
	syscall
	
	move $a1, $a0		#move lower 32 bits of time to seed random number generator
	li $a0, 1		#load random generator id
	li $v0, 40		#seed random number generator syscall
	syscall
	
	li $a0, 1		#load id of seeded random number generator
	li $a1, 10		#upper bound of random number
	li $v0, 42		#generate random number syscall
	syscall			#$a0 now holds random number between 0 and 9
	
	move $t0, $a0		#save random number
	li $t1, 16		#load multiplicative factor of 10 for addressing words
	mult $t0, $t1		#multiply random number by 10 to get usable address for chosen word
	mflo $s1		#save the lower 32 bits of result to $s1 to index the word; 
				#since largest possible value is 90, 
				#upper 32 bits shouldn't have any value
	la $a0, bench		#load address of first word in data segment
	add $a0, $a0, $s1	#offset address by random number * 10
	move $s1, $a0           #save word address into $s1 
	
	
	li $t0, 4		#max number of blanks to be printed, minus 1
	li $t1, 0		#clear contents of $t1
	
BLANK:  #prints out four underscores after the first character of chosen word
	bgt $t1, $t0, GAME	#quit and start guess portion if 
				#appropriate number of blanks have been 
	
	addi $t1, $t1, 1	#increment $t1
	j BLANK			#another iteration of BLANK
	
###########################################################################################################
#Start of guessing portion
###########################################################################################################
	
GAME:	#signifies start of guessing portion
	la $a0, lineBreak	#print a line break
	li $v0, 4		#print string syscall
	syscall

	#variables for LOOP, coming up
	li $s0, 5		#max number of guesses allowed, minus 1
	li $t0, 0		#clear contents of $t0 to act as loop induction variable
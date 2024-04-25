LOOP:	bgt $t0, $s0, LOSE	#jump to "lose" message if all guesses have been used
	
	la $a0, enterGuessMsg   #ask user to enter a guess
	li $v0, 4		#print string syscall
	syscall
	
	move $a0, $t0		#copy current guess number to $a0
	addi $a0, $a0, 1	#increment guess number by 1 so it's human-accurate
	li $v0, 1		#print integer syscall
	syscall			#prints guess number
	
	la $a0, colon 		#display a colon
	li $v0, 4		#print string syscall
	syscall
	
	li $v0, 8		#read string syscall
	la $a0, guessHolder	#load address to store string input
	li $a1, 32		#max input length (5 here) + 1 for null terminator
	syscall			#guessHolder now holds user input
	
#####################################################
	#length validation
    
    # Load address of guessHolder into $a0
    la $a0, guessHolder
    
    # Initialize counter for length
    li $t4, 0
    
    # Loop to count characters until null terminator or maximum length
count_loop:
    lb $t1, 0($a0)          # Load byte from address in $a0 into $t1
    beqz $t1, check_length  # If byte is null (end of string), exit loop
    
    addi $t4, $t4, 1        # Increment counter
    
    addi $a0, $a0, 1        # Move to next character in string
    j count_loop            # Jump back to beginning of loop

check_length:
    # Check if length is less than 5
    li $t1, 6
    bne $t4, $t1, input_too_short  # Jump to input_too_short if length is less than 5
    
    
    # Length is less than or equal to 5, continue with program
    # Your code here
   
    
    
    j LOOP2
    
input_too_short:
    # Print error message for input too short
     la $a0, inputShortError
     li $v0, 4
    syscall
    
    # Print prompt
    #li $v0, 4
   # la $a0, prompt
    #syscall

    
    # Loop back to input section
    j LOOP
    

	
##################################################
LOOP2:	
        la $a0, lineBreak	#print a line break
	li $v0, 4		#print string syscall
	syscall
	
	la $t5, guessHolder	#save address of user guess
	
	# Load the base address of the board array into $t6
	la $t6, board

	# Calculate the offset based on the index in $t0
	sll $t8, $t0, 2         # Calculate the offset (each word is 4 bytes)
	add $t8, $t6, $t8       # Add the offset to the base address of the array

	# Load the address of string1 using the calculated offset
	lw $t7, 0($t8)
    	
    	    	    	 # Loop through each character of guessHolder
copy_loop:
    li $t9, '|'             # Load the ASCII code for '|'
    sb $t9, 0($t7)          # Insert vertical line before the first character
    addi $t7, $t7, 1        # Increment string1 pointer

    lb $t8, 0($t5)          # Load character from guessHolder
    beqz $t8, copy_done     # If character is null terminator, exit loop
    
    sb $t8, 0($t7)          # Store character into string1
    addi $t7, $t7, 1        # Increment string1 pointer
        
    addi $t5, $t5, 1        # Increment guessHolder pointer
    j copy_loop

copy_done:
    
    # Insert line break
    li $t9, '\n'            # Load the ASCII code for line break
    sb $t9, 0($t7)          # Store line break into string1
    addi $t7, $t7, 1        # Increment string1 pointer

    # Terminate string1 with null character
    sb $zero, 0($t7)
    la $t5, guessHolder # Load the address of guessHolder into $t5 again

    
    
        
	# Display the ASCII board ######################################################################
	la $a0, lineInBetween # Load the address of the ASCII line
	li $v0, 4          # Load the print string syscall code
	syscall			# Execute the syscall to print the ASCII line
	
	lw $a0, 0($t6)
	li $v0, 4
    	syscall
    	
    	la $a0, lineInBetween # Load the address of the ASCII line
	li $v0, 4          # Load the print string syscall code
	syscall			# Execute the syscall to print the ASCII line
	lw $a0, 4($t6)
	li $v0, 4
    	syscall
    	
    	la $a0, lineInBetween # Load the address of the ASCII line
	li $v0, 4          # Load the print string syscall code
	syscall			# Execute the syscall to print the ASCII line	
	lw $a0, 8($t6)
	li $v0, 4
    	syscall
    	
    	la $a0, lineInBetween # Load the address of the ASCII line
	li $v0, 4          # Load the print string syscall code
	syscall			# Execute the syscall to print the ASCII line
	lw $a0, 12($t6)
	li $v0, 4
    	syscall
    	
    	la $a0, lineInBetween # Load the address of the ASCII line
	li $v0, 4          # Load the print string syscall code
	syscall			# Execute the syscall to print the ASCII line	
	lw $a0, 16($t6)
	li $v0, 4
    	syscall
    	
	
	
	
	#variables for CHECK loop, coming up
	li $s3, 0		#clears $s3 for safety across multiple plays;
				#to be used for right character, right place
	li $t3, 0		#clears $t3 for safety across multiple plays;
				#to be used as CHECK loop induction variable
				
######################################################################################
#Loop through each character of guess
######################################################################################

CHECK:	#loops over characters of guess and compares


	li $s0, 4

	bgt $s3, $s0, WIN	#jump to win message if all characters in right place
				#(i.e. if RCRP counter > 4)
	bgt $t3, $s0, AFTER	#skip rest of loop if all characters have been checked
				#(i.e. if loop induction variable is greater than 4)
	add $t4, $t3, $t5	#increment address of guess by offset, store in $t4
	lb $t4, 0($t4)		#load correct character of guess into $t4
	add $s4, $t3, $s1	#increment address of number by offset, store in $s4
	addi $s4, $s4, 8	#increase offset to correspond to same character in lower case
				#for comparison
	lb $s4, 0($s4)          #load correct character of word into $s4
	beq $t4, $s4, RCRP	#jump to code handling right color, right place if character
				#from guess at current index is equal to character from word
				#at current index
				
	li $s5, 0		#loop induction for EACH, coming up
	
#################################################################
#Compare one character of guess against each character of word
#################################################################

EACH:	#check one character of guess against each character of word
	bgt $s5, $s0, INC	#if loop induction variable is greater than
				#4 (i.e. total number of characters in word - 1),
				#skip to incrementing outer CHECK loop
	beq $s5, $t3, SKIP	#if current offset is the same as the offset that indexes
				#the guess character's current place, skip to next iteration
				#of EACH(avoids double-counting)
	add $s4, $s5, $s1	#increment address of word by offset, store in $s4
	addi $s4, $s4, 8	#increase offset by 8 to index corresponding word
				#character in lowercase version
	lb $s4, 0($s4)		#store correct character of word into $s4
	beq $s4, $t4, RCWP	#if the given guess character is equal to the word character
				#indexed at the current iteration, jump to 
				#code that handles right character, wrong place
	
SKIP:	#utility jump point to allow skipping index that was already checked 
	addi $s5, $s5, 1	#increment $s5
	j EACH			#another iteration of EACH
	
	j INC			#keep from jumping to RCRP or RCWP if
				#correct characters not found after EACH finishes
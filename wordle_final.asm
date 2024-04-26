.data
#CS2340 - Wordle Project
#By: Jeremiah Boban, Veer Shah, Vasudev Nair, Sourish Pasula
#-----------------------------------------------------------------------------------------------------------------------

.data
	line1: .asciiz " __          ______  _____  _____  _      ______ \n"
	line2: .asciiz " \\ \\        / / __ \\|  __ \\|  __ \\| |    |  ____|\n"
	line3: .asciiz "  \\ \\  /\\  / / |  | | |__) | |  | | |    | |__   \n"
	line4: .asciiz "   \\ \\/  \\/ /| |  | |  _  /| |  | | |    |  __|  \n"
	line5: .asciiz "    \\  /\\  / | |__| | | \\ \\| |__| | |____| |____ \n"
	line6: .asciiz "     \\/  \\/   \\____/|_|  \\_\\_____/|______|______|\n"
	line7: .asciiz "                                                 \n"

	msgText: .asciiz "Welcome to Wordle!"
	msgTextWord: .asciiz "The word to guess is: "
	correctWord: .asciiz "The correct word is: "
	lineInBetween: .asciiz "===========\n"
	
	blankChar: .asciiz " _ "
	lineBreak: .asciiz "\n"
	debugMsg1: .asciiz "Copying addresses: \n"
	
	

	
	
# Define ascii board
.align 2
string1: .asciiz "| | | | |  \n"
.align 2
string2: .asciiz "| | | | |  \n"
.align 2
string3: .asciiz "| | | | |  \n"
.align 2
string4: .asciiz "| | | | |  \n"
.align 2
string5: .asciiz "| | | | |  \n"
	
.align 2
initial_string1: .asciiz "| | | | |  \n"
.align 2
initial_string2: .asciiz "| | | | |  \n"
.align 2
initial_string3: .asciiz "| | | | |  \n"
.align 2
initial_string4: .asciiz "| | | | |  \n"
.align 2
initial_string5: .asciiz "| | | | |  \n"

# Define array to store addresses of strings
board:
   	.word string1
    	.word string2
    	.word string3
    	.word string4
    	.word string5
    	

.align 2	
	bench: .asciiz "BENCH"
.align 2	
	benchLC: .asciiz "bench"
.align 2	
	crate: .asciiz "CRATE"
.align 2	
	crateLC: .asciiz "crate"
.align 2	
	frame: .asciiz "FRAME"
.align 2	
	frameLC: .asciiz "frame"
.align 2	
	gauge: .asciiz "GAUGE"
.align 2	
	gaugeLC: .asciiz "gauge"
.align 2	
	hands: .asciiz "HANDS"
.align 2	
	handsLC: .asciiz "hands"
.align 2	
	juice: .asciiz "JUICE"
.align 2	
	juiceLC: .asciiz "juice"
.align 2	
	loans: .asciiz "LOANS"
.align 2	
	loansLC: .asciiz "loans"
.align 2	
	mouse: .asciiz "MOUSE"
.align 2	
	mouseLC: .asciiz "mouse"
.align 2	
	power: .asciiz "POWER"
.align 2	
	powerLC: .asciiz "power"
.align 2	
	state: .asciiz "STATE"
.align 2	
	stateLC: .asciiz "state"
.align 2
	apple: .asciiz "APPLE"
.align 2
	appleLC: .asciiz "apple"
.align 2
	bunny: .asciiz "BUNNY"
.align 2
	bunnyLC: .asciiz "bunny"
.align 2
	clock: .asciiz "CLOCK"
.align 2
	clockLC: .asciiz "clock"
.align 2
	drift: .asciiz "DRIFT"
.align 2
	driftLC: .asciiz "drift"
.align 2
	frost: .asciiz "FROST"
.align 2
	frostLC: .asciiz "frost"
.align 2
	glint: .asciiz "GLINT"
.align 2
	glintLC: .asciiz "glint"
.align 2
	hazel: .asciiz "HAZEL"
.align 2
	hazelLC: .asciiz "hazel"
.align 2
	jumbo: .asciiz "JUMBO"
.align 2
	jumboLC: .asciiz "jumbo"
.align 2
	knack: .asciiz "KNACK"
.align 2
	knackLC: .asciiz "knack"
.align 2
	lucky: .asciiz "LUCKY"
.align 2
	luckyLC: .asciiz "lucky"
.align 2
	mirth: .asciiz "MIRTH"
.align 2
	mirthLC: .asciiz "mirth"
.align 2
	novel: .asciiz "NOVEL"
.align 2
	novelLC: .asciiz "novel"
.align 2
	opera: .asciiz "OPERA"
.align 2
	operaLC: .asciiz "opera"
.align 2
	enterGuessMsg: .asciiz "Guess a five letter word "
	colon: .asciiz ": "
	rightPlace: .asciiz " is in the right place"
	wrongPlace: .asciiz " is in the word but not the right place"
	
	winMsg: .asciiz "WHOOSH! You win!"
	loseMsg: .asciiz "BUMMER! Out of guesses! You lose!"
	
	playAgain: .asciiz "Play again?(yes/no) "
	yes: .asciiz "yes"
	goodbye: .asciiz "Thank you for playing! Goodbye!"
	contHolder: .space 4
  
	blankGuessHolder: .asciiz "      "
	dictionary: .asciiz "dictionary.txt"
  
	guessHolder: .space 32
	len: .word 5                 # The length to compare to
	inputShortError: .asciiz "Input length is incorrect. Please enter 5 characters.\n"
	inputLongError: .asciiz "Input length is too long. Please enter only 5 characters.\n"

#####################################################################################################################################

.text
.include "setup.asm"
	
#################################################################################################
#Loop through guesses	

#################################################################################################

.include "word_validation.asm"
	
###############################################################
#End comparing one guess character against each word character
###############################################################

RCRP:   #displays appropriate message if a character from guess is in the
	#right place	
	add $a0, $s1, $t3	#increment address of word by offset, store in $a0
	lb $a0, 0($a0)          #store correctly guessed character of word,
				#pulled from uppercase version, into $a0
	li $v0, 11		#print character syscall
	syscall
	
	la $a0, rightPlace	#display right place message
	li $v0, 4		#print string syscall
	syscall
	
	la $a0, lineBreak	#print a line break
	li $v0, 4		#print string syscall
	syscall
	
	addi $s3, $s3, 1	#increment RCRP counter
	
	j INC			#skip to incrementing CHECK
	
RCWP:   #displays appropriate message if a character from guess is valid but
	#is in the wrong place
	add $a0, $s1, $s5       #increment word address by iterative offset, store in $a0
	lb $a0, 0($a0)	        #store character of word that is correct but in wrong place,
				#pulled from uppercase version
	li $v0, 11		#print character syscall
	syscall
	
	la $a0, wrongPlace	#display wrong place message
	li $v0, 4		#print string syscall
	syscall
	
	la $a0, lineBreak	#print a line break
	li $v0, 4		#print string syscall
	syscall

INC:	#utility jump point to build condition gating for case of 
	#right character wrong place vs. right character wrong place
	addi $t3, $t3, 1	#increment $t3
	j CHECK			#another iteration of CHECK

##################################################################################
#End loop through characters of guess
##################################################################################
	
	
AFTER:	#jumps here if check is finished
	addi $t0, $t0, 1	#increment $t0
	j LOOP			#another iteration of LOOP

#############################################################################################
#End loop through guesses
#############################################################################################
.include "game_conditions.asm"
	

	
EXIT:	la $a0, goodbye		#display goodbye message
	li $v0, 4		#print string syscall
	syscall
	
	li $v0, 10		#exit program syscall
	syscall

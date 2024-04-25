.data
notes: 
.word 75, 74, 73, 72
 
# Let one eighth note (the shortest duration in the tune) be denoted 1, 
# quarter notes etc are multipliers of this duration
.word 1, 1, 1, 1
       
 # Indicator of whether the note should be played synchronously 
 # (syscall 33 when 0/false) or return asynchronously (syscall 31 when 1/true)
async:
.byte 0, 0, 0, 0
       
length: .word 4 # The length of the song (number of notes) stored in memory
 
 
.text

main:
  la   $s0, notes      # Initialize the pointer
  
  li   $s4, 200        # Duration of base (i.e., eighth) note in milliseconds
  
  lw   $a0, 0($s0)     # Load notes[0]    
  move $a1, $s4        # Set duration of note 
  li   $a2, 0          # Set the MIDI patch [0-127] (zero is basic piano)
  li   $a3, 64         # Set a moderate volume [0-127]
  li   $v0, 33         # Asynchronous play sound system call
  syscall              # Play the note
  
  # Registers $a0, $a1, $a2, $a3, and $v0 are not guaranteed to be preserved 
  # across the system call, so we must set their values before each call 
  
  lw   $a0, 4($s0)     # Load notes[1]    
  move $a1, $s4
  li   $a2, 0
  li   $a3, 64
  li   $v0, 33
  syscall

  lw   $a0, 8($s0)     # Load notes[2]    
  move $a1, $s4
  li   $a2, 0
  li   $a3, 64
  li   $v0, 33
  syscall

  lw   $a0, 12($s0)    # Load notes[3]    
  move $a1, $s4
  li   $a2, 0
  li   $a3, 64
  li   $v0, 33
  syscall

  lw   $a0, 16($s0)    # Load notes[4]    
  move $a1, $s4
  li   $a2, 0
  li   $a3, 64
  li   $v0, 33
  syscall

    
  li $v0, 10 # exit
  syscall
 

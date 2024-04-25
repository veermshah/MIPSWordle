.data
notes:
.word 76, 75, 76, 75, 76, 71, 74, 72, 69, 45, 52, 57, 60, 64, 69, 71, 40, 56, 
      59, 64, 68, 71, 72, 45, 52, 57, 64, 76, 75, 76, 75, 76, 71, 74, 72, 69,
      45, 52, 57, 60, 64, 69, 71, 40, 56, 59, 64, 72, 71, 69, 45, 52, 57
 
# Let one eighth note (the shortest duration in the tune) be denoted 1, 
# quarter notes etc are multipliers of this duration
durations:
.word 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 2, 1, 
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 
      1, 6, 2, 2, 3
       
 # Indicator of whether the note should be played synchronously 
 # (syscall 33 when 0/false) or return asynchronously (syscall 31 when 1/true)
async:
.byte 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0,  
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 
      0, 1, 0, 0, 0   
       
length: .word 53 # The length of the song (number of notes) stored in memory
 
 
.text

main:
  la   $s0, notes      # Initialize the pointer
  
  li   $s4, 150        # Duration of base (i.e., eighth) note in milliseconds
  
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
 
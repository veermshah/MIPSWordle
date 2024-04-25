.data
notes2:
.word 76, 75, 76, 75, 76, 71, 74, 72, 69, 45, 52, 57, 60, 64, 69, 71, 40, 56, 
      59, 64, 68, 71, 72, 45, 52, 57, 64, 76, 75, 76, 75, 76, 71, 74, 72, 69,
      45, 52, 57, 60, 64, 69, 71, 40, 56, 59, 64, 72, 71, 69, 45, 52, 57
length2: .word 53 # The length of the song (number of notes) stored in memory

.text
main:
  la   $s0, notes2      # Initialize the pointer
  lw   $s1, length2     # Load the length of the song
  li   $s4, 200        # Duration of base (i.e., eighth) note in milliseconds
  li   $s2, 0          # Initialize the note counter

play_notes:
  beq  $s2, $s1, exit  # If we've played all the notes, exit

  lw   $a0, 0($s0)     # Load the current note
  move $a1, $s4        # Set duration of note 
  li   $a2, 0          # Set the MIDI patch [0-127] (zero is basic piano)
  li   $a3, 64         # Set a moderate volume [0-127]
  li   $v0, 33         # Asynchronous play sound system call
  syscall              # Play the note

  addiu $s0, $s0, 4    # Move the pointer to the next note
  addiu $s2, $s2, 1    # Increment the note counter
  j play_notes         # Jump back to the start of the loop

exit:
  li $v0, 10 # exit
  syscall

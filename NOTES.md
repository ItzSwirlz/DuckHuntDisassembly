This keeps notes of things - soon nesgodisasm will hopefully have a way to automatically rename the variables when disassembling so we don't have to keep finding/replacing what we know

# Misc
SELECTEDGAMEMODE = $05FE ; 0 = a, 1 = b, 2 = c

# Score
The score is set by three variables, each representing 2 places in the score. I name them A (first 2), B (middle 2), C (last 2)
12 | 34 | 56
A  | B  | C
SCOREA = $00C4
SCOREB = $00C5
SCOREC = $00C6

# Coordinates of things?
_var_000f = $000F ; duck/dog X value??
_var_0010_indexed = $0010 ; duck/dog Y value??

# Controls
Just like in the SMB disassembly, it looks like each port has its own variable for tracking button presses.

I see in the emulator this appears as $0016; so lets be careful with what we think are named vars

JOYPAD1 = $4016
JOYPAD2 = $4017

## Single Button press
A = 0x80
B = 0x40
Up = 0x08
Down = 0x04
Left = 0x02
Right = 0x01
Select = 0x20
Start = 0x10
Nothing pressed = 0x0
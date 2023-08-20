This keeps notes of things - soon nesgodisasm will hopefully have a way to automatically rename the variables when disassembling so we don't have to keep finding/replacing what we know

# Misc
SCORE = $00C4


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
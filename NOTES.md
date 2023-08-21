This keeps notes of things - soon nesgodisasm will hopefully have a way to automatically rename the variables when disassembling so we don't have to keep finding/replacing what we know

# Misc
SELECTEDGAMEMODE = $05FE ; 0 = a, 1 = b, 2 = c

## Needs naming/confirmation
DOGANIMATION = $00BD ; In single duck mode, the game sets this to 0x1 in between the time the duck dies, in between to when the next duck is flying. Probably used as a pause variable. Oddly enough, if set to 0x01 all the time in a cheat, the dog always catches; even if you do NOTHING. But, the game does not count the duck as actually *caught*, even if you hit it. Vice-versa for 0x0 - even if you shoot the duck, the dog will think you missed it. Setting to 0xFF, the dog thinks you caught both ducks (yes, both ducks, even in 1-duck mode.) So I don't know what to name this - but it definitely determines what the dog does.

# Game Phase?? (Unconfirmed, I need to check this)
PHASE = $0031
Being set to 01 shows the "ROUND" number
Being set to 02 shows the dog spawns
Being set to 03 the dog is walking. Fun fact- it has no "STOP" coordinates, so it will keep walking, then when off screen the pixels just appear on the other side LOL
Being set to 05 the dog sniffs (yes, really), then will start its jump. If being forced afterwords, then it shows ducks moving around?
Being set to 06 the dog gets EXCITED, holds out his tounge wide
Being set to 07 the duck is turning again?
Being set to 04, 08 does nothing, higher than that causes overflow

# Background/graphics
BACKGROUNCOLOR = $0403 ; ??? I'm not sure yet, I just know changing this affects the bg color. 0x21 is the default blue, 0x36 is the "FLY AWAY" red.

You can see here how the background color is set to red:
```asm
_func_cf96:
  lda z:_var_00bd                ; $CF96  A5 BD
  bne _label_cfb9                ; $CF98  D0 1F
  lda #$06                       ; $CF9A  A9 06
  jsr _func_d464                 ; $CF9C  20 64 D4
  lda #$30                       ; $CF9F  A9 30
  sta z:_var_002b_indexed        ; $CFA1  85 2B
  lda #$06                       ; $CFA3  A9 06
  sta z:_var_0023                ; $CFA5  85 23
  lda #$01                       ; $CFA7  A9 01
  sta z:_var_0027                ; $CFA9  85 27
  lda #$36                       ; $CFAB  A9 36 ;; loading 0x36!
  sta a:BACKGROUNDCOLOR        ; $CFAD  8D 03 04 ;; storing 0x36 to BACKGROUNDCOLOR unless im dumb at reading 6502 asm
```

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
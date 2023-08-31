This keeps notes of things - soon nesgodisasm will hopefully have a way to automatically rename the variables when disassembling so we don't have to keep finding/replacing what we know

This information is also built atop of [an existing RAM map](https://datacrystal.romhacking.net/wiki/Duck_Hunt:RAM_map). This is primarily *new* knowledge/mysteries that I've had while working through this.

# Needs naming/confirmation
DOGANIMATION = $00BD ; In single duck mode, the game sets this to 0x1 in between the time the duck dies, in between to when the next duck is flying. Probably used as a pause variable. Oddly enough, if set to 0x01 all the time in a cheat, the dog always catches; even if you do NOTHING. But, the game does not count the duck as actually *caught*, even if you hit it. Vice-versa for 0x0 - even if you shoot the duck, the dog will think you missed it. Setting to 0xFF, the dog thinks you caught both ducks (yes, both ducks, even in 1-duck mode.) So I don't know what to name this - but it definitely determines what the dog does.

# Gameplay

## Game phase.. in different ways.
The way the game controls the sprites (the ducks/the dog) is through what's probably a phase; for example, the dog walking has phases for walking straight, sniffing, smelling something interesting, turning its head, jumping over the grass, etc. but it's also used in the game with how the ducks react, and how the dog pops up when it 'catches' the duck you shot.

For now, I'm calling this the 'SpritePhase'. Not sure if its a game phase, but some things (like the "ROUND" number being shown) revolves around this variable.

PHASE = $0031
Being set to 01 shows the "ROUND" number
Being set to 02 shows the dog spawns
Being set to 03 the dog is walking. Fun fact- it has no "STOP" coordinates, so it will keep walking, then when off screen the pixels just appear on the other side LOL
Being set to 05 the dog sniffs (yes, really), then will start its jump. If being forced afterwords, then it shows ducks moving around? I think it's also set to 5 when the duck freezes for like, the half second
Being set to 06 the dog gets EXCITED, holds out his tounge wide
Being set to 07 the duck is turning again? In gameplay, the duck is falling at this point.
Being set to 04, 08 does nothing, higher than that causes overflow

## The targets
It looks like the game will not progress past:
- if you shoot the duck and it falls
- if the dog shows it caught the duck

if $00BC is set to 0x1. Might be basically some boolean value. Setting it to "TargetFinishedFalling"

When shooting a target, at least for the ducks in single player, $00BD is set to 1 until TargetFinishedFalling is reset.

### Ducks flying away
If the duck flies away, 004E seems to be set to 01. Using cheats, if forced to 00, the background will stay blue, and the duck wont leave the screen. Being set to 01 all the time has the ducks continue to fly in their normal direction, but not vertically when they should 'fly away.'. So what I think this is, is just a boolean as to whether the duck is leaving the screen - this can be triggered when the time runs up.

## The bottom bar
I assume, you reading this, you know how it works; it blinks the duck #, if you hit it, its red, otherwise it goes to the next one. Then, in a nerdly satisfying way, it shifts all the ducks you hit to see if its enough to keep the game going.

(TODO: Confirm the starting value)
I found out $00BB is the number of the duck that is blinking. Interestingly I think it starts at 0x1, which matches in human-readable decimal what duck number is being looked at.

It's not a good name but fo now its CurrentActiveDuckTarget.

### 00BE
This was fun to figure out! The game has a 'counter' for how long the game has to wait for the audio to play when the round ends succesfully. When it doesn't, it gets set to 01.. then idk

## Background/graphics
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

## Score
The score is set by three variables, each representing 2 places in the score. I name them A (first 2), B (middle 2), C (last 2)
12 | 34 | 56
A  | B  | C
SCOREA = $00C4
SCOREB = $00C5
SCOREC = $00C6

## Pausing/Transitions
It looks like $0025 is set to 0x16 when paused; then I see it change a few values afterwards. I'll need to investigate this, but this is definitely, confirming with cheats, the way of saying "Stop updating the screen". Other values like 07 just send you back to the main menu. Except.. When set to 0x4, when clicking into a game, the game plays its "You shot enough ducks onto the next round" sound! 03 just gives a blue background. Setting to 0D pauses and then starts shooting clay.. even on the duck stage. This value has more to it i just dont know whats happening atm.

## Coordinates of things?
_var_000f = $000F ; duck/dog X value??
_var_0010_indexed = $0010 ; duck/dog Y value??

## Colors
I believe the PaletteTable is at _data_e5ee. I also found DogColor = 003C.

# Controls
Just like in the SMB disassembly, it looks like each port has its own variable for tracking button presses. However there are some oddities...

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

## Ignoring shots
You may notice when the dog is showing it caught the duck you shot, the game will seem to ignore the fact you are shooting and wont affect your ammo/make the screen black.

With an emulator I can tell $00B9 is 0 when its ignoring shots, 1 when its taking it. This even goes for the main menu - forcing to 0, clicking/using the Zapper does nothing. Setting it to 01 though, if going into the game by it, will make the dog instantly spawn with its "oops" look, but if pausing like, after waiting, the game seems to run normally, but then if you wait for a duck to fly, and set this value to 0, it wont change from the "FLY AWAY" screen. This would make sense to be a value to say if the duck was flying, but with the menu it doesnt add it up.

For now I set TargetActive to $00B9.

## Other oddities
It looks like if, in the main menu at least, select is pressed, $05FD becomes 0x1 for the time select is being pressed. Maybe it was hard to keep accessing the same thing in JOYPAD1 to get the select button so this is like a typedef/alias of the button. For now 05FD is SelectButtonDown. Same goes respectively for 05FC and the start button.

# Main Menu
SELECTEDGAMEMODE = $05FE ; 0 = a, 1 = b, 2 = c

## $MENUACTION
This is the code of the main menu:
```asm
_label_c14e:
  lda #$00                       ; $C14E  A9 00
  sta a:_var_05ff                ; $C150  8D FF 05
  lda #$01                       ; $C153  A9 01
  sta z:_var_00b9                ; $C155  85 B9
  sta z:_var_00ba                ; $C157  85 BA
  lda z:_var_0026                ; $C159  A5 26
  beq _label_c18d                ; $C15B  F0 30
  jsr _func_d131                 ; $C15D  20 31 D1
  jsr _func_d160                 ; $C160  20 60 D1
  lda a:_var_05ff                ; $C163  AD FF 05
  cmp #$01                       ; $C166  C9 01
  beq _label_c176                ; $C168  F0 0C
  cmp #$02                       ; $C16A  C9 02
  beq CycleGameMode                ; $C16C  F0 2B
  lda z:_var_0016_indexed        ; $C16E  A5 16
  and #$30                       ; $C170  29 30
  cmp #$10                       ; $C172  C9 10
  bne _label_c189                ; $C174  D0 13
```
We see $05FF is loaded to 0.. and then it checks if its loaded to 01. So I forced some values and I was.. surprised on what I got.
0x0 = No change, probably normal
0x1 = Game selected - by default it will assume that start has been pressed? When using cheats, it will automatically dump you into Game A on soft reset/
0x2 = The cursor spam cycles through the selectable gamemodes as fast as possible. This would be done with select though, which is weird
0x3 or higher: Pressing start will make the screen go gray and back to the main menu, but it doesn't reset.

So I think this is basically a way of telling the menu what to do next, whether to jump into the game or cycle. This isnt controller input, it's probably controller -> variable -> _label_c14e. So I'll name this variable MENUACTION - basically what the menu is doing. 

# Data (Palettes, audio, etc)
- Palette/PPU/even Sprite color-related data happen to be set at the same location, data $33E5.
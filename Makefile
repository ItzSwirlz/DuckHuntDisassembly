build:
	ca65 duckhunt.asm -o duckhunt.world.o
	ld65 -C ld65.cfg -o duckhunt.world.nes duckhunt.world.o
CRC32 := $(shell crc32 duckhunt.world.nes)
build:
	ca65 duckhunt.asm -o duckhunt.world.o
	ld65 -C ld65.cfg -o duckhunt.world.nes duckhunt.world.o

	@if [ "$(CRC32)" = "4644085e" ]; then \
		echo "duckhunt.world.nes: Ok!"; \
	else \
		echo "duckhunt.world.nes: CRC32 does not match! This is expected if you are making adjustments to the ROM for modding. Expected 4644085e, Got $(CRC32)"; \
	fi

clean:
	rm duckhunt.world.*
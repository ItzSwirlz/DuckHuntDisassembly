# Duck Hunt Disassembly
WIP Disassembly of Duck Hunt (1984)

For now, my goal is to do what appears to be the 'World' release, crc32 `4644085e`.

I'm trying something new that exists! I'm using [nesgodisasm](https://github.com/retroenv/nesgodisasm) to generate the assembly files, which means the primary work will be creating a fully complete CDL (Code/Data Log) file of the game, that can be made using an emulator. Soon I'll implement disassembling in the Makefile with this.

# Building
Simply type `make`. It should produce an output file with the CRC-32 checksum of `4644085e`.

`ld65.cfg` is the config file used by ca65's linker, ld65 for memory mapping. Thankfully, nesgodisasm is amazing, and in debug mode will tell you what the config is, so periodically the file will need to be updated.
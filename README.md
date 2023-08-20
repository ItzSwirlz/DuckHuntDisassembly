# Duck Hunt Disassembly
WIP Disassembly of Duck Hunt (1984)

For now, my goal is to do what appears to be the 'World' (JUE) release, crc32 `4644085e`, sha1sum `8e18068823635a115e2fc0925ff3bda209ec6a42`.

I'm trying something new that exists! I'm using [nesgodisasm](https://github.com/retroenv/nesgodisasm) to generate the assembly files, which means the primary work will be creating a fully complete CDL (Code/Data Log) file of the game, that can be made using an emulator. Soon I'll implement disassembling in the Makefile with this.

# Building
Simply type `make`. It should produce an output file with the CRC-32 checksum of `4644085e`.

`ld65.cfg` is the config file used by ca65's linker, ld65 for memory mapping. Thankfully, nesgodisasm is amazing, and in debug mode will tell you what the config is, so periodically the file will need to be updated.

# Contributing
With a more complete CDL file, the more nesgodisasm can tell what is data vs. code. Running TAS's, or running through every detail of the game is what's best. There will probably eventually be a full one, but for now I have put a WIP CDL in 'wipcdl.cdl'.

For understanding variables, what I found best was using a RAM viewer, such as the one in FCEUX, and noticing when it changes. Then, if I had an idea of what it was, I would add a cheat for it and give it a name. Once I confirmed what it was (for me, the first thing was the score), I tried injecting values to confirm the results. The more variables we have names for, the more we can extrapolate from.

Feel free to send any PR! If you want to contact me, my public email is `itzswirlz2020@outlook.com`, and I am also in a handful of decompilation discords.
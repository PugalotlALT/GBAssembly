# GBAssembly
GBASSEMBLY: A pun of GBA and Assembly (not Assembly for the GameBoy)

An attempt at making a GBA program in Assembly. Currently has examples for Bitmap (Mode 3) and Sprites (Mode 0).
Compiled using [vasm](http://sun.hasenbraten.de/vasm/index.php?view=binrel) (vasmarm_std_Win64.zip, but others might work)

## Compiling
Compile this program using the command:
```
vasmarm_std.exe main.asm -m7tdmi -noialign -chklabels -nocase -Fbin -o program.gba
```

## Running
This code should run on most GBA emulators
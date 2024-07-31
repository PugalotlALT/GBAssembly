# GBAssembly
GBASSEMBLY: A pun of GBA and Assembly (not Assembly for the GameBoy)

An attempt at making a GBA program in Assembly. Currently only displays a blue screen.
Compiled using [FASMARM](https://gbadev.org/tools.php?showinfo=1399)

## Compiling
Compile this program using the command:
```
vasmarm_std_win32.exe main.asm -m7tdmi -noialign -chklabels -nocase -Fbin -o program.gba
```

## Running
This code currently only runs under VisualBoyAdvance
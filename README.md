# GBAssembly
GBAssembly: A pun of GBA and Assembly (not Assembly for the GameBoy)

An attempt at making a GBA program in Assembly. Currently has examples for Bitmap (Mode 3) and Sprites (Mode 0).
Compiled using [vasm](http://sun.hasenbraten.de/vasm/index.php?view=binrel) (vasmarm_std_Win64.zip, but others might work)

## Compiling
Compile this program using the command:
```
vasmarm_std.exe main.asm -m7tdmi -noialign -chklabels -nocase -Fbin -o program.gba
```

## Running
This code should run on most GBA emulators such as [mGBA](https://mgba.io/), or through your browser using [Gbajs3](https://gba.nicholas-vancise.dev/)

## Tools
As well as code, this repository contains some tools to help with making GBA games, such as:
* ```generate_header.py```

  + Generates a valid header given the game name, game code and maker code.

## Resources
Here are some of the resources I consulted to make these demos
* [ChibiAliens](https://www.chibialiens.com/arm/gba.php)

  + Contains a variety of tutorials on Assembly for the GBA, as well as [AkuSprite Editor](https://www.chibiakumas.com/akusprite/), which I used to make the sprites for these demos
  
* [TONC](https://www.coranac.com/tonc/text/toc.htm)

  + Written for C, but gives insightful information into the workings of the GBA, such as the screen modes and software interrupts
  
* [GBATEK](https://problemkaputt.de/gbatek-gba-reference.htm)

  + A directory of all the inner workings of the GBA, such as the header layout
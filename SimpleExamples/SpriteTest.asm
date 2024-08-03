.org 0x08000000

b SetThumbMode

.incbin "./header.bin"
	
SetThumbMode:
	adr r0,Program		;Loads the program address
	add r0,r0,#1		;Adds one to set the first bit to 1 (enter THUMB mode)
	bx r0				;Jumps to the address in r0

	.thumb

Program:
	ldr r0,StackAddress
	mov sp, r0				;Sets up the stack (unused)

	ldr r0, DisplayAddress
	ldr r1, Mode0BG2
	str r1, [r0,#0]			;Sets the GBA screen mode to Mode 0 (tiles / backgrounds) on Background 0
	
	ldr r0, BG0ControlAddress
	ldr r1, BG0Control
	str r1, [r0,#0]
	
	adr r0, SpritePallete
	ldr r1, SpritePalleteAddress
	mov r2, #32
	bl Copy16Bit			;Loads palletes to the pallete address
	
	ldr r1, TilePalleteAddress
	bl Copy16Bit			;Also loads palletes to the tile address
	
	adr r0, Tiles
	ldr r1, TileAddress
	ldr r2, TilesLength
	bl Copy16Bit			;Loads tiles to the tile address
	
	adr r0, Tiles
	ldr r1, BGTileAddress
	ldr r2, TilesLength
	bl Copy16Bit			;Loads tiles to the tile address
	
	adr r0, TileMap
	ldr r1, TilemapAddress
	ldr r2, TileMapLength
	bl Copy16Bit			;Loads tilemap to the background
	
	ldr r0, DisplayAddress
	ldr r1, EnableSprites
	str r1, [r0,#0]			;Enable sprites
	
WaitForVBlank:
	ldr r0, VBLankAddress
	ldrh r1, [r0,#0]
	cmp r1, #161
	bne WaitForVBlank
	
	mov r0, #0					;Address object 0
	mov r1, #0b00001000		;Attribute 0, sets Y-position
	mov r2, #0b00010001		;Attribute 1, sets X-position
	mov r3, #0b00000001		;Attribute 2, sets tile type
	bl SetSprite
	
	mov r0, #1					;Address object 1
	mov r1, #0b00001000		;Attribute 0, sets Y-position
	ldr r2, TwoByTwoSprite
	mov r3, #0b11100000
	orr r2, r3
	mov r3, #0b00000010		;Attribute 2, sets tile type
	bl SetSprite

Infinite:
	b Infinite				;Loops forever
	

Copy16Bit:					;Copies from [r0] to [r1] based on the length of r2
	push {r0-r7, lr}		;Stores all the registers before doing the instructions

Copy16BitLoop:
	ldrh r3, [r0, #0]
	add r0, r0, #2
	strh r3, [r1, #0]
	add r1, r1, #2			;Copies from [r0] into r3, then r3 into [r1], incrementing them by two (16 bit words)
	sub r2, r2, #2			;Subtracts two from the length
	bne Copy16BitLoop		;Repeat until the length = 0
	
	pop {r0-r7, pc}		;Restores the registers, setting the PC to the return address
	
SetSprite:				;Sets the attributes of the sprite in r0 to r1, r2, and r3 respectively
	push {r0-r7, lr}
	ldr r4, OAMAddress
	lsl r0, r0, #3			;Same as multiplying by 8
	add r4, r4, r0
	strh r1,[r4,#0]
	add r4, r4, #2
	strh r2,[r4,#0]
	add r4, r4, #2
	strh r3,[r4,#0]
	add r4, r4, #2
	pop {r0-r7, pc}

	.align 4
DisplayAddress:
	.long 0x4000000
	
VRAMAddress:
	.long 0x6000000
	
BGTileAddress:
	.long 0x06004000
	
StackAddress:
	.long 0x3000000
	
TilePalleteAddress:
	.long 0x5000000
	
SpritePalleteAddress:
	.long 0x5000200
	
TileAddress:
	.long 0x6010000
	
TilemapAddress:
	.long 0x6000000
	
BG0ControlAddress:
	.long 0x4000008
	
BG0Control:
	.int 0x0004
	
VBLankAddress:
	.long 0x4000006
	
OAMAddress:
	.long 0x7000000

Mode0BG2:
	.int 0x100
	
EnableSprites:
	.int 0x1140
	
TwoByTwoSprite:
	.int 0b0100000000000000
	
	
SpritePallete:
	.word 0b0000000000000000
	.word 0b0000000000010000
	.word 0b0000001000000000
	.word 0b0000001000010000
	.word 0b0100000000000000
	.word 0b0100000000010000
	.word 0b0100001000000000
	.word 0b0110001100011000
	.word 0b0100001000010000
	.word 0b0000000000011111
	.word 0b0000001111100000
	.word 0b0000001111111111
	.word 0b0111110000000000
	.word 0b0111110000011111
	.word 0b0111111111100000
	.word 0b0111111111111111
	
Tiles:
	.incbin "./Sprites/blank.raw"
	.incbin "./Sprites/smile.raw"
	.incbin "./Sprites/stickman.raw"
	.incbin "./Sprites/flower.raw"
TilesLength:
	.long $ - Tiles
	
TileMap:
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0
TileMapLength:
	.long $ - TileMap
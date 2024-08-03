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
	
Mode0Setup:
	push {r0-r7, lr}
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
	mov r2, #1
	lsl r2, r2, #11 ;Gives 2048
	bl Copy16Bit			;Loads tilemap to the background
	
	ldr r0, DisplayAddress
	ldr r1, EnableSprites
	str r1, [r0,#0]			;Enable sprites
	pop {r0-r7, pc}

	.align 4
DisplayAddress:
	.long 0x4000000
	
ButtonAddress:
	.long 0x4000130
	
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
	.word 0b0000010000100001
	.word 0b0001010100111100
	.word 0b0001011110000101
	.word 0b0100011110011110
	.word 0b0001000101100110
	.word 0b0011001010111011
	.word 0b0000100011000011
	.word 0b0100101110010101
	.word 0b0111011100101111
	.word 0b0111101100111000
	.word 0b0000001111111111
	.word 0b0111110000000000
	.word 0b0111110000011111
	.word 0b0111111111100000
	.word 0b0111111111111111

	
Tiles:
	.incbin "./Sprites/green.raw"
	.incbin "./Sprites/frog.raw"
	.incbin "./Sprites/bgtiles.raw"
	
TilesLength:
	.long $ - Tiles
	
TileMap:
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,5,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,7,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,8,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,10,0,0,0,0,0
	.word 0,0,0,11,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,13,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
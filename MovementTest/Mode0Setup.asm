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
	
SetSpriteDivTwo:		;Calls SetSpriteFull with the X and Y divided by two
	push {r0-r7, lr}
	lsr r2, r2, #1		;Same as integer division by two
	lsr r1, r1, #1
	bl SetSpriteFull
	pop {r0-r7, pc}
	
SetSpriteFull:			;Sets the object at r0 to the X-value of r2, the Y-value of r1 and the sprite of r3 with a flag in r4 for 16x16
	push {r0-r7, lr}
	mov r5, #0b11111111
	lsl r5, r5, #1
	add r5, r5, #1		;Sets to 9 1's
	and r3, r5			;Max 9 bits for sprite
	lsr r5, r5, #1
	and r2, r5			;Max 8 bits for X
	lsr r5, r5, #1
	and r1, r5			;Max 7 bits for Y
	cmp r4, #0
	beq SkipTwoByTwo
	ldr r5, TwoByTwoSprite		;OR's X-value with 2x2 flag for high bits
	orr r2, r5 
SkipTwoByTwo:
	bl SetSprite
	pop {r0-r7, pc}
	
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
.include "./Addresses.asm"
.include "./Sprites.asm"
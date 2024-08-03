.org 0x08000000

b SetThumbMode

.incbin "./header.bin"
	
SetThumbMode:
	adr r0,Program		;Loads the program address
	add r0,r0,#1		;Adds one to set the first bit to 1 (enter THUMB mode)
	bx r0				;Jumps to the address in r0

	.thumb

Program:
	bl Mode0Setup			;Sets up sprites and tiles (see Mode0Setup.asm or SpriteTest.asm in BasicExamples)
	
WaitForVBlank:
	ldr r0, VBLankAddress
	ldrh r1, [r0,#0]
	cmp r1, #161
	bne WaitForVBlank
	
	mov r0, #0					;Address object 1
	mov r1, #0b00001000		;Attribute 0, sets Y-position
	ldr r2, TwoByTwoSprite	;Sets sprite mode to 16x16 (high 8 bits)
	mov r3, #0b11100000		;Sets X-position (low 8 bits)
	orr r2, r3				;Attribute 1, combines the sprite mode and position
	mov r3, #0b00000001		;Attribute 2, sets tile type
	bl SetSprite

Infinite:
	b Infinite				;Loops forever
	
.include "./Mode0Setup.asm"

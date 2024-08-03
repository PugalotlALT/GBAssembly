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
	mov r1, #0b00000000
	mov r2, #0b00000000
	
SetSpriteMovement:
	bl DPADMovement
	
WaitForVBlank:
	ldr r0, VBLankAddress
	ldrh r4, [r0,#0]
	cmp r4, #161
	bne WaitForVBlank
	
	
	mov r0, #0					;Address object 1
	ldr r3, TwoByTwoSprite	;Sets sprite mode to 16x16 (high 8 bits)
	orr r2, r3				;Attribute 1, combines the sprite mode and position
	mov r3, #0b00000001		;Attribute 2, sets tile type
	bl SetSprite

	b SetSpriteMovement				;Loops forever
	
DPADMovement:			;Takes the X-value from r2 and the Y-value from r1 and increments / decrenemts them based on the D-Pad
	push {r0, r3, lr}
	ldr r0, ButtonAddress
	ldrh r0, [r0, #0]
	mov r3, #0b1000000
	tst r0, r3
	beq SkipUp
	sub r1, r1, #1
SkipUp:
	lsl r3, r3, #1
	tst r0, r3
	beq SkipDown
	add r1, r1, #1
SkipDown:
	lsl r3, r3, #1
	tst r0, r3
	beq SkipDown
	add r2, r2, #1
SkipRight:
	lsl r3, r3, #1
	tst r0, r3
	beq SkipDown
	sub r2, r2, #1
SkipLeft:
	pop {r0, r3, pc}
	
	
.include "./Mode0Setup.asm"



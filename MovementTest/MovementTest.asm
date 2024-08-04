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
	;ldr r0, VBLankAddress
	;ldrh r4, [r0,#0]
	;cmp r4, #161
	;bne WaitForVBlank
	swi 5
	
	
	mov r0, #0		;Use object 0
					;Takes the X-value from r2
					;Takes the Y-value from r1
	mov r3, #1		;Sets the tile type to 1
	mov r4, #1		;Sets the 2x2 flag to true
	bl SetSpriteDivTwo		;Draws sprite with X and Y values divided by two

	b SetSpriteMovement				;Loops forever
	
DPADMovement:			;Takes the X-value from r2 and the Y-value from r1 and increments / decrenemts them based on the D-Pad
	push {r0, r3, lr}
	ldr r0, ButtonAddress
	ldrh r0, [r0, #0]
	mov r3, #0b10000
	tst r0, r3
	bne SkipRight
	add r2, r2, #1		;Test bit is set in button, then add, then shift left by one
SkipRight:
	lsl r3, r3, #1
	tst r0, r3
	bne SkipLeft
	sub r2, r2, #1
SkipLeft:
	lsl r3, r3, #1
	tst r0, r3
	bne SkipUp
	sub r1, r1, #1
SkipUp:
	lsl r3, r3, #1
	tst r0, r3
	bne SkipDown
	add r1, r1, #1
SkipDown:
	pop {r0, r3, pc}
	
	
.include "./Mode0Setup.asm"



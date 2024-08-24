.org 0x08000000

b SetThumbMode

.incbin "./header.bin"

SetThumbMode:
	adr r0,Program		;Loads the program address
	add r0,r0,#1		;Adds one to set the first bit to 1 (enter THUMB mode)
	bx r0				;Jumps to the address in r0

	.thumb

Program:
	mov r0, #127			;Disables the set amount of sprites, with 128 keeping the first, 127 keeping the first two...
	bl Mode0Setup			;Sets up sprites and tiles (see Mode0Setup.asm or SpriteTest.asm in BasicExamples)
	
	
	;REGISTER LAYOUT
	;R0			SCORE
	;R1			PLAYER Y
	;R2			PLAYER X
	;R3			FLY Y
	;R4			FLY X
	;R5			COLLISION FLAG
	mov r0, #0
	mov r1, #0
	mov r2, #0
	mov r3, #152
	mov r4, #232
	mov r5, #0
	
SetSpriteMovement:
	bl DPADMovement
	bl MoveFly
	;bl CheckCollision
	;cmp r5, #1
;InfiniteLoop:
	;beq InfiniteLoop
	
	bl WaitForVBlank
	
	bl DrawPlayer
	bl DrawFly
	bl CheckDrawScore
	
	
	add r0, r0, #1
	b SetSpriteMovement				;Loops forever
	

DPADMovement:			;Takes the X-value from r2 and the Y-value from r1 and increments / decrenemts them based on the D-Pad
	push {r0, r3, r4, lr}
	ldr r0, ButtonAddress
	ldrh r0, [r0, #0]
	mov r3, #0b10000
	tst r0, r3
	bne SkipRight
	add r2, r2, #2		;Test bit is set in button, then add, then shift left by one
SkipRight:
	lsl r3, r3, #1
	tst r0, r3
	bne SkipLeft
	sub r2, r2, #2
SkipLeft:
	lsl r3, r3, #1
	tst r0, r3
	bne SkipUp
	sub r1, r1, #2
SkipUp:
	lsl r3, r3, #1
	tst r0, r3
	bne SkipDown
	add r1, r1, #2
SkipDown:
	mov r0, #0
	cmp r2, r0
	bge SkipLeftWall
	add r2, r2, #2
SkipLeftWall:
	cmp r1, r0
	bge SkipTopWall
	add r1, r1, #2
SkipTopWall:
	ldr r0, RightScreenEdge
	cmp r0, r2
	bge SkipRightWall
	sub r2, r2, #2
SkipRightWall:
	ldr r0, BottomScreenEdge
	cmp r0, r1
	bge SkipBottomWall
	sub r1, r1, #2
SkipBottomWall:
	pop {r0, r3, r4, pc}
	
DrawScore:		;Draws the score from r0 upon the screen
	push {r0-r3, lr}
	asr r0, r0, #7
	ldr r2, GUITilemapAddress
	add r2, #10
DrawLoop:
	mov r1, #10
	swi 6
	add r1, #15
	strh r1, [r2,#0]
	sub r2, #2
	cmp r0, #0
	bne DrawLoop
	pop {r0-r3, pc}
	
CheckDrawScore:		;Draws the score if only the last 7 bits equal 0
	push {r0-r2, lr}
	mov r1, #127
	mov r2, r0
	and r2, r1
	cmp r2, #0
	bne SkipDrawScore
	bl DrawScore
SkipDrawScore:
	pop {r0-r2, pc}
	
WaitForVBlank:		;Awaits VBlank
	push {r0, r4, lr}
VBlankLoop:
	ldr r0, VBLankAddress
	ldrh r4, [r0,#0]
	cmp r4, #161
	bne VBlankLoop
	pop {r0, r4, pc}
	
DrawPlayer:			;Moves Object 0 using the X and Y from r2 and r1
	push {r0-r4, lr}
	mov r0, #0		;Use object 0
					;Takes the X-value from r2
					;Takes the Y-value from r1
	mov r3, #2		;Sets the tile type to 2
	mov r4, #1		;Sets the 2x2 flag to true
	bl SetSpriteDivTwo		;Draws sprite with X and Y values divided by two
	pop {r0-r4, pc}
	
DrawFly:
	push {r0-r4, lr}
	mov r0, #1		;Use object 0
	mov r2, r4		;Takes the X-value from r4
	mov r1, r3		;Takes the Y-value from r3
	mov r3, #25		;Sets the tile type to 25
	mov r4, #1		;Sets the 2x2 flag to true
	bl SetSpriteDivTwo		;Draws sprite with X and Y values divided by two
	pop {r0-r4, pc}
	
MoveFly:
	push {r0-r2, lr}
	cmp r1, r3		;Player Y - Fly Y
	bge FlyDown
	sub r3, r3, #1	;Move fly up
	b FlyContinue
FlyDown:
	add r3, r3, #1 	;Move fly down
FlyContinue:

	cmp r2, r4		;Player X - Fly X
	bge FlyRight
	sub r4, r4, #1	;Move fly left
	b FlyContinue2
FlyRight:
	add r4, r4, #1 	;Move fly right
FlyContinue2:
	pop {r0-r2, pc}
	
CheckCollision:		;Checks if there is a collision between the player and the fly
	push {r0-r4, lr}
	sub r0, r1, r4
	mov r1, #32
	cmp r0, r1
	;TO COMPLETE
	pop {r0-r4, pc}

.include "./Mode0Setup.asm"


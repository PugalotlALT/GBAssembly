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
	ldr r1, Mode3BG2
	str r1, [r0,#0]			;Sets the GBA screen mode to Mode 3 (16bit colour bitmap) on Background 2
	
	ldr r0, VRAMAddress		;The address where the data will be written
	ldr r1, Blue			;The colour to write
	ldr r2, CanvasSize		;The amount of writes to fill the canvas
	
Loop1:
	strh r1,[r0,#0]			;Store the colour at the VRAM address
	add r0, r0, #2			;Add two to the VRAM address (16bit)
	sub r2, r2, #1			;Decrement the amount of writes
	bne Loop1				;If >0, loop

Infinite:
	b Infinite				;Loops forever
	
	.align 4
DisplayAddress:
	.long 0x4000000
	
VBLankAddress:
	.long 0x4000006
	
VRAMAddress:
	.long 0x6000000
	
StackAddress:
	.long 0x3000000
	
Mode3BG2:
	.int 0x403
	
Blue:
	.long 0b1111111101000000
	
CanvasSize:
	.long 0x9600
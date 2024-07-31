.org 0x08000000

b SetThumbMode

.include "./header.asm"
	
SetThumbMode:
	adr r0,Program		;Loads the program address
	add r0,r0,#1		;Adds one to set the first bit to 1 (enter THUMB mode)
	bx r0				;Jumps to the address in r0

	.thumb

Program:
	ldr r0,StackAddress
	mov sp, r0

	ldr r0, DisplayAddress
	ldr r1, Mode3BG2
	str r1, [r0,#0]
	
	ldr r0, VRAMAddress
	ldr r1, Blue
	ldr r2, CanvasSize
	
	
Loop1:
	strh r1,[r0,#2]

Infinite:
	b Infinite
	
	.align 4
DisplayAddress:
	.long 0x04000000
	
VRAMAddress:
	.long 0x06000000
	
StackAddress:
	.long 0x03000000
	
Mode3BG2:
	.int 0x403
	
Blue:
	.long 0b1111111101000000
	
CanvasSize:
	.long 0x9600
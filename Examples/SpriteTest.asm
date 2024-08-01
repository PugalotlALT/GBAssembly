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
	mov sp, r0				;Sets up the stack (unused)

	ldr r0, DisplayAddress
	ldr r1, Mode0BG2
	str r1, [r0,#0]			;Sets the GBA screen mode to Mode 0 (tiles / backgrounds) on Background 0
	
	add r0, r0, #0x8		;Moves r0 to the BG0 control settings
	ldr r1, Mode0Settings
	str r1, [r0,#0]			;Sets the settings for Mode 0
	

Infinite:
	b Infinite				;Loops forever
	

Copy16Bit:					;Copies from [r0] to [r1] based on the length of r2
	STMFD sp!,{r0-r12, lr}

Copy16BitLoop:
	ldrh r3, [r0, #0]
	add r0, r0, #2
	strh r3, [r1, #0]
	add r1, r1, #2
	sub r2, r2, #2
	bne Copy16BitLoop
	
	LDMFD sp!,{r0-r12, pc}
	
	.align 4
DisplayAddress:
	.long 0x4000000
	
	
VRAMAddress:
	.long 0x6000000
	
StackAddress:
	.long 0x3000000
	
Mode0BG2:
	.int 0x100
	
Mode0Settings:
	.int 0x4004
	
Pallete:
	
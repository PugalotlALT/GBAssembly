.org 0x08000000

b ProgramStart

.include "./header.asm"
	
ProgramStart:
	adr r0,InfLoop
	add r0,r0,#1
	bx r0

	.thumb

InfLoop:
	b InfLoop
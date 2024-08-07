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
	.word 0,0,0,11,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,13,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
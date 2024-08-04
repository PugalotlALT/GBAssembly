DisplayAddress:
	.long 0x4000000
	
ButtonAddress:
	.long 0x4000130
	
VRAMAddress:
	.long 0x6000000
	
BGTileAddress:
	.long 0x06004000
	
StackAddress:
	.long 0x3000000
	
TilePalleteAddress:
	.long 0x5000000
	
SpritePalleteAddress:
	.long 0x5000200
	
TileAddress:
	.long 0x6010000
	
TilemapAddress:
	.long 0x6000000
	
BG0ControlAddress:
	.long 0x4000008
	
BG0Control:
	.int 0x0004
	
VBLankAddress:
	.long 0x4000006
	
OAMAddress:
	.long 0x7000000

Mode0BG2:
	.int 0x100
	
EnableSprites:
	.int 0x1140
	
TwoByTwoSprite:
	.int 0b0100000000000000
	
RightScreenEdge:
	.int 448
	
BottomScreenEdge:
	.int 240
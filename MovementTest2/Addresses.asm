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
	
GUITilemapAddress:
	.long 0x6000000
	
BGTilemapAddress:
	.long 0x6000800
	
GUIControlAddress:
	.long 0x4000008
	
GUIControl:
	.int 0x0004
	
BGControlAddress:
	.long 0x400000A
	
BGControl:
	.int 0x0106

VBLankAddress:
	.long 0x4000006
	
OAMAddress:
	.long 0x7000000
	
OAMEndAddress:
	.long 0x7000000
	
TilesLength:
	.long TilesEnd - Tiles
	
TilemapAddress:
	.long TileMap

Mode0BG2:
	.int 0x100
	
EnableSprites:
	.int 0x1340
	
TwoByTwoSprite:
	.int 0b0100000000000000
	
SpritePriority:
	.int 0b0000010000000000
	
DisableSprite:
;	.int 0b0000000100000000
	.int 0b0000001000000000
	
RightScreenEdge:
	.int 448
	
BottomScreenEdge:
	.int 240
	
RandomMultiply:
	.int 1664525
	
RandomAdd:
	.int 1013904223
	
RandomAnd:
	.int 0x7FFF
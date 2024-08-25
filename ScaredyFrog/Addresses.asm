DisplayAddress:
	.long 0x4000000			;Controls the BG layers and objects displayed
	
ButtonAddress:
	.long 0x4000130			;Shows which buttons are currently held
	
VRAMAddress:
	.long 0x6000000			;The address where VRAM starts
	
BGTileAddress:
	.long 0x06004000		;The address in VRAM where tiles are stored for the background
	
TilePalleteAddress:
	.long 0x5000000			;The address in VRAM which stores the palletes for backgrounds
	
SpritePalleteAddress:
	.long 0x5000200			;The address in VRAM which stores the palletes for sprites
	
TileAddress:
	.long 0x6010000			;The address in VRAM which stores the tiles for sprites
	
GUITilemapAddress:
	.long 0x6000000			;The address in VRAM where the GUI tiles are placed
	
BGTilemapAddress:
	.long 0x6000800			;The address in VRAM where the background tiles are placed
	
TitleTilemapAddress:
	.long 0x6001000			;The address in VRAM where the title screen is drawn
	
GUIControlAddress:
	.long 0x4000008			;The control address for BG0 (the GUI address)
	
GUIControl:
	.int 0x0005				;Sets the tileset and priority to 1 (priority goes 0 -> 3)
	
BGControlAddress:
	.long 0x400000A			;The control address for BG1 (the GUI address)
	
BGControl:
	.int 0x0107				;Sets the tileset, memory location and priority to 3 (priority goes 0 -> 3)
	
TitleControlAddress:
	.long 0x400000C			;The control address for BG2 (the title address)
	
TitleControl:
	.int 0x0204				;Sets the tileset, memory location and priority to 0 (priority goes 0 -> 3)

VBLankAddress:
	.long 0x4000006			;The address used to check where VBlank is currently at for syncing
	
OAMAddress:
	.long 0x7000000			;The address for OAM, where sprites are stored
	
TilesLength:
	.long TilesEnd - Tiles	;The length of the tile section in Sprites.asm
	
TilemapAddress:
	.long TileMap			;The base address of the tilemap
	
TilemapLength:
	.int 1280				;How many bytes are in one tilemap

Mode0BG2:
	.int 0x100				;Sets the screen mode to Mode 0 with BG2 enabled
	
EnableSpritesTitle:
	.int 0x1740				;Sets the screen mode to Mode 0 with sprites, BG0, BG1 and BG2 enabled
	
EnableSpritesNoTitle:
	.int 0x1340				;Sets the screen mode to Mode 0 with sprites, BG0 and BG1 enabled
	
TwoByTwoSprite:
	.int 0b0100000000000000	;Changes the OAM attribute to give that sprite 4 tiles instead of 1
	
SpritePriority:
	.int 0b0000100000000000	;Sets the sprite priority to 1 (priority goes 0 -> 3)
	
DisableSprite:
	.int 0b0000001000000000	;Sets the sprite to hidden
	
RightScreenEdge:
	.int 448				;Where the edge of the screen lies when the X is multiplied by 2
	
BottomScreenEdge:
	.int 240				;Where the edge of the screen lies when the X is multiplied by 2

Div10Multiply:
	.int 3277				;Used for a hack to divide by 10 quicker
	
Div10Shift:
	.int 15					;Used for a hack to divide by 10 quicker
	
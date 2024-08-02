def default_input(string, default):
	temp_input = input(string)
	if (temp_input == ""):
		return default
	else:
		return temp_input

print('''
	Welcome to the GBA header generation tool.
	This tool will help you generate a valid header file with proper complement checks
	For more info on the GBA header, visit https://rust-console.github.io/gbatek-gbaonly/#gbacartridgeheader
''')

file_name = default_input("Enter a filename for your header (default = 'header.bin'): ", "header.bin")

#Writes the needed Nintendo Boot header for GBA files
header = b"\x24\xFF\xAE\x51\x69\x9A\xA2\x21\x3D\x84\x82\x0A\x84\xE4\x09\xAD\x11\x24\x8B\x98\xC0\x81\x7F\x21\xA3\x52\xBE\x19\x93\x09\xCE\x20\x10\x46\x4A\x4A\xF8\x27\x31\xEC\x58\xC7\xE8\x33\x82\xE3\xCE\xBF\x85\xF4\xDF\x94\xCE\x4B\x09\xC1\x94\x56\x8A\xC0\x13\x72\xA7\xFC\x9F\x84\x4D\x73\xA3\xCA\x9A\x61\x58\x97\xA3\x27\xFC\x03\x98\x76\x23\x1D\xC7\x61\x03\x04\xAE\x56\xBF\x38\x84\x00\x40\xA7\x0E\xFD\xFF\x52\xFE\x03\x6F\x95\x30\xF1\x97\xFB\xC0\x85\x60\xD6\x80\x25\xA9\x63\xBE\x03\x01\x4E\x38\xE2\xF9\xA2\x34\xFF\xBB\x3E\x03\x44\x78\x00\x90\xCB\x88\x11\x3A\x94\x65\xC0\x7C\x63\x87\xF0\x3C\xAF\xD6\x25\xE4\x8B\x38\x0A\xAC\x72\x21\xD4\xF8\x07"

game_name = default_input("Enter the name of your game (max 12 characters) (default = ''): ", "")[:12]
game_name_bytes = game_name.encode('ascii')
header += game_name_bytes + (12-len(game_name_bytes))*b"\x00"

game_name = default_input("Enter the game code for your game (max 4 characters) (default = 'ATGP'): ", "ATGP")[:4]
game_name_bytes = game_name.encode('ascii')
header += game_name_bytes + (4-len(game_name_bytes))*b"\x00"

game_name = default_input("Enter the maker code for your game (max 2 characters) (default = '01'): ", "01")[:2]
game_name_bytes = game_name.encode('ascii')
header += game_name_bytes + (2-len(game_name_bytes))*b"\x00"

#Spacing plus mandatory 96h value
header += b"\x96\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"

check_value = 0

for i in header[156:184]:
	check_value = (check_value - int(i)) & 0xFF #Calculates the complement check
	
check_value = (check_value - 0x19) & 0xFF
	
header += check_value.to_bytes(1)

header += b"\x00\x00"
	
with open(file_name, "wb") as header_file:
	header_file.write(header)
	
print(f'''
	All done!
	You can import this into your project by using:
		.incbin "{file_name}"
''')

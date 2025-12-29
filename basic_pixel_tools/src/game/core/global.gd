extends Node

## Game node, this is what you play
var Game: Node

## Main node, this is the window, and resolution thinks
var Main: Node

## Returns a dictionary
## From a path (string)
func get_data(path: String) -> Dictionary:
	var dict: Dictionary = {}
	
	var file = FileAccess.open(path, FileAccess.READ)
	
	var json_string: String = "" #Creem un String
	
	if(FileAccess.file_exists(path)):
		while(!file.eof_reached()): 
			json_string = json_string + file.get_line() #Anem emplanant fitxer
		
		var json = JSON.new() #Creem el arxiu JSON
		var parse_result = json.parse(json_string) #Fem que el arxiu sigui on JSON
		
		if not parse_result == OK: #Si hi ha un error, el programa es tenca
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			get_tree().quit()
		else: #Si no hi ha error continua
			var data = json.get_data()
			dict = data #Obtenim data del JSON i escrivim al SQUARE_ID
		
	return dict

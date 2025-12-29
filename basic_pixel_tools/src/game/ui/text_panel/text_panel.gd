extends Panel

var writting_time: float = 1 #Perque es de tipus text
var font_color: Color = Color(0, 0, 1) #Perque es de tipus text
var font = preload("res://assets/test/8-bit-operator/8bitOperatorPlus8-Bold.ttf") #Perque es de tipus text

var arguments: String = "[center]Example[/center]{Input}
MOLT DE TEXT PER VEURE QUE POT PASSAR AMB EL TEXT SI ES MASSA LLARG{Input}
[color=#f9f10a]I SI ES MASSA LLARG?[/color]{Input}
I [color=#150af9]SI[/color] ES MASSA LLARG?{Input}
I SI ES MASSA LLARG?{Input}
I SI ES MASSA LLARG?{Input}{End}
"
const START_OF_CODE: String = "{"
var END_OF_CODE: String = "}"

signal RecivedInput
signal writting_ended

const CHARACTERS_PATH: String = "res://src/game/ui/text_panel/decor/characters.json"
const FONT_PATH: String = "res://src/game/ui/text_panel/decor/font.json"

var characters: Dictionary
var fonts: Dictionary

#temps que tarda en escriure caracter
var writte_time = 0.016

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%CharacterRight.hide()
	%CharacterLeft.hide()
	get_tree().paused = true
	#Obtenim faces i fonts
	characters = Global.get_data(CHARACTERS_PATH)
	fonts = Global.get_data(FONT_PATH)
	$"%TextLabel".text = "\n"
	start_writting(arguments)
	


func _input(event):
	if event.is_action_pressed("ui_accept"):
		RecivedInput.emit()


func start_writting(text: String):
	var pointer: int = -1
	var raeding_code: bool = false
	var number_of_code: int  = 0
	
	for i in text.length():
		if(text[i] == START_OF_CODE):
			if(!raeding_code):
				if(pointer != -1):
					await writte_text(text.substr(pointer, i - pointer))
				pointer = i
				raeding_code = true
			number_of_code = number_of_code + 1
		elif(text[i] == END_OF_CODE):
			number_of_code = number_of_code - 1
			if(number_of_code <= 0):
				await read_order(text.substr(pointer + 1,i - pointer - 1))
				raeding_code = false
				pointer = -1
		else:
			if(pointer == -1):
				pointer = i


func read_order(order: String):
	print("ordre : " , order)
	if(order.get_slice(":", 0) == "End"):
		queue_free()
		get_tree().paused = false
	elif(order.get_slice(":", 0) == "Input"):
		await  RecivedInput
	elif(order.get_slice(":", 0) == "Clear"):
		%TextLabel.text = "\n"
	elif(order.get_slice(":", 0) == "EndLine"):
		%TextLabel.text = %TextLabel.text + "\n"
	elif(order.get_slice(":", 0) == "CharaRight"):
		order_chara(order.get_slice(":", 1),%CharacterRight,%CharacterLeft)
	elif(order.get_slice(":", 0) == "CharaLeft"):
		order_chara(order.get_slice(":", 1),%CharacterLeft,%CharacterRight)

#Pre: Dos TextureRect ja creats corerctament, i una ordre a string
#Post: Crida la funcio chara a character1 i amaga o no character2
func order_chara(order: String, character1: TextureRect, character2: TextureRect):
	var final_order: String = order.get_slice(",", 0)
	if(order.get_slice_count(",") >= 2):
		if(order.get_slice(",", 1) == "true"):
			character2.hide()
	else:
		character2.hide()
	print("chara : ",final_order)
	chara(character1, final_order)


#Funcio que mostra la cara de un NPC al node TextureRect que entris
#TextureRect ha de existir i ser accesible
func chara(character: TextureRect, chara: String):
	if(characters.has(chara)):
		if(FileAccess.file_exists(characters[chara])):
			var chara_texture: Texture = load(characters[chara])
			if(chara_texture != null):
				print("yes!")
				character.texture = chara_texture
				character.show()
			else:
				character.hide()
		else:
			character.hide()
	else:
		character.hide()

func writte_text(text: String):
	#Funcio que escriura a la mateixa linia un text
	var character_start = %TextLabel.get_total_character_count()
	%TextLabel.visible_characters = character_start
	%TextLabel.text = %TextLabel.text + text
	var character_end = %TextLabel.get_total_character_count()
	for i in range(character_start, character_end + 1):
		%TextLabel.visible_characters = i
		await get_tree().create_timer(writte_time).timeout
	
	emit_signal("writting_ended")

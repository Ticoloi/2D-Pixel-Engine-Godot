extends Resource

#Aquesta classe es la classe dialec,
#Quan un jugador interaccioni amb un objecte
#Aquest podra tenir dialegs, els quals son aquests
class_name Dialoge 


@export var dialogues: Dictionary = {
	"List" : [
		"Dialeg de prova 1 {Input}{End}",
		"Dialeg de prova 2 {Input}{End}",
		"Dialeg de prova 3  {Input}{End}",
		"Dialeg de prova 4  {Input}{End}"
	]
}

#Obtindra el text a partir de un diccionari (dades objecte)
func get_text(dict: Dictionary) -> String:
	var size: int = dialogues["List"].size()
	var number: int = randi_range(0, size - 1)
	return dialogues["List"][number]

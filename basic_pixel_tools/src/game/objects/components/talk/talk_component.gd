extends Node

class_name TalkComponent

#Senyal que emet quan es parla
#signal talk(InteractionResource)
@export var dialoge: Dialoge

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




#Un jugador pot interaccionar amb una entitat,
#Per fer-ho creara un nou objecte: Interaction Resource, el qual enviara a aquest node
func talk(_data: Interaction):
	if dialoge:
		Global.Game.text_panel(dialoge.get_text({"Hola" : 1}))
	else:
		Global.Game.text_panel("NOP {Input}{End}")


func _on_hitbox_component_interacted(data: Interaction) -> void:
	talk(data)

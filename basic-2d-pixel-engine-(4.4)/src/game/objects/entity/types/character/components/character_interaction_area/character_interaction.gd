extends Area2D

#Aquest component es la detecio a curta distancia de un Actor

class_name CharacterInteraction

@export var character: Actor
@export var shape: Shape2D

func _ready() -> void:
	_on_direction_changed(character.last_direction)
	character.connect("last_direction_changed", _on_direction_changed)
	$Shape.shape = shape

func _on_direction_changed(vect: Vector2):
	#Aquest es el codi per controlar aquina
	#direccio va el personatge
	if(vect.x == 0 and vect.y == 0):
		position = Vector2(-shape.size.x/2,shape.size.y/2)
	else:
		if(abs(vect.y) <  abs(vect.x)):
			if(vect.x != 0):
				var val: int = 1
				if(vect.x < 0):
					val = -1
				position = Vector2(val*shape.size.x - 8,-shape.size.y/2)
		else:
			var val: int = 1
			if(vect.y <= 0):
				val = -1
			position = Vector2(-shape.size.x/2,val*shape.size.y - 8)

func _on_player_interact() -> void:
	#S'ha de desactivar la colisio per poder intereactuar.
	#AWW infern
	for i in get_overlapping_areas():
		$Shape.disabled = true
		var data = Interaction.new()
		data.character = character
		i.interaction(data)
		$Shape.disabled = false
		break

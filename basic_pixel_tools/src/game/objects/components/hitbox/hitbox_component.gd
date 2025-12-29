extends Area2D

#Component per a objecte
#El qual esta disenyat per ser interactuat per CharacterInteracion

class_name HitboxComponent

signal interacted(data: Interaction)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Quan el jugador interaccioni, poden passar diferents coess, de les quals tenim:
func interaction(data: Interaction):
	emit_signal("interacted", data)

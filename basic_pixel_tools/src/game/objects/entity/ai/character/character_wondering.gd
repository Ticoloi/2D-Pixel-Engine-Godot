extends Node

@export var character: CharacterNode

var direction: Array = [
	Vector2(1,0),
	Vector2(0,1),
	Vector2(-1,0),
	Vector2(0,-1)
]

var max_directions: int = 4
var current_direction: int = 0

func _ready() -> void:
	_on_timer_timeout()

func _on_timer_timeout() -> void:
	character.direction  = direction[current_direction]
	current_direction = current_direction + 1
	if(current_direction >= max_directions):
		current_direction = 0

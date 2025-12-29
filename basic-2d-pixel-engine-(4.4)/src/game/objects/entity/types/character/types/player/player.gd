extends Player

func _ready() -> void:
	print("Actor" + get_node(actor_path).name)

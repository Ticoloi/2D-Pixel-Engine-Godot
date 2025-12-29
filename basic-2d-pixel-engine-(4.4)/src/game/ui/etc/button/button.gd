extends Button
#Objecte de boto mofificat per les meves necessitats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_hovered()): #Quan el ratoli estigui a sobre
		grab_focus() #Agafa el focus

extends Button
#Objecte de boto mofificat per les meves necessitats


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(is_hovered()): #Quan el ratoli estigui a sobre
		grab_focus() #Agafa el focus

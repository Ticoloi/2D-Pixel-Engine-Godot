extends PanelContainer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%VBoxContainer/Continuar.grab_focus() #Per default, fem que el focus sigui continuar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("ui_cancel")):
		#Quan toquis cancel, et retorna al joc com si res
		queue_free()
		get_tree().paused = false


func _on_continuar_pressed() -> void:
	#Tornar al joc
	queue_free()
	get_tree().paused = false

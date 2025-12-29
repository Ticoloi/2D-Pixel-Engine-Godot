extends Control


var playing_animation: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#Ok, aqui obtenim les mides
	var width = ProjectSettings.get("display/window/size/viewport_width")
	var height = ProjectSettings.get("display/window/size/viewport_height")
	#I definim resolucio
	var resoultion: Vector2 = Vector2(width, height)
	#$ColorRect.size = resoultion
	#$MainViewport.size = resoultion
	
	Global.Main = self
	#$ColorRect.color = Color(1, 1, 1, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Tot el tema de finestra
	if(Input.is_action_just_pressed("F11")):
		if(get_window().mode != 3):
			get_window().mode = 3
		else:
			get_window().mode = 2



func change_scene(NewScene: Node):
	#Aquesta funcio es per canviar de una escena a una altra

	for i in $MainViewport/SubViewport.get_children():
		i.queue_free() #Ens carreghem TOT
	
	$MainViewport/SubViewport.add_child(NewScene) #Afegim nova escena


func _on_animation_player_animation_finished(anim_name):
	playing_animation = false #Pots saver si hi ha animacio amb Game.playing_animation desde qualsevol lloc

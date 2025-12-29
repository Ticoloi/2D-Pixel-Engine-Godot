extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	$Play.grab_focus() #El boto de jugar, al començar te focus


func _on_play_pressed():
	print("hola")
	for i in get_children():
		#Possem en pausa els botons del menu, el propi menu no
		i.process_mode = Node.PROCESS_MODE_DISABLED
	var game_scene = load("res://src/game/core/game/game.tscn").instantiate() #Carreguem main scene
	
	Global.Main.get_node("AnimationPlayer").play("StartLoading") #Esperem a la animacio a acavar
	await Global.Main.get_node("AnimationPlayer").animation_finished
	
	Global.Main.change_scene(game_scene) #Carreguem totes les escenes
	

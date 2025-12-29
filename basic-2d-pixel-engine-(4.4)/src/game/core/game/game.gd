extends Node

#Fem un preload del menu de pausa per optimitzar
var pause_menu_preload = preload("res://src/game/ui/pause_menu/pause_menu.tscn")
var time: float = 800

@export var level_2d: Level2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.Game = self
	await get_tree().create_timer(1).timeout
	print("ok")
	Global.Main.get_node("AnimationPlayer").play("FinishLoading")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!Global.Main.playing_animation): #Codi de pausar
		if(Input.is_action_just_pressed("ui_cancel")):
			var pause_menu = pause_menu_preload.instantiate()
			$UI.add_child(pause_menu)
			get_tree().paused = true

func text_panel(arguments: String):
	var text_box = load("res://src/game/ui/text_panel/text_panel.tscn").instantiate()
	text_box.arguments = arguments
	$UI.add_child(text_box)

func _on_stop_ambient_music():
	$AmbientMusic.stop()

func _continue_ambient_music():
	$AmbientMusic.continue()

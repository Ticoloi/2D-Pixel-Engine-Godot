extends Node2D

#Script del jugador
#Basicament controla el CharacterNode
#I pot cridar a Area

@export var character: Actor
@export var interacion: CharacterInteraction

@export var speed_running: float = 40
@export var animation_running: float = 0.7


func _physics_process(delta: float) -> void:
	var dir_x = Input.get_action_strength("ui_right") - 1*Input.get_action_strength("ui_left")
	var dir_y = Input.get_action_strength("ui_down") - 1*Input.get_action_strength("ui_up")
	
	character.direction = Vector2(dir_x, dir_y)


func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_accept")):
		if(interacion):
			var data: Interaction  = Interaction.new()
			data.interaction_type = data.TYPE.INTERACT
			#data.character = Actor
			interacion.interact(data)
	if(event.is_action_pressed("run")):
		character.speed = character.speed + 40
		var sprites: AnimatedSprite2D = get_parent().get_node("AnimatedSprite2D")
		sprites.speed_scale =  sprites.speed_scale + animation_running
	elif(event.is_action_released("run")):
		character.speed = character.speed - 40
		var sprites: AnimatedSprite2D = get_parent().get_node("AnimatedSprite2D")
		sprites.speed_scale = sprites.speed_scale - animation_running

extends Node

class_name RoomChangeComponent

@export var room: Room

@export var coords: Vector2


func move_character_to_room(character: Actor):
	if(Global.Game):
		var game = Global.Game
		if(game.level_2d):
			var level_2d: Level2D = game.level_2d
			
			print("let's go to room : " + room.ID)
			
			if(character.is_player):
				level_2d.change_room(room)
			
			level_2d.move_node_to_scene(room, character)
			character.position = coords


func _on_hitbox_component_interacted(data: Interaction) -> void:
	move_character_to_room(data.character)

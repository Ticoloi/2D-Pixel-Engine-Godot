extends Node2D

class_name Level2D

#Una escena 2d es un node que te una room (sala)
#i entitats que poden estar en diferents sales (com el jugador)

#Una sala pot tenir una camera
#Una sala pot no ser mostrada, pero estar executant-se.

#La camera no esta sempre!

@export var room_node: Node
@export var camera: Camera2D
@export var player: Actor

@export var starting_room: Room

func _ready() -> void:
	room_node = $RoomLoader.load_room(starting_room)
	add_child(room_node)
	#var player_load = load("res://src/game/objects/entity/types/character/types/player/player.tscn")
	#player = player_load.instantiate()
	#add_child(player)

func _process(delta: float) -> void:
	if(camera and player):
		camera.position = player.position

func change_room(new_room: Room):
	if($RoomLoader.room_exist(new_room)):
		$RoomLoader.add_room(room_node.room, room_node)
		var second_room: Node = $RoomLoader.get_room(new_room)
		second_room.reparent(self)
		room_node = second_room
		$RoomLoader.remove_room(room_node.room)
	else:
		$RoomLoader.add_room(room_node.room, room_node)
		room_node = $RoomLoader.load_room(new_room)
		add_child(room_node)
	

func move_node_to_scene(destination_room: Room, node: Node):
	#Ok, the room is a destination room
	if($RoomLoader.room_exist(destination_room)):
		print("found room : " + destination_room.ID + " , " +  room_node.room.ID)
		node.reparent($RoomLoader.get_room(destination_room))
	else:
		if(destination_room.ID == room_node.room.ID and destination_room.TYPE == room_node.room.TYPE):
			print("I... am the room")
			node.reparent(room_node)
		else:
			print("new room")
			var new_room_node: Node = $RoomLoader.load_room(destination_room)
			$RoomLoader.add_room(destination_room, new_room_node)
			node.reparent(new_room_node)
	

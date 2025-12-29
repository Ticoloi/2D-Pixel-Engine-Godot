extends Node

#Auests node cargara diferentes abitacions

#D'aquesta manera, no s'ha de cargar a memora (lent)
#o pots tenir NPC fent accions de fons

#Es pot intentar implementar multijugador!

func _ready() -> void:
	pass

#Pre: Una habitacio
#Post: Un nom de habitaico (per a Viewport)
func room_name(room: Room) -> String:
	return room.TYPE + "_" + room.ID

#Pre: Una room 2d
#Post: True si el troba, false si np el troba
func room_exist(find: Room) -> bool:
	if(get_node_or_null(room_name(find)) != null):
		return true
	return false

#Pre: Una room 2D
#Post: Afeig al nivell com que s'esta carregant,
#si es que no el te ja.
func add_room(new_room: Room, new_node: Node):
	if(!room_exist(new_room)):
		var viewport: SubViewport = SubViewport.new()
		if(new_node.get_parent() != null):
			new_node.reparent(viewport)
		else:
			viewport.add_child(new_node)
		add_child(viewport)
		viewport.name = room_name(new_room)
	
	emit_signal("added_room")

#Elimina la room
func remove_room(room: Room):
	if(room_exist(room)):
		get_node(room_name(room)).queue_free()

func get_room(room: Room) -> Node:
	return get_node(room_name(room)).get_child(0)


#Pre: un tipus i una abitacio, 2 strings
#Post: Retorna una room2d concreta si ho troba,
#en cas de error, et retorna un null
func load_room(room: Room) -> Node:
	var room_path: String = "res://scenes/rooms/" + room.TYPE + "/" + room.ID + ".tscn"
	var room_load = load(room_path)
	var new_room = room_load.instantiate()
	if(new_room):
		return new_room
	else:
		return null

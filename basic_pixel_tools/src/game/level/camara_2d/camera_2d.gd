extends Camera2D

var target = null #A qui ha de seguir la camera?

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(target != null): #Codi de seguir camera
		print(position)
		position = target.position

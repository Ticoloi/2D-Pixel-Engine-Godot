extends  CharacterBody2D

class_name CharacterNode
#Un character es una entitat que te una direccio i last_direction
#No es mou, las de mourel tu amb scrript
#El node ja te  animacions

@export var speed: float = 10

signal direction_changed(Vector2)

var direction: Vector2 = Vector2(0,0)

@export var last_direction: Vector2 = Vector2(0,0):
	set(value):
		last_direction = value
		emit_signal("direction_changed", last_direction)

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Codi basic de un caracter
	if(!direction.is_normalized()):
		direction = direction.normalized()
		
	move_and_collide(speed*direction*delta)
	
	if((direction.x != 0) or (direction.y != 0)):
		last_direction = direction
		if(abs(direction.y) < abs(direction.x)):
			$AnimatedSprite2D.play("walk_horizontal")
			if(direction.x < 0):
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
		else:
			if(direction.y > 0):
				$AnimatedSprite2D.play("walk_down")
			else:
				$AnimatedSprite2D.play("walk_up")
	else:
		if(abs(last_direction.y) <  abs(last_direction.x)):
			if(last_direction.x != 0):
				$AnimatedSprite2D.play("idle_horizontal")
				if(last_direction.x < 0):
					$AnimatedSprite2D.flip_h = true
				else:
					$AnimatedSprite2D.flip_h = false
		else:
			if(last_direction.y >= 0):
				$AnimatedSprite2D.play("idle_down")
			else:
				$AnimatedSprite2D.play("idle_up")

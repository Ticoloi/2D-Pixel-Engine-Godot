extends StaticBody2D


func _on_hitbox_component_interacted(_data: Interaction) -> void:
	print("interacion!")
	if($PointLight2D.visible):
		$PointLight2D.hide()
	else:
		$PointLight2D.show()

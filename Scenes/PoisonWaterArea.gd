extends Area2D

@export var spawn_location: Marker2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		Globals.heart_amount -= 1
		body.global_position = spawn_location.global_position
		body.hurt()



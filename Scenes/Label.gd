extends Label

@export var label: Label

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		label.visible = true


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		label.visible = false

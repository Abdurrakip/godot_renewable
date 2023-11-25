extends StaticBody2D

@onready var collision: CollisionShape2D = $CollisionShape2D
@export var item_name: String
var is_active: bool = true

signal dropped(pos, item_name)

func _process(delta):
	if is_active:
		$".".position.y += 1

func _on_area_2d_body_entered(body):
	dropped.emit(position, item_name)
	queue_free()
	

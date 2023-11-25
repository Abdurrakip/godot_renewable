extends Area2D

signal collect

@export var item_name_string: String
@export var rotation_speed: int = 2
var is_expanding: bool = true

signal item_collected(item_name_string)

func _ready():
	if item_name_string == "Bolt":
		$boltSprite.visible = true
	if item_name_string == "Cable":
		$cableSprite.visible = true
	if item_name_string == "Screw":
		$screwSprite.visible = true
	if item_name_string == "Scrap":
		$scrapSprite.visible = true
	if item_name_string == "key":
		$keySprite.visible = true

func _on_body_entered(body):
	if body.is_in_group("player"):
		if item_name_string == "Bolt":
			Globals.bolt_amount += 1
		if item_name_string == "Cable":
			Globals.cable_amount += 1
		if item_name_string == "Screw":
			Globals.screw_amount += 1
		if item_name_string == "Scrap":
			Globals.scrap_amount += 1
		if item_name_string == "key":
			Globals.has_key = true
		#Ui.print_item_nums()
		collect.emit()
	queue_free()

func _process(delta):
	if scale <= Vector2(2, 2):
		is_expanding = true

	if scale >= Vector2(2.5, 2.5):
		is_expanding = false
	
	if is_expanding:
		scale += Vector2(0.01, 0.01)
	else:
		scale -= Vector2(0.01, 0.01)

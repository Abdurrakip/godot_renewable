extends Sprite2D

var r: int
var g: int
var b: int
var counter: int = 10

@export var warp_position: Marker2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		if name == "Portal":
			if Globals.bolt_amount == 1 and Globals.screw_amount == 1 and Globals.cable_amount == 2 and Globals.scrap_amount== 2:
				body.global_position = warp_position.global_position
			else:
				Globals.set_warning("HENÜZ TÜM KAYNAKLARI TOPLAMADIĞIN 
				İÇİN BU PORTALI KULLANAMAZSIN
				LÜTFEN TÜM KAYNAKLARI TOPLADIĞINA EMİN OL!")
		if name == "Portal2":
			if Globals.has_key:
				get_tree().change_scene_to_file("res://Scenes/outro.tscn")
			else:
				Globals.set_warning("PORTALI KULLANMAK İÇİN
				ANAHTARI BULMALISIN!")

extends Node2D

class_name world

@onready var posioned_area1: Area2D = $first_poison
var is_poison1_active = false
@onready var posioned_area2: Area2D = $second_poison
var is_poison2_active = false
@onready var tree1: StaticBody2D = $GrandTree
var is_tree1_active = false
@onready var tree2: StaticBody2D = $GrandTree6
var is_tree2_active = false




func poison1_play():
	if !is_poison1_active:
		$AnimationPlayer.current_animation = "water1"
		$first_poison.queue_free()
		is_poison1_active = true

func poison2_play():
	if !is_poison2_active:
		$AnimationPlayer.current_animation = "water2"
		$second_poison.queue_free()
		is_poison2_active = true

func tree1_play():
	if !is_tree1_active:
		$AnimationPlayer.current_animation = "tree1"
		is_tree1_active = true

func tree2_play():
	if !is_tree2_active:
		$AnimationPlayer.current_animation = "tree2"
		is_tree2_active = true

func _process(delta):
	if Globals.is_dam_alright and !is_poison1_active:
		poison1_play()
		Globals.set_warning("ÇEVRENDE BİR ŞEYLER DEĞİŞTİ,
		NE OLDUĞUNU BULMAK İÇİN ETRAFA BAKIN")
		$wanr_timeout.start()
		is_poison1_active = true
	if Globals.is_solar_alright and !is_tree1_active:
		tree1_play()
		Globals.set_warning("ÇEVRENDE BİR ŞEYLER DEĞİŞTİ,
		NE OLDUĞUNU BULMAK İÇİN ETRAFA BAKIN")
		$wanr_timeout.start()
		is_tree1_active = true
	if Globals.is_wind_alright and !is_poison2_active:
		poison2_play()
		Globals.set_warning("ÇEVRENDE BİR ŞEYLER DEĞİŞTİ,
		NE OLDUĞUNU BULMAK İÇİN ETRAFA BAKIN")
		$wanr_timeout.start()
		is_poison2_active = true
	if Globals.is_geo_alright and !is_tree2_active:
		tree2_play()
		$wanr_timeout.start()
		Globals.set_warning("ÇEVRENDE BİR ŞEYLER DEĞİŞTİ,
		NE OLDUĞUNU BULMAK İÇİN ETRAFA BAKIN")
		is_tree2_active = true
		


func _on_wanr_timeout_timeout():
	print("Timeout")
	Globals.set_warning("")

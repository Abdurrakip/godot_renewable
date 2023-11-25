extends Control

@export var scene: PackedScene

@onready var bolt_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/Bolt/Label
@onready var screw_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/Screw/Label
@onready var cable_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/Cable/Label
@onready var scrap_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/Scrap/Label
@onready var hp_label: Label = $Panel3/HBoxContainer/Label
@onready var left_panel: Panel = $Panel
@onready var warn_panel: Panel = $WarnPanel

@onready var CO2_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/Co2label
@onready var UV_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/UVlabel
@onready var Water_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/WaterLabel
@onready var Eco_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/EkoLabel
@onready var Acid_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/AcidLabel


var green: Color = Color.LAWN_GREEN
var red: Color = Color.DARK_RED

var dam_bolt: int = 3
var dam_screw: int = 3
var dam_cable: int = 4
var dam_scrap: int = 4

var solar_bolt: int =5
var solar_screw: int = 4
var solar_cable: int = 4
var solar_scrap: int = 3

var wind_bolt: int = 4
var wind_screw: int = 5
var wind_cable: int = 8
var wind_scrap: int = 3

var geo_bolt: int = 7
var geo_screw: int = 5
var geo_cable: int = 5
var geo_scrap: int = 6

var is_dam_active: bool = false
var is_solar_active: bool = false
var is_wind_active: bool = false
var is_geo_active: bool = false

func _ready():
	Globals.connect("amount_changed", print_item_nums)
	Globals.connect("warn_active", warn_active)
	print_item_nums()

func _process(delta):
	if Input.is_action_just_pressed("fix_panel_toggle"):
		$Panel2.visible = !$Panel2.visible
		$Panel3.visible = !$Panel3.visible
	if Input.is_action_just_pressed("left_panel_toggle"):
		left_panel.visible = !left_panel.visible
		#World1.poison1_play()


func warn_active(string):
	$WarnPanel.visible = true
	$WarnPanel/TextureRect/Label.text = string
	$wanrPanelTimer.start()


func print_item_nums():
	bolt_label.text = ": " + str(Globals.bolt_amount)
	screw_label.text = ": " + str(Globals.screw_amount)
	cable_label.text = ": " + str(Globals.cable_amount)
	scrap_label.text = ": " + str(Globals.scrap_amount)
	hp_label.text = "x " + str(Globals.heart_amount)
	if Globals.heart_amount <= 0:
		get_tree().change_scene_to_packed(scene)
	

func activate_dam():
	if !Globals.is_dam_alright and Globals.bolt_amount >= dam_bolt and Globals.screw_amount >= dam_screw and Globals.cable_amount >= dam_cable and Globals.scrap_amount >= dam_scrap:
		Globals.bolt_amount -= dam_bolt
		Globals.screw_amount -= dam_screw
		Globals.cable_amount -= dam_cable
		Globals.scrap_amount -= dam_scrap
		is_dam_active = true
		$Panel2/PanelContainer/ColorRect/VBoxContainer/HBoxContainer/DamRect.self_modulate = Color.WHITE
		Globals.solved_poblems += 1
		Globals.is_dam_alright = true
	elif Globals.is_dam_alright:
		warn2("Bunu Zaten Aktifleştirdin!")
	else:
		warn("Barajı")

func activate_solar():
	if !Globals.is_solar_alright and Globals.bolt_amount >= solar_bolt and Globals.screw_amount >= solar_screw and Globals.cable_amount >= solar_cable and Globals.scrap_amount >= solar_scrap:
		Globals.bolt_amount -= solar_bolt
		Globals.screw_amount -= solar_screw
		Globals.cable_amount -= solar_cable
		Globals.scrap_amount -= solar_scrap
		is_solar_active = true
		$Panel2/PanelContainer/ColorRect/VBoxContainer/HBoxContainer/SolarRect.self_modulate = Color.WHITE
		Globals.solved_poblems += 1
		Globals.is_solar_alright = true
	elif Globals.is_solar_alright:
		warn2("Bunu Zaten Aktifleştirdin!")
	else:
		warn("Güneş Panelini")

func activate_wind():
	if !Globals.is_wind_alright and Globals.bolt_amount >= wind_bolt and Globals.screw_amount >= wind_screw and Globals.cable_amount >= wind_cable and Globals.scrap_amount >= wind_scrap:
		Globals.bolt_amount -= wind_bolt
		Globals.screw_amount -= wind_screw
		Globals.cable_amount -= wind_cable
		Globals.scrap_amount -= wind_scrap
		is_wind_active = true
		$Panel2/PanelContainer/ColorRect/VBoxContainer/HBoxContainer2/WindRect.modulate = Color.WHITE
		Globals.solved_poblems += 1
		Globals.is_wind_alright = true
	elif Globals.is_wind_alright:
		warn2("Bunu Zaten Aktifleştirdin!")
	else:
		warn("Rüzgar Türbinini")

func activate_geo():
	if !Globals.is_geo_alright and Globals.bolt_amount >= geo_bolt and Globals.screw_amount >= geo_screw and Globals.cable_amount >= geo_cable and Globals.scrap_amount >= geo_scrap:
		Globals.bolt_amount -= geo_bolt
		Globals.screw_amount -= geo_screw
		Globals.cable_amount -= geo_cable
		Globals.scrap_amount -= geo_scrap
		is_geo_active = true
		$Panel2/PanelContainer/ColorRect/VBoxContainer/HBoxContainer2/GeoRect.self_modulate = Color.WHITE
		Globals.solved_poblems += 1
		Globals.is_geo_alright = true
	elif Globals.is_geo_alright:
		warn2("Bunu Zaten Aktifleştirdin!")
	else:
		warn("Jeotermal Enerji Santralini")

func warn(name: String):
	$Panel2/WarnPanel.visible = true
	$Panel2/WarnPanel/ColorRect/Label.text = "Yeterli Kaynağın Olmadığı İçin 
	" + name + " aktifleştiremedin!"
	$WarnTimer.start()

func warn2(name: String):
	$Panel2/WarnPanel.visible = true
	$Panel2/WarnPanel/ColorRect/Label.text = name
	$WarnTimer.start()


func _on_dam_button_pressed():
	activate_dam()


func _on_solar_button_pressed():
	activate_solar()


func _on_wind_button_pressed():
	activate_wind()


func _on_geo_button_pressed():
	activate_geo()


func _on_warn_timer_timeout():
	$Panel2/WarnPanel.visible = false


func _on_wanr_panel_timer_timeout():
	warn_panel.visible = false

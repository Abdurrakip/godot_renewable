extends Control

@onready var bolt_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/Bolt/Label
@onready var screw_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/Screw/Label
@onready var cable_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/Cable/Label
@onready var scrap_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/Scrap/Label

@onready var CO2_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/Co2label
@onready var UV_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/UVlabel
@onready var Water_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/WaterLabel
@onready var Eco_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/EkoLabel
@onready var Acid_label: Label = $Panel/PanelContainer/ColorRect/VBoxContainer/AcidLabel

var green: Color = Color.LAWN_GREEN
var red: Color = Color.DARK_RED

var dam_bolt: int = 10
var dam_screw: int = 10
var dam_cable: int = 10
var dam_scrap: int = 10

var solar_bolt: int =10
var solar_screw: int = 10
var solar_cable: int = 10
var solar_scrap: int = 10

var wind_bolt: int = 10
var wind_screw: int = 10
var wind_cable: int = 10
var wind_scrap: int = 10

var geo_bolt: int = 10
var geo_screw: int = 10
var geo_cable: int = 10
var geo_scrap: int = 10

var is_dam_active: bool = false
var is_solar_active: bool = false
var is_wind_active: bool = false
var is_geo_active: bool = false

func _ready():
	Globals.connect("amount_changed", print_item_nums)
	print_item_nums()

func _process(delta):
	if Input.is_action_just_pressed("fix_panel_toggle"):
		$Panel2.visible = !$Panel2.visible

func print_item_nums():
	bolt_label.text = ": " + str(Globals.bolt_amount)
	screw_label.text = ": " + str(Globals.screw_amount)
	cable_label.text = ": " + str(Globals.cable_amount)
	scrap_label.text = ": " + str(Globals.scrap_amount)
	
	if Globals.is_co2_alright == true:
		CO2_label.modulate = green
	else:
		CO2_label.modulate = red
	
	if Globals.is_water_alright == true:
		Water_label.modulate = green
	else:
		Water_label.modulate = red
	
	if Globals.is_eco_alright == true:
		Eco_label.modulate = green
	else:
		Eco_label.modulate = red
	
	if Globals.is_acid_alright == true:
		Acid_label.modulate = green
	else:
		Acid_label.modulate = red

func activate_dam():
	if Globals.bolt_amount >= dam_bolt and Globals.screw_amount >= dam_screw and Globals.cable_amount >= dam_cable and Globals.scrap_amount >= dam_scrap:
		Globals.bolt_amount -= dam_bolt
		Globals.screw_amount -= dam_screw
		Globals.cable_amount -= dam_cable
		Globals.scrap_amount -= dam_scrap
		is_dam_active = true
		$Panel2/PanelContainer/ColorRect/VBoxContainer/HBoxContainer/DamRect.self_modulate = Color.WHITE
	else:
		warn("Barajı")

func activate_solar():
	if Globals.bolt_amount >= solar_bolt and Globals.screw_amount >= solar_screw and Globals.cable_amount >= solar_cable and Globals.scrap_amount >= solar_scrap:
		Globals.bolt_amount -= solar_bolt
		Globals.screw_amount -= solar_screw
		Globals.cable_amount -= solar_cable
		Globals.scrap_amount -= solar_scrap
		is_solar_active = true
		$Panel2/PanelContainer/ColorRect/VBoxContainer/HBoxContainer/SolarRect.self_modulate = Color.WHITE
	else:
		warn("Güneş Panelini")

func activate_wind():
	if Globals.bolt_amount >= wind_bolt and Globals.screw_amount >= wind_screw and Globals.cable_amount >= wind_cable and Globals.scrap_amount >= wind_scrap:
		Globals.bolt_amount -= wind_bolt
		Globals.screw_amount -= wind_screw
		Globals.cable_amount -= wind_cable
		Globals.scrap_amount -= wind_scrap
		is_wind_active = true
		$Panel2/PanelContainer/ColorRect/VBoxContainer/HBoxContainer2/WindRect.self_modulate = Color.WHITE
		$Panel2/PanelContainer/ColorRect/VBoxContainer/HBoxContainer2/WindRect/WindRect1.self_modulate = Color.WHITE
		$Panel2/PanelContainer/ColorRect/VBoxContainer/HBoxContainer2/WindRect/WindRect2.self_modulate = Color.WHITE
		$Panel2/PanelContainer/ColorRect/VBoxContainer/HBoxContainer2/WindRect/WindRect3.self_modulate = Color.WHITE
	else:
		warn("Rüzgar Türbinini")

func activate_geo():
	if Globals.bolt_amount >= geo_bolt and Globals.screw_amount >= geo_screw and Globals.cable_amount >= geo_cable and Globals.scrap_amount >= geo_scrap:
		Globals.bolt_amount -= geo_bolt
		Globals.screw_amount -= geo_screw
		Globals.cable_amount -= geo_cable
		Globals.scrap_amount -= geo_scrap
		is_geo_active = true
		$Panel2/PanelContainer/ColorRect/VBoxContainer/HBoxContainer2/GeoRect.self_modulate = Color.WHITE
	else:
		warn("Jeotermal Enerji Santralini")

func warn(name: String):
	$Panel2/WarnPanel.visible = true
	$Panel2/WarnPanel/ColorRect/Label.text = "Yeterli Kaynağın Olmadığı İçin 
	" + name + " aktifleştiremedin!"
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

extends Node

signal amount_changed

var bolt_amount = 10:
	set(value):
		bolt_amount = value
		amount_changed.emit()
var screw_amount = 10:
	set(value):
		screw_amount = value
		amount_changed.emit()
var cable_amount = 10:
	set(value):
		cable_amount = value
		amount_changed.emit()
var scrap_amount = 10:
	set(value):
		scrap_amount = value
		amount_changed.emit()


@export var acid_rain_chance = 80:
	set(value):
		acid_rain_chance = value
		amount_changed.emit()
@export var UV_level = 9: #0-2 good, 3-5 med, 6-7 bad, 8-10 dead
	set(value):
		UV_level = value
		amount_changed.emit()
@export var CO2_level = 5.1: #.4 good, .4-1 meh, 1-2 bad, 2-5 too bad, >5 dead all in ppm
	set(value):
		CO2_level = value
		amount_changed.emit()
@export var forest_fire_chance= 20:
	set(value):
		forest_fire_chance = value
		amount_changed.emit()
@export var O2_level = 17: #21 is the goal
	set(value):
		O2_level = value
		amount_changed.emit()
@export var is_animal_alive = false:
	set(value):
		is_animal_alive = value
		amount_changed.emit()
@export var water_toxicity = 4:
	set(value):
		water_toxicity = value
		amount_changed.emit()

var is_uv_alright: bool = false
var is_co2_alright: bool = false
var is_water_alright: bool = false
var is_eco_alright: bool = true
var is_acid_alright: bool = false




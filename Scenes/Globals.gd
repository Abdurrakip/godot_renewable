extends Node

signal amount_changed
signal warn_active(string)

var heart_amount = 5:
	set(value):
		heart_amount = value
		amount_changed.emit()

var bolt_amount = 0:
	set(value):
		bolt_amount = value
		amount_changed.emit()
var screw_amount = 0:
	set(value):
		screw_amount = value
		amount_changed.emit()
var cable_amount = 0:
	set(value):
		cable_amount = value
		amount_changed.emit()
var scrap_amount = 0:
	set(value):
		scrap_amount = value
		amount_changed.emit()

var solved_poblems: int = 0
var has_key: bool = false


var is_dam_alright: bool = false
var is_solar_alright: bool = false
var is_wind_alright: bool = false
var is_geo_alright: bool = false

func set_warning(string):
	warn_active.emit(string)




extends Control




func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/intro.tscn")


func _on_button_2_pressed():
	$NinePatchRect/Menu.visible = false
	$NinePatchRect/Panel.visible = true


func _on_button_3_pressed():
	get_tree().quit()


func _on_audio_toggled(button_pressed):
	if button_pressed == true:
		AudioServer.set_bus_mute(0, false)
	else:
		AudioServer.set_bus_mute(0, true)


func _on_screen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_back_button_pressed():
	$NinePatchRect/Menu.visible = true
	$NinePatchRect/Panel.visible = false

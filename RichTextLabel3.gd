extends RichTextLabel

@export var time_to_print: float

@onready var timer: Timer = $Timer
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "visible_ratio", 1.0, time_to_print)
	timer.wait_time = time_to_print
	timer.start()
	audio_player.play()
	

func _on_timer_timeout():
	audio_player.stop()


func _on_button_pressed():
	get_tree().quit()

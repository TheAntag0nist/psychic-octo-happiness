extends TextureButton

onready var sound_off = $AudioStreamPlayer
var play_or_not = false

func _on_sound_off_pressed():
	if play_or_not:
		sound_off.stop()
		play_or_not = false
	else:
		sound_off.play()
		play_or_not = true
	pass # Replace with function body.

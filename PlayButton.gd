extends TextureButton

var started = false

func _on_PlayButton_pressed():
	get_parent().Mode = get_parent().Modes.LEVELS

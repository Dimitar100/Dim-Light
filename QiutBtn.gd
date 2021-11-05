extends TextureButton

var started = false

func _on_QuitBtn_pressed():
	get_tree().quit()

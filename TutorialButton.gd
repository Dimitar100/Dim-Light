extends TextureButton



func _on_TutorailButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Tutorial.tscn")

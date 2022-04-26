extends Node2D

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://World.tscn")

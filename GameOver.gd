extends Node2D

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://World.tscn")


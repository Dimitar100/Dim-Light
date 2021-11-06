extends Area2D

export var tutorial = false

func _on_End_body_entered(body):
	body.end = true
# warning-ignore:return_value_discarded
	if tutorial:
		get_tree().change_scene("res://World.tscn")
	else:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	#get_tree().change_scene("res://GameOver.tscn")

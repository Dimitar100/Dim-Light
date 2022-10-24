extends Area2D



func _on_KillPlayer_body_entered(_body):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://GameOver.tscn")
	#get_parent().get_node("UI").visible = true
	#get_parent().get_node("Player/Camera2D").current = false
	#get_parent().get_node("UICamera").current = true
	

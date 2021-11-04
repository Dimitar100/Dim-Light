extends Area2D

func _on_End_body_entered(body):
	body.end = true
	#get_tree().change_scene("res://GameOver.tscn")

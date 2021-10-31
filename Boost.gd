extends Area2D

func _on_Boost_body_entered(body):
	body.fast = body.fast * (-1)

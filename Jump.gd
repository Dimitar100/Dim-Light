extends Area2D

func _on_Jump_body_entered(body):
	body.motion.y = body.JUMP

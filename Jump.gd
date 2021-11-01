extends Area2D

export var direction = 1

func _on_Jump_body_entered(body):
	if direction == body.direction:
		body.motion.y = body.JUMP

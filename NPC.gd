extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 350
const FAST_SPEED = 600
const GRAVITY = 2000
const JUMP = -350
const WIND_TIMER = 3

var motion = Vector2(0, 0)
var target = Vector2(0, 0)
var end = false
var fast = -1

func _ready():
	var root_node = get_parent()
	var child_two = root_node.get_node("End")
	target = child_two.global_position

func _process(delta):
	
	motion.y += GRAVITY*delta
	
	if !end:
		if  global_position.x > target.x:
			if fast > 0:
				motion.x = -FAST_SPEED
			else:	
				motion.x = -SPEED
		elif global_position.x < target.x:
			if fast > 0:
				motion.x = FAST_SPEED
			else:	
				motion.x = SPEED
		
		if !is_on_floor() && motion.y > -200:
			$AnimatedSprite.play("Falling")
		else:
			$AnimatedSprite.play("Walking")
		
	else:
		motion.x = 0
		$AnimatedSprite.play("Idle")

	motion = move_and_slide(motion, UP)


func _on_Jump_body_entered(body):
	#body.queue_free()
	body.motion.y = -850


func _on_End_body_entered(body):
	body.end = true


func _on_Long_jump_body_entered(_body):
	fast = fast * (-1)

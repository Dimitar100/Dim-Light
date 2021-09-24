extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 150
const FAST_SPEED = 300
const GRAVITY = 2000
const JUMP = -700
const WIND_TIMER = 3

var motion = Vector2(0, 0)
var target = Vector2(0, 0)
var end = false
var fast = -1

func _ready():
	var root_node = get_parent()
	var child_two = root_node.get_node("End")
	target = child_two.global_position


func _apply_gravity(delta):
	motion.y += GRAVITY*delta

func _process(_delta):
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
	else:
		motion.x = 0

	motion = move_and_slide(motion, UP)


func _on_Jump_body_entered(body):
	#body.queue_free()
	body.motion.y = JUMP

func _on_End_body_entered(body):
	body.end = true

func _on_Long_jump_body_entered(_body):
	fast = fast * (-1)

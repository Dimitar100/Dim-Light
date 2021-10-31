extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 350
const FAST_SPEED = 600
const GRAVITY = 2000
const JUMP = -850
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

func _apply_movement(_delta):
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

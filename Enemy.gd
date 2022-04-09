extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 600
export var FAST_SPEED = 600
const GRAVITY = 2000
const JUMP = -800

var motion = Vector2(0, 0)
var target = Vector2(0, 0)
var fast = -1
var root_node
var child_two
var ready = true
var direction = -1
var on = true
var start = false

export var point1 = 4916
export var point2 = 6300

export var tutorial = false

func _ready():
	pass

func _apply_gravity(delta):
	if ready && !tutorial:
		motion.y += GRAVITY*delta
		

func _apply_movement(_delta):
	
	if ready && !tutorial:
		
		if  global_position.x >= point1 && direction == -1:
			$AnimatedSprite.flip_h = true
		elif global_position.x <= point2 && direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			motion.x = 0
			
		if fast > 0:
			motion.x = direction * FAST_SPEED
		else:	
			motion.x = direction * SPEED
			
		if global_position.x <= point1:
			direction = 1
		elif global_position.x >= point2:
			direction = -1
			
		motion = move_and_slide(motion, UP)
		
	else:
		$AnimatedSprite.play("Idle")
		

	
	

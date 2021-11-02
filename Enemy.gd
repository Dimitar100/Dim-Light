extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 600
const FAST_SPEED = 700
const GRAVITY = 2000
const JUMP = -800

var motion = Vector2(0, 0)
var target = Vector2(0, 0)
var fast = -1
var root_node
var child_two
var ready = true
var direction = 1
var on = true
var start = false

func _ready():
	child_two = get_parent().get_parent().get_node("Mage")
	if child_two == null:
		queue_free()
	else:
		target = child_two.global_position
		if  global_position.x > target.x:
			$AnimatedSprite.flip_h = true
			direction = -1

func _apply_gravity(delta):
	if ready:
		motion.y += GRAVITY*delta

func _apply_movement(_delta):
	
	if ready:
		$CollisionShape2D.disabled = false
		child_two = get_parent().get_parent().get_node("Mage")
		if child_two == null:
			queue_free()
		else:
			target = child_two.global_position
		
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
	else:
		$AnimatedSprite.visible = false

	
	

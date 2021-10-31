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
var ready = false
var direction
var on = true

func _ready():
	child_two = get_parent().get_node("Mage")
	target = child_two.global_position
	direction =  $AnimatedSprite.flip_h
	$AnimatedSprite.visible = false
	
func _apply_gravity(delta):
	motion.y += GRAVITY*delta

func _apply_movement(_delta):
	
	if ready:
		child_two = get_parent().get_node("Mage")
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

func _on_trigger_body_entered(_body):
	ready = true
	$AnimatedSprite.visible = true

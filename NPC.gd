extends KinematicBody2D

const UP = Vector2(0, -1)
export var SPEED = 350
const FAST_SPEED = 600
const GRAVITY = 2000
const JUMP = -850
const WIND_TIMER = 3

var motion = Vector2(0, 0)
var target = Vector2(0, 0)
var end = false
var fast = -1
var direction = 1
var start = false

func _ready():
	var root_node = get_parent()
	var child_two = root_node.get_node("End")
	target = child_two.global_position
	
	if global_position.x > target.x:
		$AnimatedSprite.flip_h = true
		direction = -1


func _apply_gravity(delta):
	motion.y += GRAVITY*delta

func _apply_movement(_delta):
	if !end && start:
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


func _on_Mage_body_entered(body):
	body.queue_free()
	queue_free()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://GameOver.tscn")
	

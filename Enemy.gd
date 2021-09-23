extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 600
const FAST_SPEED = 700
const GRAVITY = 2000
const JUMP = -350
const WIND_TIMER = 3

var motion = Vector2(0, 0)
var target = Vector2(0, 0)
var fast = -1
var root_node
var child_two
var ready = false
var direction

func _ready():
	root_node = get_parent()
	child_two = root_node.get_parent().get_node("NPC")
	target = child_two.global_position
	direction =  $AnimatedSprite.flip_h
	$AnimatedSprite.visible = false

func _process(delta):
	
	motion.y += GRAVITY*delta
	

	child_two = root_node.get_parent().get_node("NPC")
	target = child_two.global_position
	
	if ready:
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
			
			#if !is_on_floor():
			#	$AnimatedSprite.play("Falling")
			#else:
			$AnimatedSprite.play("Sprinting")
			
		else:
			motion.x = 0
			$AnimatedSprite.play("Idle")

		motion = move_and_slide(motion, UP)
	else:
		$AnimatedSprite.visible = false
		


func _on_EnemyJump_body_entered(body):
	body.motion.y = -750


func _on_Mage_body_entered(body):
	body.ready = false


func _on_trigger_body_entered(_body):
	ready = true
	$AnimatedSprite.visible = true


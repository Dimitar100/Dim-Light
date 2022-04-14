extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 2000
const STOP = 0

var motion = Vector2(0, 0)
var target = null
var direction = -1 #turn to enum
var in_range = false
var attack = false
var cooldown = false
var point1 = 4916
var point2 = 6300

export var point_left = 0
export var point_right = 0
export var tutorial = false
export var SPEED = 150

func _ready():
	$AttackCooldown.start()

func _apply_gravity(delta):
	motion.y += GRAVITY*delta
		

func _apply_movement(_delta):
	
	if !tutorial:
		
		if target != null:
			point1 = target.global_position.x
			point2 = target.global_position.x
		else:
			point1 = point_left
			point2 = point_right
		
		if  global_position.x >= point1 && direction == -1 && !$StateMachine.attack:
			$AnimatedSprite.flip_h = false
			attack = false
		elif global_position.x <= point2 && direction == 1 && !$StateMachine.attack:
			$AnimatedSprite.flip_h = true
			attack = false
		else:
			motion.x = 0
		
		if global_position.x <= point1 && !$StateMachine.attack:
			direction = 1
		elif global_position.x >= point2 && !$StateMachine.attack:
			direction = -1
			
		if target != null:
			var distance = target.global_position.x - global_position.x
			
			if distance < 0:
				distance *= -1
			
			if direction == -1 && distance < 68:
				motion.x = STOP
			elif direction == 1 && distance < 110:
				motion.x = STOP
			else:
				motion.x = direction * SPEED
		else:
			motion.x = direction * SPEED

		motion = move_and_slide(motion, UP)
	else:
		$AnimatedSprite.play("Idle")

func _on_Range_body_entered(body):
	in_range = true
	target = body

func _on_Range_body_exited(_body):
	in_range = false
	
func _play_anim(anim):
	$AnimatedSprite.play(anim)

func _on_Attack_left_body_entered(_body):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://GameOver.tscn")

func _on_Attack_right_body_entered(_body):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://GameOver.tscn")

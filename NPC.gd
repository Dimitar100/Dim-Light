extends KinematicBody2D

const UP = Vector2(0, -1)
export var SPEED = 350
const FAST_SPEED = 600
const GRAVITY = 2000
export var JUMP = -800
const WIND_TIMER = 3
const STOP = 0
const LIGHT_FLIP = 55
const FALLING_MOTION = 280
var falling_motion = 280

var light_tracker = 55
var light_step = 11

var motion = Vector2(0, 0)
var target = Vector2(0, 0)
var end = false
var fast = -1
var direction = 1
var start = false
var child_two
var stop = false

var is_idle = true
var is_mage = true

func _ready():
	var root_node = get_parent()
	child_two = root_node.get_node("Player")
	target = child_two.global_position
	
	if global_position.x > target.x:
		$AnimatedSprite.flip_h = true
		direction = -1


func _apply_gravity(delta):
	motion.y += GRAVITY*delta

func _apply_movement(_delta):
	var distance = child_two.global_position.x - global_position.x
	
	if Input.is_action_just_pressed("ui_space"):
		stop = !stop
	
	if !end && start && !stop:
		if is_on_floor():
			falling_motion = FALLING_MOTION
			if direction == -1 && distance > -68:
				motion.x = STOP
			elif direction == 1 && distance < 110:
				motion.x = STOP
			else:
				motion.x = SPEED * direction
		else:
			motion.x = falling_motion * direction
			falling_motion -= 1
	else:
		motion.x = 0
		
	if global_position.x > child_two.global_position.x && direction != -1 && is_on_floor():
		if child_two.move_direction < 0:
			$AnimatedSprite.flip_h = true
			direction = -1
			light_tracker = 0
	elif global_position.x < child_two.global_position.x && direction != 1 && is_on_floor():
		if child_two.move_direction > 0:
			$AnimatedSprite.flip_h = false
			direction = 1
			light_tracker = 0

	if light_tracker < LIGHT_FLIP:
			$Light2D.global_position.x = $Light2D.global_position.x + direction * light_step
			light_tracker += light_step

	motion = move_and_slide(motion, UP)


func _on_Mage_body_entered(_body):
	$AnimatedSprite.visible = false
	$Light2D.visible = false
	$BeforeDeath.start(1.5)

	
func dialogue(var text):
	$MageDialogue.set_text(text)
	$MageDialogue/Dialogue.visible = true
	
func end_dialogue():
	$MageDialogue/Dialogue.visible = true
	$MageDialogue.set_text("Well done!!!")
	$MageDialogue/Timer.start(3)
	start = true


func _on_BeforeDeath_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://GameOver.tscn")

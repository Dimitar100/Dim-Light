extends KinematicBody2D

const UP = Vector2(0, -1)
export var SPEED = 350
const FAST_SPEED = 600
const GRAVITY = 2000
const JUMP = -850
const WIND_TIMER = 3
const STOP = 0
const LIGHT_FLIP = 55

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
	
	if Input.is_action_just_pressed("ui_space"):
		stop = !stop
	
	if !end && start && !stop:
		if  global_position.x >  child_two.global_position.x:
			if fast > 0:
				motion.x = -FAST_SPEED
			else:	
				motion.x = -SPEED
		elif global_position.x < child_two.global_position.x:
			if fast > 0:
				motion.x = FAST_SPEED
			else:	
				motion.x = SPEED
	else:
		motion.x = 0
		
	if global_position.x > child_two.global_position.x && direction != -1:
		$AnimatedSprite.flip_h = true
		direction = -1
		light_tracker = 0
		#$Light2D.global_position.x = $Light2D.global_position.x - 55
	elif global_position.x < child_two.global_position.x && direction != 1:
		$AnimatedSprite.flip_h = false
		direction = 1
		light_tracker = 0
		#$Light2D.global_position.x = $Light2D.global_position.x + 55
		
	if light_tracker < LIGHT_FLIP:
			$Light2D.global_position.x = $Light2D.global_position.x + direction * light_step
			light_tracker += light_step
			
	var distance = child_two.global_position.x - global_position.x
		
	if distance < 0:
		distance *= -1
		
	if direction == -1 && distance < 68:
		motion.x = STOP
	elif direction == 1 && distance < 110:
		motion.x = STOP

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

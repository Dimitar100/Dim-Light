extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 650
const ATACK_SPEED = 200
const JUMP_SPEED = 500
const GRAVITY = 2000
const JUMP = -850
var speed = 0
var start = false

var motion = Vector2(0, 0)
var move_direction = 0

func _ready():
	$Sprite_right.visible = true

func _play_anim(anim):
	$Sprite_right.play(anim)
	$Sprite_left.play(anim)

func _apply_gravity(delta):
	motion.y += GRAVITY*delta

func _handle_move_input():
	if start:
		if !Input.is_action_just_pressed("ui_click_left"):
			move_direction = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
			if move_direction == 0:
				speed = 0
		else:
			speed = 0

		if move_direction > 0:
			$Sprite_right.visible = true
			$Sprite_left.visible = false
		if move_direction < 0:
			$Sprite_right.visible = false
			$Sprite_left.visible = true

func _stop_movement():
	speed = 0

func _is_falling():
	return is_on_floor()

func _apply_movement(_delta):
	motion.x = speed * move_direction 
	motion = move_and_slide(motion, UP)
	
func kill():
	$Sprite_left.visible = false
	$Sprite_right.visible = false
	start = false
	$BeforeDeath.start(1.5)

func call_mage():
	get_parent().get_node("Mage").dialogue("You have found a gem! Good job!")
	get_parent().get_node("Mage").get_node("MageDialogue").get_node("Timer").start(3)

func _on_BeforeDeath_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://GameOver.tscn")

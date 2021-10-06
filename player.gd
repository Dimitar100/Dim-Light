extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 650
const ATACK_SPEED = 200
const GRAVITY = 2000
const JUMP = -850
var speed

var motion = Vector2(0, 0)
var move_direction = 0
var atack = false
onready var anim_player = get_node("Sprite_right")

func _play_anim(anim):
	$Sprite_left.play(anim)
	$Sprite_right.play(anim)

func _apply_gravity(delta):
	motion.y += GRAVITY*delta

func _handle_move_input():
	
	move_direction = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
	if move_direction != 0 && Input.is_action_just_pressed("ui_click_left"):
		speed = ATACK_SPEED
	elif move_direction != 0:
		speed = SPEED
	elif move_direction == 0:
		speed = 0

	if move_direction > 0:
		$Sprite_right.visible = true
		$Sprite_left.visible = false
	if move_direction < 0:
		$Sprite_right.visible = false
		$Sprite_left.visible = true


func _apply_movement(_delta):
	motion.x = speed * move_direction 
	motion = move_and_slide(motion, UP)
	



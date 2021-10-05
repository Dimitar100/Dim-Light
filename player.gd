extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 650
const ATACK_SPEED = 200
const GRAVITY = 2000
const JUMP = -850

var motion = Vector2(0, 0)
var move_direction
var atack = false
onready var anim_player = get_node("Sprite_right")

func _apply_gravity(delta):
	motion.y += GRAVITY*delta

func _handle_move_input():
	move_direction = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	motion.x = SPEED * move_direction 
	if move_direction > 0:
		$Sprite_right.visible = true
		$Sprite_left.visible = false
		anim_player = $Sprite_right
	elif move_direction < 0:
		$Sprite_right.visible = false
		$Sprite_left.visible = true
		anim_player = $Sprite_left

func _apply_movement(_delta):
	motion = move_and_slide(motion, UP)
	



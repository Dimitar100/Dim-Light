extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 400
const ATACK_SPEED = 200
const GRAVITY = 2000
const JUMP = -500
const WIND_TIMER = 3

var motion = Vector2(0, 0)

func play_walk_left():
	motion.x = -SPEED
	if is_on_floor():
		$Sprite_left.play("Walk")
		$Sprite_right.visible = false
		$Sprite_left.visible = true
	else:
		$Sprite_right.visible = false
		$Sprite_left.visible = true


func _process(delta):

	motion.y += GRAVITY*delta

	if Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_left"):
		
		motion.x = SPEED
		if is_on_floor():
			$Sprite_right.play("Walk")
			$Sprite_left.visible = false
			$Sprite_right.visible = true
		else:
			$Sprite_left.visible = false
			$Sprite_right.visible = true
	elif Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		if Input.is_action_just_pressed("ui_click_left"):
			$Sprite_left.play("1Atack")
			$Sprite_right.visible = false
			$Sprite_left.visible = true
		else:
			if $Sprite_left.get_animation() != "1Atack":
				play_walk_left()
			elif $Sprite_left.frame == $Sprite_left.frames.get_frame_count("1Atack") - 1:
				play_walk_left()
				
	elif Input.is_action_just_pressed("ui_click_left"):
		if $Sprite_left.visible:
			$Sprite_left.play("1Atack")
		elif $Sprite_right.visible:
			$Sprite_right.play("Idle")
	else:
		if $Sprite_left.visible && is_on_floor() && $Sprite_left.get_animation() != "1Atack":
			$Sprite_left.play("Idle")
			pass
		elif $Sprite_right.visible && is_on_floor() && $Sprite_right.get_animation() != "1Atack":
			$Sprite_right.play("Idle")

	if $Sprite_left.get_animation() == "1Atack" && $Sprite_left.frame == $Sprite_left.frames.get_frame_count("1Atack") - 1:
			$Sprite_left.play("Idle")
			

	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			if $Sprite_right.visible:
				$Sprite_right.play("Jump")
			else:
				$Sprite_left.play("Jump")
				
			yield(get_tree().create_timer(20*delta), "timeout")
			motion.y = JUMP

	if $Sprite_left.get_animation() == "1Atack" &&  Input.is_action_pressed("ui_left"):
		motion.x = -ATACK_SPEED

	motion = move_and_slide(motion, UP)
	motion.x = 0



extends StateMachine

var atack = false
var direction = 0

func _ready():
	add_state("idle")
	add_state("walk")
	add_state("fall")
	add_state("jump")
	add_state("atack")
	add_state("dead")
	call_deferred("set_state", states.idle)
	
func _atack_done_check():
	if parent.get_node("Sprite_right").get_animation() == "Atack" || parent.get_node("Sprite_left").get_animation() == "Atack":
			if parent.get_node("Sprite_right").frame == parent.get_node("Sprite_right").frames.get_frame_count("Atack") - 1:
				return true
			elif parent.get_node("Sprite_left").frame == parent.get_node("Sprite_left").frames.get_frame_count("Atack") - 1:
				return true
			else:
				return false
	else:
		return true

func _input(_event):
	if [states.idle, states.walk, states.atack].has(state):
		#JUMP
		if Input.is_action_pressed("ui_up"):
			if parent.is_on_floor():
				parent.motion.y = parent.JUMP

	if ![states.dead].has(state):
			if Input.is_action_just_pressed("ui_click_left"):
				atack = true

func _state_logic(delta):
	parent._handle_move_input()
	parent._apply_gravity(delta)
	parent._apply_movement(delta)

func _get_transition(_delta):
	match state:
		states.idle:
			parent.speed = parent.SPEED
			if parent.is_on_floor():
				prev_state = states.idle
			if !parent.is_on_floor():
				if parent.motion.y < 0:
					if prev_state == states.atack:
						return states.fall
					else:
						return states.jump
				if parent.motion.y >= 0:
					return states.fall
			elif parent.motion.x != 0:
				return states.walk
			elif atack:
				return states.atack
		states.walk:
			parent.speed = parent.SPEED
			direction = parent.move_direction
			if !parent.is_on_floor():
				if parent.motion.y < 0:
					return states.jump
				if parent.motion.y >= 0:
					return states.fall
			elif parent.motion.x == 0:
				return states.idle
			elif atack:
				return states.atack
		states.jump:
			parent.speed = parent.JUMP_SPEED
			if parent.is_on_floor():
				return states.idle
			elif parent.motion.y >= 0:
				return states.fall
			elif atack:
				return states.atack
		states.fall:
			parent.speed = parent.JUMP_SPEED
			if parent.is_on_floor():
				return states.idle
			elif atack:
				return states.atack
		states.atack:
			parent.speed = parent.SPEED
			if _atack_done_check():
				if parent.get_node("Sprite_right").get_animation() == "Atack" && parent.get_node("Sprite_right").frame == parent.get_node("Sprite_right").frames.get_frame_count("Atack") - 1:
					atack = false
					return states.idle
				elif parent.get_node("Sprite_left").get_animation() == "Atack" && parent.get_node("Sprite_left").frame == parent.get_node("Sprite_left").frames.get_frame_count("Atack") - 1:
					atack = false
					return states.idle
				elif direction == 0 && parent.move_direction != 0:
					atack = false
					return states.idle
				elif direction == (-1 * parent.move_direction) && (direction != 0 && parent.move_direction != 0):
					atack = false
					return states.walk
	return null
				
func _enter_state(new_state, _old_state):
	match new_state:
		states.idle:
			parent._play_anim("Idle")
		states.walk:
			parent._play_anim("Walk")
		states.jump:
			parent._play_anim("Jump")
		#states.fall:
			#parent._play_anim("Fall")
		#states.atack:
			#parent.anim_player.play("Atack")

func _exit_state(_old_state, _new_state):
	pass

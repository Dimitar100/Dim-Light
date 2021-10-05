extends StateMachine

func _ready():
	add_state("idle")
	add_state("walk")
	add_state("fall")
	add_state("jump")
	add_state("atack")
	add_state("atack_move")
	call_deferred("set_state", states.idle)

func _input(_event):
	if [states.idle, states.walk, states.atack].has(state):
		#JUMP
		if Input.is_action_pressed("ui_up"):
			parent.motion.y = parent.JUMP
	if state != states.jump:
		if Input.is_action_just_pressed("ui_click_left") && (Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left")):
			parent.atack = true
			parent.motion.x = parent.ATACK_SPEED * parent.move_direction
		elif Input.is_action_just_pressed("ui_click_left"):
			parent.atack = true
			#pass

func _state_logic(delta):
	parent._handle_move_input()
	parent._apply_gravity(delta)
	parent._apply_movement(delta)

func _get_transition(_delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.motion.y < 0:
					return states.jump
				if parent.motion.y >= 0:
					return states.fall
			elif parent.motion.x != 0:
				return states.walk
			elif parent.atack:
				return states.atack
		states.walk:
			if !parent.is_on_floor():
				if parent.motion.y < 0:
					return states.jump
				if parent.motion.y >= 0:
					return states.fall
			elif parent.motion.x == 0:
				return states.idle
			elif parent.atack:
				return states.atack
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.atack:
				return states.atack
			elif parent.motion.y >= 0:
				return states.fall
		states.fall:
			if parent.is_on_floor():
				print("ok")
				return states.idle
			elif parent.motion.y < 0:
				return states.jump
			elif parent.atack:
				print("ok1")
				return states.atack
		states.atack:
			if !parent.is_on_floor():
				if parent.motion.y < 0:
					parent.atack = false
					return states.jump
				if parent.motion.y > 0:
					parent.atack = false
					return states.fall
			if parent.anim_player.get_animation() == "Atack" && parent.anim_player.frame == parent.anim_player.frames.get_frame_count("Atack") - 1:
				parent.atack = false
				return states.idle

	return null
				
func _enter_state(new_state, _old_state):
	match new_state:
		states.idle:
			parent.anim_player.play("Idle")
		states.walk:
			parent.anim_player.play("Walk")
		states.jump:
			parent.anim_player.play("Jump")
		states.atack:
			parent.anim_player.play("Atack")
			
	
func _exit_state(_old_state, _new_state):
	pass

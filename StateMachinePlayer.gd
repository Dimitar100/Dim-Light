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
	if parent.start:
		if parent.get_node("Sprite_right").get_animation() == "Atack" || parent.get_node("Sprite_left").get_animation() == "Atack":
		#if !parent.get_node("Atack_right").get_node("CollisionShape2D").disabled || !parent.get_node("Atack_left").get_node("CollisionShape2D").disabled:
			if parent.get_node("Sprite_right").frame == parent.get_node("Sprite_right").frames.get_frame_count("Atack") - 1:
				return true
			elif parent.get_node("Sprite_left").frame == parent.get_node("Sprite_left").frames.get_frame_count("Atack") - 1:
				return true
			else:
				return false
		else:
			return true

func _input(_event):
	
	if parent.start:
		if [states.idle, states.walk, states.atack].has(state):
			#JUMP
			if Input.is_action_pressed("ui_up"):
				if parent.is_on_floor():
					parent.motion.y = parent.JUMP

		if ![states.dead].has(state):
				if Input.is_action_just_pressed("ui_click_left"):
					atack = true

func _state_logic(delta):
	
	if _atack_done_check():
		parent._handle_move_input()
	else: 
		if parent._is_falling():
			parent._stop_movement()
	
	parent._apply_movement(delta)
	parent._apply_gravity(delta)

func _get_transition(_delta):
	match state:
		states.atack:
			parent.speed = parent.JUMP_SPEED
			if _atack_done_check():
				if parent.get_node("Sprite_right").get_animation() == "Atack" && parent.get_node("Sprite_right").frame == parent.get_node("Sprite_right").frames.get_frame_count("Atack") - 1:
					atack = false
					return states.idle
				elif parent.get_node("Sprite_left").get_animation() == "Atack" && parent.get_node("Sprite_left").frame == parent.get_node("Sprite_left").frames.get_frame_count("Atack") - 1:
					atack = false
					return states.idle
				elif !parent.is_on_floor():
					atack = false
					return states.fall
				elif direction == 0 && parent.move_direction != 0:
					atack = false
					return states.idle
				elif direction == (-1 * parent.move_direction) && (direction != 0 && parent.move_direction != 0):
					atack = false
					return states.walk
				else:
					#print("hi")
					atack = false
					return states.idle
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
			#parent.get_node("FootSteps").stream_paused = false
			if !parent.is_on_floor():
				if parent.motion.y < 0:
					#parent.get_node("FootSteps").stream_paused = true
					return states.jump
				if parent.motion.y >= 0:
					#parent.get_node("FootSteps").stream_paused = true
					return states.fall
			elif parent.motion.x == 0:
				#parent.get_node("FootSteps").stream_paused = true
				return states.idle
			elif atack:
				#parent.get_node("FootSteps").stream_paused = true
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
		
	return null
				
func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent._play_anim("Idle")
		states.walk:
			parent._play_anim("Walk")
			parent.get_node("FootSteps").stream_paused = false
		states.jump:
			parent._play_anim("Jump")
			parent.get_node("Jump").play()
		states.fall:
			pass
		#states.atack:
			#parent.anim_player.play("Atack")
			
	match old_state:
		states.idle:
			pass
		states.walk:
			parent.get_node("FootSteps").stream_paused = true
		states.jump:
			pass
		states.fall:
			if parent.start == true:
				parent.get_node("Fall").play()
		

func _exit_state(_old_state, _new_state):
	pass

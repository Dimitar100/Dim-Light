extends StateMachine

var atack = false
var direction = 0

func _ready():
	add_state("idle")
	add_state("walk")
	add_state("fall")
	add_state("jump")
	add_state("atack")
	add_state("atack_move")
	add_state("dead")
	call_deferred("set_state", states.idle)

func _input(_event):
	if [states.idle, states.walk, states.atack, states.atack_move].has(state):
		#JUMP
		if Input.is_action_pressed("ui_up"):
			parent.motion.y = parent.JUMP
	
	if ![states.dead, states.jump].has(state):
			if Input.is_action_just_pressed("ui_click_left"):
				atack = true

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
			elif atack:
				return states.atack
		states.walk:
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
			if parent.is_on_floor():
				return states.idle
			elif parent.motion.y >= 0:
				return states.fall
			#elif atack:
				#return states.atack	
		states.fall:
			if parent.is_on_floor():
				return states.idle
			elif parent.motion.y < 0:
				return states.jump
			elif atack:
				return states.atack
		states.atack:
			if parent.anim_player.get_animation() == "Atack" && parent.anim_player.frame == parent.anim_player.frames.get_frame_count("Atack") - 1:
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
			parent.anim_player.play("Idle")
		states.walk:
			parent.anim_player.play("Walk")
		states.jump:
			parent.anim_player.play("Jump")
		states.atack:
			parent.anim_player.play("Atack")
		states.atack_move:
			parent.anim_player.play("Atack")
			
	
func _exit_state(_old_state, _new_state):
	pass

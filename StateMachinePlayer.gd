extends StateMachine

func _ready():
	add_state("idle")
	add_state("walk")
	add_state("fall")
	add_state("jump")
	add_state("atack")
	call_deferred("set_state", states.idle)

func _input(_event):
	if [states.idle, states.walk].has(state):
		#JUMP
		pass

func _state_logic(delta):
	parent._handle_move_input()
	parent._apply_gravity(delta)
	parent._apply_movement(delta)

func _get_transition(_delta):
	match state:
		states.idle:
			pass

	
	return null
				
func _enter_state(_new_state, _old_state):
	pass
	
func _exit_state(_old_state, _new_state):
	pass

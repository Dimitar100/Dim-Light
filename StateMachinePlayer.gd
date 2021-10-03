extends StateMachine

func _ready():
	add_state("Idle")
	add_state("Walking")
	call_deferred("set_state", states.Idle)

#func _input(event):

func _state_logic(delta):
	parent._apply_gravity(delta)
	parent._apply_movement(delta)

func _get_transition(_delta):
	match state:
		states.Idle:
			pass

	
	return null
				
func _enter_state(new_state, _old_state):
	pass
	
func _exit_state(_old_state, _new_state):
	pass

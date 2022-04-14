extends StateMachine

func _ready():
	add_state("idle")
	add_state("walk")
	add_state("attack")
	add_state("post_attack")
	call_deferred("set_state", states.idle)

func _state_logic(delta):
	parent._apply_gravity(delta)
	parent._apply_movement(delta)

func _get_transition(_delta):
	pass
				
func _enter_state(_new_state, _old_state):
	pass
	
func _exit_state(_old_state, _new_state):
	pass




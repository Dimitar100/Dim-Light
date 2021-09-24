extends StateMachine

func _ready():
	add_state("Idle")
	add_state("Walking")
	add_state("Falling")
	call_deferred("set_state", states.Idle)


func _state_logic(delta):
	parent._apply_gravity(delta)
	parent._process(delta)

func _get_transition(_delta):
	match state:
		states.Idle:
			if !parent.is_on_floor():
				return states.Falling
			elif parent.motion.x != 0:
				return states.Walking
		states.Walking:
			if !parent.is_on_floor():
				return states.Falling
			elif parent.motion.x == 0:
				return states.Idle
		states.Falling:
			if parent.is_on_floor():
				return states.Walking
	
	return null
				
func _enter_state(new_state, _old_state):
	match new_state:
		states.Idle:
			parent.get_node("AnimatedSprite").play("Idle")
		states.Walking:
			parent.get_node("AnimatedSprite").play("Walking")
		states.Falling:
			parent.get_node("AnimatedSprite").play("Falling")
	
func _exit_state(_old_state, _new_state):
	pass
	

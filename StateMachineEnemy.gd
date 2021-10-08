extends StateMachine

func _ready():
	add_state("idle")
	add_state("sprint")
	add_state("fall")
	add_state("jump")
	call_deferred("set_state", states.idle)

func _state_logic(delta):
	parent._apply_gravity(delta)
	parent._apply_movement(delta)

func _get_transition(_delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.motion.y > 0:
					return states.fall
				elif parent.motion.y <= 0:
					return states.jump
			elif parent.motion.x != 0:
				return states.sprint
		states.sprint:
			if !parent.is_on_floor():
				if parent.motion.y > 0:
					return states.fall
				elif parent.motion.y <= 0:
					return states.jump
			elif parent.motion.x == 0:
				return states.idle
		states.fall:
			if parent.is_on_floor():
				return states.sprint
			elif !parent.is_on_floor():
				if parent.motion.y <= 0:
					return states.jump
		states.jump:
			if parent.is_on_floor():
				return states.sprint
			elif !parent.is_on_floor():
				if parent.motion.y > -10:
					return states.fall
	
	return null
				
func _enter_state(new_state, _old_state):
	match new_state:
		states.idle:
			parent.get_node("AnimatedSprite").play("Idle")
		states.sprint:
			parent.get_node("AnimatedSprite").play("Sprint")
		states.fall:
			parent.get_node("AnimatedSprite").play("Fall")
		states.jump:
			parent.get_node("AnimatedSprite").play("Jump")
	
func _exit_state(_old_state, _new_state):
	pass



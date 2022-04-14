extends StateMachine

var attack = false
var direction = 0
var attackCooldown = false

func _ready():
	add_state("idle")
	add_state("walk")
	add_state("attack")
	add_state("post_attack")
	call_deferred("set_state", states.idle)

func _atack_done_check():
	if parent.get_node("AnimatedSprite").get_animation() == "Atack":
			if parent.get_node("AnimatedSprite").frame == parent.get_node("AnimatedSprite").frames.get_frame_count("Attack") - 1:
				return true
			else:
				return false
	else:
		return true

func _state_logic(delta):
	parent._apply_gravity(delta)
	parent._apply_movement(delta)

func _get_transition(_delta):
	match state:
		states.attack:
			parent.get_node("AttackCooldown").start()
			attackCooldown = true
			attack = true
			if parent.get_node("AnimatedSprite").frame == parent.get_node("AnimatedSprite").frames.get_frame_count("Attack") - 1:
				attack = false
				return states.post_attack
		states.post_attack:
			if parent.get_node("AnimatedSprite").frame == parent.get_node("AnimatedSprite").frames.get_frame_count("PostAttack") - 1:
				if parent.motion.x != 0:
					return states.walk
				else:
					return states.idle
		states.idle:
			if parent.motion.x != 0:
				return states.walk
			elif parent.in_range && !attackCooldown:
				return states.attack
		states.walk:
			if parent.motion.x == 0:
				return states.idle
			elif parent.in_range && !attackCooldown:
				return states.attack

	return null

func _enter_state(new_state, _old_state):
	match new_state:
		states.idle:
			parent._play_anim("Idle")
		states.walk:
			parent._play_anim("Walk")
		states.attack:
			parent._play_anim("Attack")
		states.post_attack:
			parent._play_anim("PostAttack")
	
func _exit_state(_old_state, _new_state):
	pass

func _on_AttackCooldown_timeout():
	attackCooldown = false

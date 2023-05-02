extends StateMachine

var attack = false
var direction = 0
var attackCooldown = false

func _ready():
	add_state("idle")
	add_state("walk")
	add_state("attack")
	add_state("post_attack")
	add_state("take_dmg")
	add_state("pre_attack")
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
	parent._attack_indicator()

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
			parent.get_node("AttackIndicator").visible = false
			if parent.get_node("AnimatedSprite").frame == parent.get_node("AnimatedSprite").frames.get_frame_count("PostAttack") - 1:
				if parent.motion.x != 0:
					return states.walk
				elif parent.motion.x == 0 && parent.target != null:
					return states.take_dmg
				else:
					return states.idle
		states.pre_attack:
			if parent.get_node("AttackIndicator").visible:
				return states.attack
			else:
				print("hi")
				return states.walk
		states.idle:
			if parent.motion.x != 0:
				return states.walk
			elif !attackCooldown:
				return states.attack
		states.walk:
			parent.get_node("AttackIndicator").visible = false
			if parent.motion.x == 0 && parent.target != null:
				return states.take_dmg
			elif parent.motion.x == 0:
				return states.idle
			elif parent.in_range && !attackCooldown:
				parent.get_node("AttackCooldown").start()
				attackCooldown = true
				return states.pre_attack
		states.take_dmg:
			if parent.motion.x != 0:
				return states.walk
			elif parent.in_range && !attackCooldown:
				return states.attack
			#if !parent.take_dmg:
				#if parent.motion.x == 0:
					#return states.idle
				#elif parent.motion.x != 0:
					#return states.walk
				#elif parent.in_range && !attackCooldown:
					#return states.attack

	return null

func _enter_state(new_state, _old_state):
	match new_state:
		states.idle:
			parent._play_anim("TakeDmg")
		states.walk:
			parent._play_anim("Walk")
		states.attack:
			parent._play_anim("Attack")
		states.post_attack:
			parent._play_anim("PostAttack")
		states.take_dmg:
			parent._play_anim("TakeDmg")
		states.pre_attack:
			parent._play_anim("TakeDmg")
	
func _exit_state(_old_state, _new_state):
	pass

func _on_AttackCooldown_timeout():
	attackCooldown = false

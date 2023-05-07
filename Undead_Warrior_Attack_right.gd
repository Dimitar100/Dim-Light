extends Area2D

var extend = 100
var collision_loc_x

var in_motion = false
var finished = false

func _ready():
	pass

func _physics_process(_delta):
	if get_parent().get_node("AnimatedSprite").flip_h:
		
		if get_parent().get_node("StateMachine").attack && !in_motion && !finished:
			if get_parent().get_node("AnimatedSprite").frame == 3:
				if get_parent().motion.x == 0:
					extend = 50
				else:
					extend = 100
					
				collision_loc_x = global_position.x + extend
				in_motion = true
			
		if in_motion:
			$CollisionShape2D.disabled = false
			if global_position.x <= collision_loc_x:
				global_position.x = global_position.x + 1.7
			else:
				endAttack()
				finished = true
	else:
		endAttack()

func _on_AttackCooldown_timeout():
	finished = false
	
func endAttack():
	$CollisionShape2D.disabled = true
	global_position.x = get_parent().get_node("AnimatedSprite").global_position.x
	in_motion = false
	

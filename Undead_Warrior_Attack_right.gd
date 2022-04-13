extends Area2D

var root_node
var extend = 100
var stop = true
var collision_loc_x

var in_motion = false
var start_loc
var finished = false
var started = false

func _ready():
	root_node = get_parent()

func _physics_process(_delta):
	if get_parent().get_node("AnimatedSprite").flip_h:
		
		if get_parent().attack && !in_motion && !finished:
			start_loc = $CollisionShape2D.global_position.x
			collision_loc_x = start_loc + extend
			in_motion = true
			
		if in_motion:
			$CollisionShape2D.disabled = false
			if $CollisionShape2D.global_position.x <= collision_loc_x:
				$CollisionShape2D.global_position.x = $CollisionShape2D.global_position.x + 1
			else:
				$CollisionShape2D.disabled = true
				$CollisionShape2D.global_position.x = get_parent().get_node("AnimatedSprite").global_position.x + 52 #the space between the animated sprite and the collision shape
				in_motion = false
				finished = true

func _on_AttackCooldown_timeout():
	finished = false

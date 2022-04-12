extends Area2D

var root_node
var collision_x = -52
var collision_x_extended = -84
var stop = true

func _ready():
	root_node = get_parent()

func _physics_process(_delta):
	if !get_parent().tutorial && !stop:
		if get_parent().attack:
			$CollisionShape2D.disabled = false
			if $CollisionShape2D.global_position.x > collision_x_extended:
				$CollisionShape2D.global_position.x = $CollisionShape2D.global_position.x - 5.4
			#yield(get_tree().create_timer(15*delta), "timeout")
		else:
			$CollisionShape2D.disabled = true
			if $CollisionShape2D.global_position.x < collision_x:
				$CollisionShape2D.global_position.x = $CollisionShape2D.global_position.x + 5.4


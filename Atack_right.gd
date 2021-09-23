extends Area2D

var root_node
var child

func _ready():
	root_node = get_parent()
	child = root_node.get_node("Sprite_right")

func _process(delta):
	
	if Input.is_action_just_pressed("ui_click_left") && child.visible :
		yield(get_tree().create_timer(50*delta), "timeout")
		$CollisionShape2D.disabled = false
		yield(get_tree().create_timer(50*delta), "timeout")
		$CollisionShape2D.disabled = true

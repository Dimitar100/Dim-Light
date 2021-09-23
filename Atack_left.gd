extends Area2D

var root_node
var child

func _ready():
	root_node = get_parent()
	child = root_node.get_node("Sprite_left")

func _process(delta):
	
	if Input.is_action_just_pressed("ui_click_left") && child.visible :
		$CollisionShape2D.disabled = false
		yield(get_tree().create_timer(100*delta), "timeout")
		$CollisionShape2D.disabled = true


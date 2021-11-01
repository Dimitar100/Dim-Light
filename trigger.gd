extends Area2D

var on = true
var root_node

func _ready():
	root_node = get_parent()
	#$Sprite.visible = false

func _process(_delta):
	on = root_node.on
	if !on:
		$CollisionShape2D.disabled = true

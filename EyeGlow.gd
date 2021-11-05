extends Light2D

var parent

func _ready():
	parent = get_parent()

func _physics_process(_delta):
	print(parent.get_node("AnimatedSprite").get_animation())
	pass


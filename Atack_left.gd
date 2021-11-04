extends Area2D

var root_node
var child

func _ready():
	root_node = get_parent()
	child = root_node.get_node("Sprite_left")

func _physics_process(delta):
	if get_parent().start:
		if Input.is_action_just_pressed("ui_click_left") && child.visible :
			$CollisionShape2D.disabled = false
			child.play("Atack")
			yield(get_tree().create_timer(15*delta), "timeout")
			$CollisionShape2D.disabled = true



func _on_Atack_left_body_entered(body):
	#body.ready = false
	#body.on = false
	body.queue_free()

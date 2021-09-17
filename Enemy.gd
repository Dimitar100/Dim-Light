extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 250
const GRAVITY = 2000
const JUMP = -350
const WIND_TIMER = 3

var motion = Vector2(0, 0)
var target = Vector2(0, 0)
var end = false

func _ready():
	pass

func _process(delta):
	
	motion.y += GRAVITY*delta
	motion = move_and_slide(motion, UP)


func _on_Jump_body_entered(body):
	#body.queue_free()
	body.motion.y = -850



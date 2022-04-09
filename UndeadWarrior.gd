extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 600
export var FAST_SPEED = 600
const GRAVITY = 2000

var motion = Vector2(0, 0)
var target = Vector2(0, 0)

var in_range = false



export var tutorial = false

func _ready():
	pass

func _apply_gravity(delta):
	motion.y += GRAVITY*delta
		

func _apply_movement(_delta):
	
	if in_range:
		$AnimatedSprite.play("Attack")
	else:
		$AnimatedSprite.play("Idle")
		

	
func _on_Range_body_entered(_body):
	in_range = true

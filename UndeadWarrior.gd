extends KinematicBody2D

const UP = Vector2(0, -1)
export var FAST_SPEED = 600
const GRAVITY = 2000

var motion = Vector2(0, 0)
var target = Vector2(0, 0)
var direction = -1
var in_range = false

export var point1 = 4916
export var point2 = 6300
export var tutorial = false
export var SPEED = 150

func _ready():
	pass

func _apply_gravity(delta):
	motion.y += GRAVITY*delta
		

func _apply_movement(_delta):
	
	if !tutorial:
		
		if  global_position.x >= point1 && direction == -1:
			$AnimatedSprite.flip_h = false
		elif global_position.x <= point2 && direction == 1:
			$AnimatedSprite.flip_h = true
		else:
			motion.x = 0
			
		motion.x = direction * SPEED
			
		if global_position.x <= point1:
			direction = 1
		elif global_position.x >= point2:
			direction = -1
			
		motion = move_and_slide(motion, UP)
		
	else:
		$AnimatedSprite.play("Idle")
	
	if in_range:
		$AnimatedSprite.play("Attack")
	else:
		if $AnimatedSprite.animation == "Attack":
			if $AnimatedSprite.frame == $AnimatedSprite.frames.get_frame_count("Attack")-1:
				$AnimatedSprite.play("Walk")
		else:
			$AnimatedSprite.play("Walk")
		

	
func _on_Range_body_entered(_body):
	in_range = true


func _on_Range_body_exited(_body):
	in_range = false

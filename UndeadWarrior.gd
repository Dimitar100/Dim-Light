extends KinematicBody2D

const UP = Vector2(0, -1)
export var FAST_SPEED = 600
const GRAVITY = 2000

var motion = Vector2(0, 0)
var target = null
var direction = -1
var in_range = false
var attack = false
var cooldown = false


export var point1 = 4916
export var point2 = 6300
export var tutorial = false
export var SPEED = 150

func _ready():
	$AttackCooldown.start()

func _apply_gravity(delta):
	motion.y += GRAVITY*delta
		

func _apply_movement(_delta):
	
	if !tutorial:
		if target != null:
			point1 = target.global_position.x
			point2 = target.global_position.x
		
		if  global_position.x >= point1 && direction == -1 && (!$AnimatedSprite.animation == "AttackV2" || $AnimatedSprite.frame > 5):
			$AnimatedSprite.flip_h = false
		elif global_position.x <= point2 && direction == 1 && (!$AnimatedSprite.animation == "AttackV2" || $AnimatedSprite.frame > 5):
			$AnimatedSprite.flip_h = true
		else:
			motion.x = 0
			
		motion.x = direction * SPEED
			
		if global_position.x <= point1  && (!$AnimatedSprite.animation == "AttackV2" || $AnimatedSprite.frame > 5):
			direction = 1
		elif global_position.x >= point2  && (!$AnimatedSprite.animation == "AttackV2" || $AnimatedSprite.frame > 5):
			direction = -1
			
		motion = move_and_slide(motion, UP)

	else:
		pass
		#$AnimatedSprite.play("Idle")
	
	if in_range:
		if cooldown == false:
			$AnimatedSprite.play("AttackV2")
			attack = true
			$AttackCooldown.start()
			cooldown = true
		else:
			if $AnimatedSprite.animation == "AttackV2":
				if $AnimatedSprite.frame == $AnimatedSprite.frames.get_frame_count("AttackV2")-1:
					$AnimatedSprite.play("WalkV2")
					attack = false
	else:
		if $AnimatedSprite.animation == "AttackV2":
			if $AnimatedSprite.frame == $AnimatedSprite.frames.get_frame_count("AttackV2")-1:
				$AnimatedSprite.play("WalkV2")
				attack = false
		else:
			$AnimatedSprite.play("WalkV2")
		

	
func _on_Range_body_entered(body):
	in_range = true
	target = body


func _on_Range_body_exited(_body):
	in_range = false


func _on_AttackCooldown_timeout():
	cooldown = false



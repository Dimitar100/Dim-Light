extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 2000
const STOP = 0

var motion = Vector2(0, 0)
var target = null
var direction = -1 #turn to enum
var in_range = false
var attack = false
var cooldown = false
var take_dmg = false
var knockback_loc = 0
var point1 = 4916
var point2 = 6300

export var point_left = 0
export var point_right = 0
export var tutorial = false
export var SPEED = 150
export var health = 1000

var player = false

func _ready():
	#$AttackCooldown.start()
	pass

func _apply_gravity(delta):
	motion.y += GRAVITY*delta
		

func _apply_movement(_delta):
	
	if health <= 0:
		queue_free()
		get_parent().get_node("Mage").end_dialogue()
	
	if !tutorial:
		
		flash()
		
		if target != null:
			point1 = target.global_position.x
			point2 = target.global_position.x
		else:
			point1 = point_left
			point2 = point_right
		
		if  global_position.x >= point1 && direction == -1 && !$StateMachine.attack:
			$AnimatedSprite.flip_h = false
			$CollisionShape2D.global_position.x = global_position.x + 25
			attack = false
		elif global_position.x <= point2 && direction == 1 && !$StateMachine.attack:
			$AnimatedSprite.flip_h = true
			$CollisionShape2D.global_position.x = global_position.x - 25
			attack = false
		else:
			motion.x = 0
		
		if global_position.x <= point1 && !$StateMachine.attack:
			direction = 1
		elif global_position.x >= point2 && !$StateMachine.attack:
			direction = -1
			
		if target != null:
			var distance = target.global_position.x - global_position.x
			
			if distance < 0:
				distance *= -1
			#stop distance
			if direction == -1 && distance < 50:
				motion.x = STOP
			elif direction == 1 && distance < 90:
				motion.x = STOP
			else:
				if !$StateMachine.attack:
					motion.x = direction * SPEED
		else:
			if !$StateMachine.attack:
				motion.x = direction * SPEED

		motion = move_and_slide(motion, UP)
	else:
		$AnimatedSprite.play("Idle")

func _on_Range_body_entered(body):
	in_range = true
	target = body

func _on_Range_body_exited(_body):
	in_range = false
	
func _play_anim(anim):
	$AnimatedSprite.play(anim)

func _on_Attack_left_body_entered(body):
	if body.player:
		body.kill()

func _on_Attack_right_body_entered(body):
	if body.player:
		body.kill()


func _on_DmgTaken_timeout():
	if take_dmg:
		take_dmg = false
		$DmgTaken.stop()
	
func flash():
	if take_dmg == true && $DmgTaken.get_time_left() == 0 :
		$AnimatedSprite.material.set_shader_param("flash_modifier", 1)
		$DmgTaken.start()
	elif take_dmg == false:
		$AnimatedSprite.material.set_shader_param("flash_modifier", 0)
		
		
		
		
		
		
		
		
		
		
		
		
		

extends Area2D
var parent
var parent_flip
func _ready():
	parent = get_parent()
	
	
func _physics_process(_delta):
	pass
	
func _on_JumpIndicator_body_exited(_body):
	#if parent.is_mage:
	#	if parent.motion.y == 0 && parent.child_two.global_position.y <= parent.global_position.y:
	#		parent.motion.y = parent.JUMP
	if parent.motion.y == 0:
		parent.motion.y = parent.JUMP

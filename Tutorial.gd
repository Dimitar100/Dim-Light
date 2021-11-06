extends Node2D

var started = false

func _ready():
	$Player/Camera2D.current = true
	$Mage.start = true
	started = true
	$Player.start = true
	
func _process(_delta):
	pass
	

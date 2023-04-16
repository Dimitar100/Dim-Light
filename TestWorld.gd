extends Node2D

var started = true
#default clear clour #564d4d

func _ready():
	pass
	$CanvasModulate.visible = true
	$Player/Camera2D.current = true
	$Mage.start = true
	$Enemy.start = true
	started = true
	$Player.start = true
	$CaveMusic.stream_paused = false
	
func _process(_delta):
	if started:
		pass
		
	



extends Node

var started = false

func _ready():
	pass
	
func _process(_delta):
	
	if $UI/PlayBtn.started && !started:
		$UICamera.current = false
		$Player/Camera2D.current = true
		$Mage.start = true
		$Enemies/Enemy.start = true
		
		$UI.visible = false
		started = true
		$Player.start = true
	


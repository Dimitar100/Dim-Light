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
		$Enemies/Enemy2.start = true
		$Enemies/Enemy3.start = true
		$Enemies/Enemy4.start = true
		
		$UI/PlayBtn/.visible = false
		$UI/QiutBtn.visible = false
		started = true
		$Player.start = true
	


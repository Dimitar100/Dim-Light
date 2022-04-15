extends Node

var started = false

func _ready():
	pass
	$CanvasModulate.visible = true
	
func _process(_delta):
	
	if $UI/PlayBtn.started && !started:
		$UICamera.current = false
		$Player/Camera2D.current = true
		$Mage.start = true
		$Enemies/Enemy.start = true
		$Enemies/Enemy2.start = true
		
		$UI.visible = false
		started = true
		$Player.start = true
	


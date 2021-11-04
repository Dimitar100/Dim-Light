extends Node

var started = false

func _ready():
	$End.visible = false
	
func _process(_delta):
	
	if $UI/PlayBtn.started && !started:
		$UICamera.current = false
		$Player/Camera2D.current = true
		$Mage.start = true
		$Enemies/Enemy.start = true
		$Enemies/Enemy2.start = true
		$Enemies/Enemy3.start = true
		$Enemies/Enemy4.start = true
		$Player.start = true
			
		$UI/PlayBtn/CollisionShape2D.disabled = true
		$UI/PlayBtn/Sprite.visible = false
		$UI/PlayBtn/Sprite2.visible = false
		started = true
	


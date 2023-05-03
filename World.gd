extends Node

var started = false
#default clear clour #564d4d

func _ready():
	pass
	$CanvasModulate.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _process(_delta):
	
	if $UI/PlayBtn.started && !started:
		$Player.position.x = -1706
		$Player.position.y = 450
		$Mage.position.x = -1850
		$Mage.position.y = 450
		
		$UICamera.current = false
		$Player/Camera2D.current = true
		$Mage.start = true
		$Enemies/Enemy.start = true
		$Enemies/Enemy2.start = true
		$Enemies/Enemy3.start = true
		
		$UI.visible = false
		started = true
		$Player.start = true
		$MenuMusic.stream_paused = true
		$CaveMusic.stream_paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	


extends Node2D

var started = false

func _ready():
	$Player/Camera2D.current = true
	$Player.start = true
	$Enemy.start = true
	$CanvasModulate.visible = true
	$CaveMusic.stream_paused = false
	
func _process(_delta):
	
	if Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_up"):
		$Mage.start = true
		started = true
		
	#pass
	

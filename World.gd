extends Node

var started = false

func _ready():
	$End.visible = false
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_right") && !started:
		$UICamera.current = false
		$Player/Camera2D.current = true
		$Mage.start = true
		$Enemies/Enemy.start = true
		$Enemies/Enemy2.start = true
		$Enemies/Enemy3.start = true
		$Enemies/Enemy4.start = true
		started = true



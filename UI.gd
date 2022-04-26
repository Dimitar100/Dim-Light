extends Node2D

enum Modes{MAIN, LEVELS}
var Mode = Modes.MAIN

func _ready():
	pass

func _process(_delta):
	match Mode:
		Modes.MAIN:
			$PlayBtn.visible = true
			$QiutBtn.visible = true
			$TutorailButton.visible = true
			$Sprite.visible = true
			
			$lvl00.visible = false
			$lvl01.visible = false
			$lvl02.visible = false
			$lvl03.visible = false
			$lvl04.visible = false
			$Back.visible = false
		Modes.LEVELS:
			$PlayBtn.visible = false
			$QiutBtn.visible = false
			$TutorailButton.visible = false
			$Sprite.visible = false
			
			$lvl00.visible = true
			$lvl01.visible = true
			$lvl02.visible = true
			$lvl03.visible = true
			$lvl04.visible = true
			$Back.visible = true


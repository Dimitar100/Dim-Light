extends CanvasLayer

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		$Dialogue.visible = false

func _on_LinkButton_pressed():
	$Dialogue.visible = false

func set_text(var text):
	$Dialogue/Text.text = text


func _on_Timer_timeout():
	$Dialogue.visible = false
	$Timer.stop()

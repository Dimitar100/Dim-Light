extends CanvasLayer



func _on_LinkButton_pressed():
	$Dialogue.visible = false

func set_text(var text):
	$Dialogue/Text.text = text


func _on_Timer_timeout():
	$Dialogue.visible = false
	$Timer.stop()

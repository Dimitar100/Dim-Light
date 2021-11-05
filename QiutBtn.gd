extends Area2D

var started = false

func _on_QiutBtn_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		get_tree().quit()


func _on_QiutBtn_mouse_entered():
	if !started:
		$Sprite2.visible = true
		$Sprite.visible = false

func _on_QiutBtn_mouse_exited():
	if !started:
		$Sprite.visible = true
		$Sprite2.visible = false

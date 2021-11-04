extends Area2D

var started = false
		
func _on_PlayBtn_mouse_entered():
	if !started:
		$Sprite2.visible = true
		$Sprite.visible = false

func _on_PlayBtn_mouse_exited():
	if !started:
		$Sprite.visible = true
		$Sprite2.visible = false

func _on_PlayBtn_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		started = true

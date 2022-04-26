extends TextureButton

var started = false

func _on_PlayButton_pressed():
	#started = true
	visible = false
	get_parent().get_node("QiutBtn").visible = false
	get_parent().get_node("TutorailButton").visible = false
	get_parent().get_node("Sprite").visible = false
	
	get_parent().get_node("lvl00").visible = true
	get_parent().get_node("lvl01").visible = true
	get_parent().get_node("lvl02").visible = true
	get_parent().get_node("lvl03").visible = true
	get_parent().get_node("lvl04").visible = true
	get_parent().get_node("Back").visible = true

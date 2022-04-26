extends TextureButton




func _on_Back_pressed():
	
	get_parent().get_node("PlayBtn").visible = true
	get_parent().get_node("QiutBtn").visible = true
	get_parent().get_node("TutorailButton").visible = true
	get_parent().get_node("Sprite").visible = true
	visible = false
	get_parent().get_node("lvl00").visible = false
	get_parent().get_node("lvl01").visible = false
	get_parent().get_node("lvl02").visible = false
	get_parent().get_node("lvl03").visible = false
	get_parent().get_node("lvl04").visible = false
	

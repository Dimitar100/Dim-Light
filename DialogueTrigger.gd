extends Area2D

var text = "Oh no!!! You must defeat the Undead warrior or else we can't continue forward..."

func _on_DialogueTrigger_body_entered(body):
	body.start = false
	body.dialogue(text)
	queue_free()

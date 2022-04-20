extends Area2D

var text = "Oh no!!! You must kill te Undead warrior before we continue forward...Good luck!"

func _on_DialogueTrigger_body_entered(body):
	body.start = false
	body.dialogue(text)
	queue_free()

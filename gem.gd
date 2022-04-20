extends Area2D



func _on_Gem_body_entered(body):
	queue_free()# Replace with function body.
	body.call_mage()

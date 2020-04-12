extends Area2D

func _on_Poop_body_entered(body):
	if body.name == "Human":
		queue_free()

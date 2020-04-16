extends Area2D

signal poop_touched

func _on_Poop_body_entered(body):
	if body.name == "Human":
		emit_signal("poop_touched")
		queue_free()

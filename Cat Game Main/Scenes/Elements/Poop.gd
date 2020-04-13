extends Area2D

func _on_Poop_body_entered(body):
	if body.name == "Human":
		var human_node = get_parent().get_parent().get_node("Human")
		human_node.set_physics_process(false)
		yield(get_tree().create_timer(10), "timeout")
		human_node.set_physics_process(true)
		queue_free()

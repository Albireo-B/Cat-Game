extends Area2D

onready var cat = get_parent().get_node("../Characters/Cat")

func _on_Food_body_entered(body):
	if body.name == "Cat":
		get_tree().queue_delete(self)
		cat.food += 30
		
		

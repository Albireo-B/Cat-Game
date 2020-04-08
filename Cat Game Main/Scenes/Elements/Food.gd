extends Area2D

onready var cat = $"../../Cat"

func _on_Food_body_entered(body):
	if body.name == "Cat":
		queue_free()
		var new_cat_food = cat.food + 30
		if new_cat_food > 100:
			cat.food = 100
		else :
			cat.food = new_cat_food

extends Node2D


onready var room_list = Array()
onready var collider_list = Array()
onready var rand = RandomNumberGenerator.new()
onready var food_scene = preload("res://Scenes/Elements/Food.tscn")


func _ready():
	rand.randomize()
	
	for room_id in range (0, get_child_count()):
		room_list.append(get_child(room_id))
		
	for room_node in room_list:
		var room_rect = room_node.get_node("FoodSpawningArea/FoodSpawningRectangle")
		var area_size = room_rect.shape.extents
		for i in range (0,2):
			var food = food_scene.instance()
			var x = rand.randf_range(0 - area_size.x, area_size.x)
			var y = rand.randf_range(0 - area_size.y, area_size.y)
			food.transform.origin.x = room_node.transform.origin.x + x
			food.transform.origin.y = room_node.transform.origin.y + y
			get_node("../../GameControl/FoodElements").add_child(food)

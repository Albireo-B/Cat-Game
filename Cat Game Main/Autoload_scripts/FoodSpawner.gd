extends Node

onready var room_list : Array
onready var collider_list : Array
onready var rand = RandomNumberGenerator.new()
onready var food_scene = preload("res://Scenes/Elements/Food.tscn")
onready var rooms = get_tree().get_current_scene().get_node("GameControl/Rooms")

func _ready():
	
	
	
	for room_id in range (0, rooms.get_child_count()):
		room_list.append(rooms.get_child(room_id))

	for room_node in room_list:
#		print(room_node.get_world_2d().get_direct_space_state())
		var area_size = room_node.get_node("FoodSpawningArea/FoodSpawningRectangle").shape.extents
		for i in range (0,2):
			var food = food_scene.instance()
			rand.randomize()
			var x = rand.randf_range(0,area_size.x)
			rand.randomize()
			var y = rand.randf_range(0,area_size.y)
			food.position.x = x
			food.position.y = y
#			food.connect("body_entered", food, "_on_Food_body_entered")
			get_tree().get_current_scene().get_node("GameControl/FoodElements").add_child(food)



extends KinematicBody2D

onready var player = $"../Cat"
onready var sprite = $"Body"
onready var nav_2D = $"../../HouseControl/Navigation2D"

export (float) var speed

var move_distance
var new_path = PoolVector2Array()
var path = PoolVector2Array()
var is_cat_touched = false
var anim = "idle"
var cat_covered = false
var target_position
var initial_position = Vector2(-700,230)

#update human properties
func control():
	
	if !check_poops():
		if !cat_covered:
			target_position = player.position
		else:
			target_position = initial_position
	new_path = nav_2D.get_simple_path(position,target_position)
	path = new_path
	set_animations(target_position)

func set_animations(target_position):
	var diff = position - target_position
	if (diff.x == 0 and diff.y == 0):
		anim = "idle"
	else :
		if diff.x >= -80 and diff.x <= 80 and diff.y >0 :
			anim = "walking_forward"
		elif diff.x > 0:
			anim = "walking_left"
		elif diff.x < 0:
			anim = "walking_right"


	
#	Check if a poop exist, and if yes, got to it direction and return true. Otherwise return false
func check_poops() :
	var all_poops = $"../Poops"
	if all_poops.get_child_count() != 0:
		target_position = all_poops.get_child(0).position
		return true
	else :
		return false

func _physics_process(delta):
	control()
	if path.size() != 0:
		move_distance = speed * delta
		move_along_path(move_distance)
	sprite.play(anim)

func move_along_path(distance):
	var start_point = position
	for i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0 :
			position = start_point.linear_interpolate(path[0],distance/distance_to_next)
			break
		elif distance < 0:
			position = path[0]
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
	
func _on_Cat_cat_covered(cat_cov):
	cat_covered = cat_cov

func collect_poop():
	sprite.play("poop_collecting")
	set_physics_process(false)
	yield(get_tree().create_timer(10), "timeout")
	set_physics_process(true)

func _on_HumanArea_body_entered(body):
	print(body)
	if body.name == "Cat":
		is_cat_touched = true
		set_physics_process(false)
		$"../Cat".game_over()

extends KinematicBody2D

onready var player = get_parent().get_node("Cat")
onready var sprite = get_node("Body")

var react_time = 400
var velocity = Vector2(0,0)
var direction = Vector2(0,0)
var next_direction = Vector2(0,0)
var next_direction_time = 0
export (float) var speed
var is_cat_touched = false
var anim = "idle"

func _ready():
	pass
	
#update human properties
func control():
	#set human velocity
	velocity = Vector2()


#	                      X
	if player.position.x > position.x and next_direction.x != 1:
		next_direction.x = 1
		next_direction_time = OS.get_ticks_msec() + react_time
	elif player.position.x < position.x and next_direction.x != -1:
		next_direction.x = -1
		next_direction_time = OS.get_ticks_msec() + react_time
	elif player.position.x == position.x and next_direction.x != 1:
		next_direction.x = 1
		next_direction_time = OS.get_ticks_msec() + react_time	

#	                      Y
	if player.position.y > position.y and next_direction.y != 1:
		next_direction.y = 1
		next_direction_time = OS.get_ticks_msec() + react_time

	elif player.position.y < position.y and next_direction.y != -1:
		next_direction.y = -1
		next_direction_time = OS.get_ticks_msec() + react_time

	elif player.position.y == position.y and next_direction.y != 0:
		next_direction.y = 0
		next_direction_time = OS.get_ticks_msec() + react_time
	
	if next_direction.x != direction.x or next_direction.y != direction.y:
		is_cat_touched = true
		
	if OS.get_ticks_msec() < next_direction_time:
		direction.x = next_direction.x
		direction.y = next_direction.y
	
	velocity = direction * speed

#	set animations
	if velocity.x == 0 && velocity.y == 0 or is_cat_touched :
		anim = "idle"
	else :
		if velocity.x > 0 :
			anim = "walking_right"
		elif velocity.x < 0:
			anim = "walking_left"
		elif velocity.y < 0 :
			anim = "walking_forward"



	
func _physics_process(delta):
	control()
	check_cat_collision(move_and_slide(velocity))
	sprite.play(anim)
	
func check_cat_collision(body):
	if get_slide_count() > 0:
		if get_slide_collision(get_slide_count()-1).get_collider().name == "Cat":
			is_cat_touched = true
			set_physics_process(false)
			get_parent().get_node("Cat").game_over()


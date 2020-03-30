extends KinematicBody2D

signal food_changed
signal energy_changed

onready var sprite = get_node("Body")

export (float) var speed
export (float) var rotation_speed
export (int) var energy
export (int) var food

var velocity = Vector2()
var anim = "idle"
var can_move = true
#var can_eat ??

func _ready():
	pass
	#set Energy and Food ??
	
func control(delta):
	var rotation_direction = 0
	if Input.is_action_pressed("turn_right"):
		rotation_direction += 1
	if Input.is_action_pressed("turn_left"):
		rotation_direction -= 1
	rotation += rotation_direction * rotation_speed * delta
	velocity = Vector2()
	if Input.is_action_pressed("move_forward"):
		velocity = Vector2(speed, 0).rotated(rotation)
	if Input.is_action_pressed("move_backward"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	#set animation
	if velocity.x == 0:
		anim = "idle"
	else :
		if velocity.x > 0:
			anim = "walking_right"
		if velocity.x < 0:
			anim = "walking_left"
		else:
			pass
	
func _physics_process(delta):
	if not can_move:
		return
	control(delta)
	move_and_slide(velocity)
	sprite.play(anim)

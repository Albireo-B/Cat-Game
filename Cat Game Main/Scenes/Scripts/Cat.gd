extends KinematicBody2D

signal food_changed
signal energy_changed

onready var sprite = get_node("Body")

export (float) var speed
const max_energy = 100
const max_food = 100

var energy
var food = 0 # =0 to remove
var velocity = Vector2()
var anim = "idle"
var can_move = true
#var can_eat ??

func _ready():
	#set Energy and Food ??
	energy = max_energy
	
func control(delta):
	var is_moving = false
	var energy_dec = 0
	var is_exhausted = false
	velocity = Vector2()
	if can_move:
		is_moving = false
		if Input.is_action_pressed("move_right"):
			velocity += Vector2(speed, 0)
			energy_dec = 0.05
			is_moving = true
		if Input.is_action_pressed("move_left"):
			velocity += Vector2(-speed, 0)
			energy_dec = 0.05
			is_moving = true
		if Input.is_action_pressed("move_forward"):
			velocity += Vector2(0, -speed)
			energy_dec = 0.05
			is_moving = true
		if Input.is_action_pressed("move_backward"):
			velocity += Vector2(0, speed)
			energy_dec = 0.05
			is_moving = true
		if Input.is_action_pressed("running") and (velocity.x != 0 or velocity.y !=0):
			velocity += velocity
			energy_dec = 0.25
			is_moving = true
		if energy <= 100 and not is_moving:
			energy_dec = -0.05
	else:
		energy_dec = -0.05
	energy -= energy_dec
	emit_signal("energy_changed",energy)
	emit_signal("food_changed",food)
	#set can move and can eat ??? 
	if energy <= 0 or is_exhausted:
		can_move = false
	elif energy < 10:
		is_exhausted = true
	else:
		can_move = true
	#set animation
	if velocity.x == 0 && velocity.y == 0:
		anim = "idle"
	else :
		if velocity.x > 0:
			anim = "walking_right"
		elif velocity.x < 0:
			anim = "walking_left"
		elif velocity.y > 0:
			anim = "walking_backward"
		else:
			anim = "walking_forward"
	
func _physics_process(delta):
	control(delta)
	if can_move:
		move_and_slide(velocity)
	sprite.play(anim)

extends KinematicBody2D
class_name Cat

signal food_changed
signal energy_changed
signal cat_covered


onready var poop_scene = preload("res://Scenes/Elements/Poop.tscn")
onready var sprite = get_node("Body")

export (float) var speed

const max_energy = 100
const max_food = 100
const defecate_food_amount = 75

var energy
var food = 0
var velocity = Vector2()
var anim = "idle"
var can_move = true
var can_shit = true

func _ready():
	energy = max_energy
	food = max_food/2
	
#update cat properties
func control():
	var is_moving = false
	var energy_dec = 0
	var food_dec = 0.008
	var is_exhausted = false
	velocity = Vector2()
	#set cat velocity and energy
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
	food -= food_dec
	#set food if cat shitting and instanciate shit
	if can_shit:
		if Input.is_action_just_pressed("defecating"):
			food -= defecate_food_amount
			instanciatePoop()
	#emit signals for energy and food bars
	emit_signal("energy_changed",energy)
	emit_signal("food_changed",food)
	#set movement limitations
	if energy <= 0 or is_exhausted:
		can_move = false
	elif energy < 10:
		is_exhausted = true
	else:
		can_move = true
	#set food limitation (for movement and defecating)
	if food <=0 and (velocity.x != 0 or velocity.y !=0):
		velocity /= 2
	elif food < defecate_food_amount:
		can_shit = false
	elif food >= defecate_food_amount:
		can_shit = true
	#set animations
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
	control()
	if can_move:
		move_and_slide(velocity)
	sprite.play(anim)

func instanciatePoop():
	var new_poop = poop_scene.instance()
	#set poop position
	if velocity.x == 0 && velocity.y == 0:
		new_poop.position.x = position.x
		new_poop.position.y = position.y + 40
	else :
		new_poop.position.x = position.x - velocity.x/3.5
		new_poop.position.y = position.y - velocity.y/3.5
	new_poop.connect("poop_touched",get_node("../Human"),"collect_poop")
	get_parent().get_node("Poops").add_child(new_poop)
	
func game_over():
	set_physics_process(false)
	get_node("GameOverAnimations").play("GameOverFadingAndText")

func _on_RetryText_gui_input(event):
		if event.is_pressed():
			get_tree().reload_current_scene()
			
func _on_QuitGameText_gui_input(event):
		if event.is_pressed():
			get_tree().quit()

func _on_Area2D_body_entered(body):
	if body.name == "Cat":
		emit_signal("cat_covered", true)

func _on_Area2D_body_exited(body):
	if body.name == "Cat":
		emit_signal("cat_covered", false)

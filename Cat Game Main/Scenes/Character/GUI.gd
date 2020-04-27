extends MarginContainer

onready var energyBar = $Bars/EnergyBarArea/EnergyBar
onready var energyText = $Bars/EnergyBarArea/EnergyText
onready var foodBar = $Bars/FoodBarArea/FoodBar
onready var foodText = $Bars/FoodBarArea/FoodText
onready var energy_tween = $EnergyTween
onready var energy_tween_low = $EnergyTweenLow
onready var food_tween_low = $FoodTweenLow
onready var food_tween = $FoodTween

var energy_flashed = false
var food_flashed = false
var energy_time = 0
var food_time = 0

func _ready():

	var cat_max_energy = $"../../GameControl/Cat".max_energy
	var cat_max_food = $"../../GameControl/Cat".max_food
	energyBar.max_value = cat_max_energy
	energyBar.max_value = cat_max_food
	update_energy(cat_max_energy)
	update_food(cat_max_food)

func _on_Cat_energy_changed(cat_energy):
	update_energy(cat_energy)
	
func _on_Cat_food_changed(cat_food):
	update_food(cat_food)
	
func update_energy(new_value):
	energy_tween.interpolate_property(energyBar,"value",energyBar.value,new_value,0.001,Tween.TRANS_LINEAR)
	energy_tween.start()

	#Animating the energy bar when the energy is low
	energy_time += 1
	if energyBar.value <= 10 and energy_time > 20:
		energy_time = 0
		if energy_flashed:
			energy_flashed = false
			energy_tween_low.interpolate_property(energyText,"modulate",energyText.modulate,Color(1,1,1,1),0.75,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		else:
			energy_flashed = true
			energy_tween_low.interpolate_property(energyText,"modulate",energyText.modulate, Color("#7a00ff"),0.75,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		energy_tween_low.start()
	elif energy_flashed and energy_time > 30:
		energy_flashed = false
		energy_tween_low.interpolate_property(energyText,"modulate",energyText.modulate,Color(1,1,1,1),0.75,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		energy_tween_low.start()
		
func update_food(new_value):
	if abs(foodBar.value - new_value) > 10:
		food_tween.interpolate_property(foodBar,"value",foodBar.value,new_value,0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	else :
		food_tween.interpolate_property(foodBar,"value",foodBar.value,new_value,0.001,Tween.TRANS_LINEAR)
	food_tween.start()
	
	#Animating the food bar when the food is low
	food_time += 1
	if foodBar.value <= 10 and food_time > 20:
		food_time = 0
		if food_flashed:
			food_flashed = false
			food_tween_low.interpolate_property(foodText,"modulate",foodText.modulate,Color(1,1,1,1),0.75,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		else:
			food_flashed = true
			food_tween_low.interpolate_property(foodText,"modulate",foodText.modulate, Color.red,0.75,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		food_tween_low.start()
	elif food_flashed and food_time > 30:
		food_flashed = false
		food_tween_low.interpolate_property(foodText,"modulate",foodText.modulate,Color(1,1,1,1),0.75,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		food_tween_low.start()



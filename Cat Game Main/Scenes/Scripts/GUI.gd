extends MarginContainer

onready var energyBar = $Bars/EnergyBar
onready var foodBar = $Bars/FoodBar
onready var tween = $Tween

func _ready():
	var cat_max_energy = $"../Characters/Cat".max_energy
	var cat_max_food = $"../Characters/Cat".max_food
	energyBar.max_value = cat_max_energy
	energyBar.max_value = cat_max_food
	update_energy(cat_max_energy)
	update_food(cat_max_food)

func _on_Cat_energy_changed(cat_energy):
	update_energy(cat_energy)
	
func _on_Cat_food_changed(cat_food):
	update_food(cat_food)
	
func update_energy(new_value):
	energyBar.value = new_value

func update_food(new_value):
	foodBar.value = new_value

extends MarginContainer

onready var energyBar = $Bars/EnergyBar
onready var foodBar = $Bars/FoodBar
onready var tween = $Tween
#var animated_energy = 0

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
#	tween.interpolate_property(self, "animated_energy", animated_energy, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
#	if not tween.is_active():
#		tween.start()
	energyBar.value = new_value
	print(energyBar.value)

func update_food(new_value):
	foodBar.value = new_value
#
#func _process(delta):
#	energyBar.value = round(animated_energy)

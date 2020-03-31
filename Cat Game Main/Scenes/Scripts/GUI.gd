extends MarginContainer

onready var energyBar = $Bars/EnergyBar/TextureProgress
onready var tween = $Tween

func _ready():
	var cat_max_energy = $"../Characters/Cat".max_energy
	energyBar.max_value = cat_max_energy
	update_energy(cat_max_energy)

func _on_Cat_energy_changed(cat_energy):
	update_energy(cat_energy)
	
func update_energy(new_value):
	energyBar.value = new_value
	print(energyBar.value)



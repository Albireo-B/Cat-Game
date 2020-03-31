extends MarginContainer

onready var number_label = $Bars/EnergyBar/Count/Background/Number
onready var energyBar = $Bars/EnergyBar/TextureProgress
onready var tween = $Tween

func _ready():
	var cat_max_energy = $"../Characters/Cat".max_energy
	energyBar.max_value = cat_max_energy

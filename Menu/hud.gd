extends Control


@onready var EngineProgressBar = %EngineProgressBar
@onready var FuelProgressBar = %FuelProgressBar


func _ready():
	EVENT.on_engine_power_change.connect(
		func(value):
			EngineProgressBar.value = value
	)
	
	EVENT.on_engine_fuel_change.connect(
		func(value):
			FuelProgressBar.value = value
	)

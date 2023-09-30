extends Control


@onready var EngineProgressBar = %EngineProgressBar
@onready var FuelProgressBar = %FuelProgressBar
@onready var ScoreLabel = %ScoreLabel


func _ready():
	EVENT.on_engine_power_change.connect(
		func(value):
			EngineProgressBar.value = value
	)
	
	EVENT.on_engine_fuel_change.connect(
		func(value):
			FuelProgressBar.value = value
	)
	
	EVENT.on_rocket_at_orbit.connect(
		func(value):
			ScoreLabel.text = "Orbiting satellite : " + str(value)
	)

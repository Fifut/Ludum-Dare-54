extends Control


@onready var EngineProgressBar = %EngineProgressBar


func _ready():
	EVENT.on_engine_power_change.connect(
		func(value):
			EngineProgressBar.value = value
	)

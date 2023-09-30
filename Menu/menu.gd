extends Control


signal on_start


@onready var EarthSprite = %EarthSprite
@onready var SatelliteNode = %SatelliteNode
@onready var SatelliteSprite = %SatelliteSprite

@onready var HomeContainer = %HomeContainer
@onready var HowToContainer = %HowToContainer
@onready var SettingsContainer = %SettingsContainer
@onready var SoundSlider = %SoundSlider

@onready var MenuAnimation = %MenuAnimation


var master_bus


func _ready():
	randomize()
	
	HomeContainer.show()
	HowToContainer.hide()
	SettingsContainer.hide()
	
	master_bus = AudioServer.get_bus_index("Master")
	SoundSlider.value = AudioServer.get_bus_volume_db(master_bus)


func _process(delta):
	SatelliteNode.rotation_degrees += delta * 5
	if SatelliteNode.rotation_degrees > 30:
		SatelliteNode.rotation_degrees = -25
		SatelliteSprite.rotation_degrees = randi_range(0, 360)
		SatelliteSprite.self_modulate = Color(randf_range(0.5, 1.0), randf_range(0.5, 1.0), randf_range(0.5, 1.0))


func _on_start_button_pressed():
	MenuAnimation.play("Rotation_start")
	await MenuAnimation.animation_finished
	on_start.emit()


func _on_how_to_button_pressed():
	SettingsContainer.hide()
	HowToContainer.show()
	MenuAnimation.play("Rotation")


func _on_settings_button_pressed():
	HowToContainer.hide()
	SettingsContainer.show()
	MenuAnimation.play("Rotation")


func _on_exit_button_pressed():
	get_tree().quit()


func _on_back_button_pressed():
	MenuAnimation.play_backwards("Rotation")


func _on_sound_slider_value_changed(value):
	if value <= -20:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
		AudioServer.set_bus_volume_db(master_bus, value)

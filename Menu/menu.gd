extends Control


signal on_start


@onready var EarthSprite = %EarthSprite
@onready var SatelliteNode = %SatelliteNode

@onready var HomeContainer = %HomeContainer
@onready var HowToContainer = %HowToContainer
@onready var SettingsContainer = %SettingsContainer

@onready var MenuAnimation = %MenuAnimation


func _ready():
	HomeContainer.show()
	HowToContainer.hide()


func _process(delta):
	SatelliteNode.rotation_degrees += delta * 5
	if SatelliteNode.rotation_degrees > 30:
		SatelliteNode.rotation_degrees = -25


func _on_start_button_pressed():
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

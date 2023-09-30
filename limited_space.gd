extends Node2D


@onready var MenuCanvasLayer = %MenuCanvasLayer
@onready var Game = %Game
@onready var HUDCanvasLayer = %HUDCanvasLayer


func _ready():
	Game.set_process(false)
	Game.set_physics_process(false)
	Game.hide()
	HUDCanvasLayer.hide()
	MenuCanvasLayer.show()



func _on_menu_container_on_start():
	Game.set_process(true)
	Game.set_physics_process(true)
	MenuCanvasLayer.hide()
	HUDCanvasLayer.show()
	Game.show()

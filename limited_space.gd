extends Node2D


@onready var MenuCanvasLayer = %MenuCanvasLayer
@onready var Game = %Game


# Called when the node enters the scene tree for the first time.
func _ready():
	Game.set_process(false)
	Game.set_physics_process(false)
	Game.hide()
	MenuCanvasLayer.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_menu_container_on_start():
	Game.set_process(true)
	Game.set_physics_process(true)
	MenuCanvasLayer.hide()
	Game.show()

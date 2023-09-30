extends Node2D

@onready var Earth = %Earth


func _on_rocket_at_orbit(rocket_position, rocket_rotation):
	var satellite = preload("res://Satellite/satellite.tscn").instantiate()
	satellite.orbit = rocket_position - Earth.global_position
	satellite.global_position = Earth.global_position
	
	add_child(satellite)

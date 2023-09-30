extends Node2D

@onready var Earth = %Earth

var deplayable = null


func _process(delta):
	
	if Input.is_action_just_pressed("Deploy") and deplayable:
		var satellite = preload("res://Satellite/satellite.tscn").instantiate()
		satellite.altitude = Earth.global_position - deplayable.global_position
		satellite.global_position = Earth.global_position
		satellite.global_rotation_degrees = deplayable.global_rotation_degrees
		
		add_child(satellite)
		
		if deplayable.has_method("remove"):
			deplayable.remove()


func _on_orbit_area_overlapping(area):
	deplayable = area

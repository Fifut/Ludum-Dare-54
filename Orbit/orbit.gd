extends Node2D


@onready var OrbitAnimationPlayer = %OrbitAnimationPlayer


func _ready():
	hide()
	
	var orbit_altitude = randf_range(0.5, 1.2)
	scale = Vector2(orbit_altitude, orbit_altitude)
	
	OrbitAnimationPlayer.play("fadein")
	await OrbitAnimationPlayer.animation_finished
	OrbitAnimationPlayer.play("flash")


func remove():
	OrbitAnimationPlayer.stop()
	OrbitAnimationPlayer.play("fadeout")
	await OrbitAnimationPlayer.animation_finished
	hide()
	queue_free()

extends Node2D

@onready var Earth = %Earth
@onready var RocketMarker = %RocketMarker
@onready var EndGame = %EndGame
@onready var rocket_sprite = %RocketSprite
@onready var asteroid_marker = %AsteroidMarker

@onready var satellite_scene = preload("res://Satellite/satellite.tscn")
@onready var rocket_scene = preload("res://Rocket/rocket.tscn")
@onready var orbit_scene = preload("res://Orbit/orbit.tscn")
@onready var asteroid_scene = preload("res://Asteroid/asteroid.tscn")

var orbiting_satellite = 0
var orbit = null


func _ready():
	EndGame.hide()
	_spawn_rocket()
	_spawn_orbit()
	_spawn_asteroid()


func _process(delta):
	var rocket = get_node_or_null("Rocket")
	if rocket:
		rocket_sprite.rotation = rocket.rotation


func _spawn_rocket():
	var rocket = rocket_scene.instantiate()
	rocket.on_rocket_at_orbit.connect(_on_rocket_at_orbit)
	rocket.on_rocket_fail.connect(
		func():
			EndGame.orbiting_satellite = orbiting_satellite
			EndGame.show()
	)
	rocket.position = RocketMarker.position
	rocket.name = "Rocket"
	add_child(rocket)


func _spawn_orbit():
	orbit = orbit_scene.instantiate()
	orbit.global_position = Earth.global_position
	add_child(orbit)


func _spawn_satellite(rocket_position):
	var satellite = satellite_scene.instantiate()
	satellite.orbit = rocket_position - Earth.global_position
	satellite.global_position = Earth.global_position
	add_child(satellite)


func _spawn_asteroid():
	var asteroid : StaticBody2D = asteroid_scene.instantiate()
	asteroid.global_position = $AsteroidMarker/AsteroidMarker1.global_position
	add_child(asteroid)


func _on_rocket_at_orbit(rocket_position, rocket_rotation):
	orbit.remove()
	_spawn_satellite(rocket_position)
	await get_tree().create_timer(1.0).timeout
	_spawn_rocket()
	_spawn_orbit()
	
	orbiting_satellite += 1
	EVENT.on_rocket_at_orbit.emit(orbiting_satellite)

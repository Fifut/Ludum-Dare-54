extends StaticBody2D

@export var speed = 50
@export var sprite_rotation = 0
@export var orbit = Vector2(500, 0)

@onready var CollisionShape = %CollisionShape2D
@onready var SatelliteSprite = %SatelliteSprite


func _ready():
	SatelliteSprite.self_modulate = Color(randf_range(0.5, 1.0), randf_range(0.5, 1.0), randf_range(0.5, 1.0))
	CollisionShape.position = orbit
	CollisionShape.rotation_degrees = sprite_rotation


func _process(delta):
	rotation_degrees += delta * speed

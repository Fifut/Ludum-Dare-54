extends StaticBody2D

@export var sprite_rotation = 0
@export var orbit = Vector2(500, 0)

@onready var CollisionShape = %CollisionShape2D
@onready var SatelliteSprite = %SatelliteSprite
@onready var SatelliteAnimationPlayer = %SatelliteAnimationPlayer

var speed = 50


func _ready():
	SatelliteSprite.self_modulate = Color(randf_range(0.5, 1.0), randf_range(0.5, 1.0), randf_range(0.5, 1.0))
	CollisionShape.position = orbit
	CollisionShape.rotation_degrees = sprite_rotation
	speed = randi_range(-50, 50)
	
	SatelliteAnimationPlayer.play("fadein")


func _process(delta):
	rotation_degrees += delta * speed

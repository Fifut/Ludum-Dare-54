extends StaticBody2D

@export var speed = 50
@export var altitude = 150

@onready var CollisionShape = %CollisionShape2D


func _ready():
	CollisionShape.position.x = altitude


func _process(delta):
	rotation_degrees += delta * speed

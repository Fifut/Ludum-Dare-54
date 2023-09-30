extends StaticBody2D

@export var speed = 100

func _process(delta):
	rotation_degrees += delta * speed

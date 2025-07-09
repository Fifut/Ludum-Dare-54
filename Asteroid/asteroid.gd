extends StaticBody2D


var _rotation_speed = 0
var _position_speed = 0


func _ready():
	scale.x = randf_range(0.5, 1)
	scale.y = scale.x
	
	_rotation_speed = randi_range(-3,3)
	_position_speed = randi_range(20,50)


func _process(delta):
	rotation += _rotation_speed * delta
	
	position.x += _position_speed * delta
	position.y += _position_speed * delta

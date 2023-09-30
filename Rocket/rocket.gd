extends RigidBody2D


func _input(event):
	if event.is_action_pressed("Fire"):
		linear_velocity.x += 50

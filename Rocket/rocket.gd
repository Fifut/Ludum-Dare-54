extends RigidBody2D


@onready var EngineMarker = %EngineMarker
@onready var RCSMarker = %RCSMarker


func _physics_process(delta):
	pass


func _integrate_forces(state):
		if Input.is_action_pressed("Fire"):
			add_constant_force(Vector2(0, -10), EngineMarker.position)
		else:
			constant_force = Vector2.ZERO
		
		if Input.is_action_just_pressed("Left"):
			add_constant_force(Vector2(-10, 0), RCSMarker.position)
		elif Input.is_action_just_pressed("Right"):
			add_constant_force(Vector2(10, 0), RCSMarker.position)
